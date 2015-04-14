package Eselsohr::Controller::Bookmarks;
use Mojo::Base 'Mojolicious::Controller';

use DateTime;
use Eselsohr::Model;
use Eselsohr::Model::Bookmarks;

sub show_all {
    my $self    = shift;
    my $user_id = $self->session('user_id');
    my $types   = ['desc', 'host', 'mime'];

    my ($count, $bookmarks) = Eselsohr::Model::Bookmarks->select_all(
        user_id => $user_id,
        query   => q[%] . ($self->param('q') || '') . q[%],
        limit   => $self->config->{results_per_page},
        page    => $self->param('p') || 1,
    );

    $self->stash(
        total     => Eselsohr::Model::Bookmarks->count_all($user_id),
        count     => $count,
        bookmarks => $bookmarks,
        types     => $types,
        username  => $self->session('username'),
    );

    $self->render();
}

sub insert {
    my $self = shift;

    ## Extract the hostname out of the url
    my $host_regex = qr/[a-z0-9-]+(\.[a-z0-9-]+)+/;
    $self->param('url') =~ /(https?|http):\/\/(?<hostname>$host_regex)/;

    Eselsohr::Model::Bookmarks->create(
        user_id => $self->session('user_id'),
        date    => DateTime->now(locale=>'de_DE')->set_time_zone('Europe/Berlin'),
        url     => $self->param('url'),
        host    => $+{hostname},
        desc    => $self->param('desc'),
    );

    $self->redirect_to('/' . $self->session('username'));
}

sub update {
    my $self  = shift;
    my $id    = $self->param('id');
    my $query = 'WHERE id=?';

    my ($bookmark) = Eselsohr::Model::Bookmarks->select($query, $id);
    $bookmark->update(desc => $self->param('desc'));
}

sub delete {
    my $self        = shift;
    my $user_id     = $self->session('user_id');
    my $bookmark_id = $self->param('id');

    Eselsohr::Model::Bookmarks->delete_where('user_id=? AND id=?', $user_id, $bookmark_id);
    $self->redirect_to('/' . $self->session('username'));
}

1;
