#!/usr/bin/env perl -w

use lib 'lib/';
use FindBin '$Bin';
use feature ':5.10';

use Eselsohr::Model;
use Eselsohr::Model::Bookmarks;
use WWW::Mechanize;
use MIME::Types;
use File::Path;
use FileHandle;

use DateTime::Format::SQLite;

binmode STDOUT, ":utf8";

my $query = 'WHERE cached=? and cache_tries < 5 ORDER BY date DESC';

## Initalize LWP
my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->env_proxy;
$ua->agent('Mozilla/23.42');

for my $bookmark (Eselsohr::Model::Bookmarks->select($query, 0)) {
    say $bookmark->{id};
    say $bookmark->{url};
    say $bookmark->{date};

    my $response = $ua->get($bookmark->{url});

    unless ($response->is_success) {
        say "no success -> increase cache_tries";
        $bookmark->update(cache_tries => ++$bookmark->{cache_tries} );
        next;
    }

    ## Determine the mimetype of the url
    my $type = $response->content_type();
    $type =~ s/charset.*$//;
    my $extension = get_file_extension($type);

    ## Parse the sqlite3 datetime format
    my $dt = DateTime::Format::SQLite->parse_datetime($bookmark->{date});

    ## Create the folder where to save the archive files
    my $folder = $Bin . '/../archive/';
    my $path   = join '/', $bookmark->{user_id}, $dt->ymd('/'), $bookmark->{id},
        $bookmark->{id};
    mkpath($folder . $path);

    ## Create new file and print the content in it
    my $fh = FileHandle->new;
    my $filename = $folder . $path . '/' . $bookmark->{id} . '.' . $extension;
    $fh->open('> ' . $filename);
    print $fh $response->decoded_content;
    $fh->close();
    my $filesize = -s $filename;


    $bookmark->update(cached => 1, size => $filesize, mime => $type, ext => $extension);

}

sub get_file_extension {
    my $type = shift;

    my $mimetypes = MIME::Types->new;
    my MIME::Type $plaintext = $mimetypes->type($type);
    my @ext = $plaintext->extensions;

    return $ext[0];
}
