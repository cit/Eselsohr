package Eselsohr::I18N::en;

use base 'Eselsohr::I18N';

use utf8;
use feature qw< unicode_strings >;

our %Lexicon = (

    ##
    ## Index
    ##

    username => 'Username',
    password => 'Password',

    err_index_invalid_login => 'Username or password is not correct.',

    ##
    ## Show_all
    ##

    logout => 'Logout',
    next_page => 'Next »',
    prev_page => '« Previous',
    date => 'Date',
    description => 'Description',
    hostname => 'Hostname',
    id => 'ID',
    size => 'Size',
    type => 'Type',

);

1;
