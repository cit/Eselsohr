package Eselsohr::I18N::de;

use base 'Eselsohr::I18N';

use utf8;
use feature qw< unicode_strings >;

our %Lexicon = (

    ##
    ## Index
    ##

    username => 'Benutzername',
    password => 'Passwort',
    keep_me_signed_in => 'Eingeloggt bleiben',

    err_index_invalid_login => 'Die Benutzerdaten sind nicht korrekt.',

    ##
    ## Show_all
    ##

    logout => 'Ausloggen',
    next_page => 'Vorwärts »',
    prev_page => '« Zurück',
    date => 'Datum',
    description => 'Beschreibung',
    hostname => 'Hostname',
    id => 'ID',
    size => 'Größe',
    type => 'Typ',
);

1;
