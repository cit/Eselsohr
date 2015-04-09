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

1;
