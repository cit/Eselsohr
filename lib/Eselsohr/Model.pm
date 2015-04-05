package Eselsohr::Model;

use ORLite {
    file         => 'sqlite.db',
    unicode      => 1,
    create       => sub {
        my $dbh = shift;

        $dbh->do('CREATE TABLE users
                      (id       INTEGER PRIMARY KEY,
                       username VARCHAR,
                       password VARCHAR)');

        return 1;
    },
};

1;
