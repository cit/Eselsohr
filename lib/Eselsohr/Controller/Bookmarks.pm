package Eselsohr::Controller::Bookmarks;
use Mojo::Base 'Mojolicious::Controller';

use Eselsohr::Model;
use DateTime;

sub show_all {
    my $self  = shift;
    my $id    = $self->session('user_id');
    my $types = ['desc', 'host', 'mime'];

    my ($count, $bookmarks) = Eselsohr::Model::Bookmarks->select_all(
        user_id => $id,
        query   => q[%] . $self->param('q') . q[%],
        limit   => $self->config->{results_per_page},
        page    => $self->param('p') || 1,
    );

    $self->stash(
        total     => Eselsohr::Model::Bookmarks->count_all($id),
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

1;
