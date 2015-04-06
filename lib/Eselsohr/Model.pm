package Eselsohr::Model;

use ORLite {
    file         => 'sqlite.db',
    unicode      => 1,
    create       => sub {
        my $dbh = shift;

        ## Users table
        $dbh->do('CREATE TABLE users(
                      id       INTEGER PRIMARY KEY
                      ,username VARCHAR
                      ,password VARCHAR
        )');

        ## Bookmarks table
        $dbh->do('CREATE TABLE bookmarks(
                      id       INTEGER PRIMARY KEY
                      ,user_id INTEGER NOT NULL
                      ,date    DATE NOT NULL
                      ,host    VARCHAR(255) NOT NULL
                      ,url     TEXT NOT NULL
                      ,desc    TEXT NOT NULL
                      ,mime    VARCHAR(255)
                      ,ext     VARCHAR(16)
                      ,size    VARCHAR(64)
                      ,cached  INTEGER
        )');

        return 1;
    },

};

package Eselsohr::Model::Bookmarks;

sub count_all {
    my ($self, $id) = @_;

    Eselsohr::Model::Bookmarks->count('WHERE user_id=?', $id);
}

sub select_all {
    my ($self, @args_hash) = @_;
    my $args = { @args_hash };

    my $query  = 'WHERE user_id=? ORDER BY id DESC LIMIT ? OFFSET ?';
    my $offset = (($args->{page} - 1) * $args->{limit});

    Eselsohr::Model::Bookmarks->select($query, $args->{user_id},
        $args->{limit}, $offset);
}


1;
