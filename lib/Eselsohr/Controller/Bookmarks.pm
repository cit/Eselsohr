package Eselsohr::Controller::Bookmarks;
use Mojo::Base 'Mojolicious::Controller';

use Eselsohr::Model;
use DateTime;

# This action will render a template
sub show_all {
    my $self = shift;
    my $id   = $self->session('user_id');

    my @bookmarks = Eselsohr::Model::Bookmarks->select_all(
        user_id => $id,
        limit   => $self->config->{results_per_page},
        page    => $self->param('p') || 1,
    );

    $self->stash(
        total     => Eselsohr::Model::Bookmarks->count_all($id),
        bookmarks => \@bookmarks,
        username  => $self->session('username'),
    );

    $self->render();
}

sub insert {
    my $self = shift;

    # extract the hostname out of the url
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
