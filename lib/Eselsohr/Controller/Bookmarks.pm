package Eselsohr::Controller::Bookmarks;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub show_all {
    my $self = shift;
    my $username = $self->session('username');

    # Render template "example/welcome.html.ep" with message
    $self->stash(username => $username);
    $self->render();
}

1;
