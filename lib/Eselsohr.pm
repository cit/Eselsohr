package Eselsohr;
use Mojo::Base 'Mojolicious';

use Mojolicious::Plugin::Bcrypt;
use Mojolicious::Plugin::Config;

sub load_plugins {
    my $self = shift;

    ## Read the config file in
    $self->plugin(Config => {file => 'eselsohr.conf' });

    ## Set settings for bcrypt
    $self->plugin('bcrypt', { cost => 4 });
}

## This method will run once at server start
sub startup {
    my $self = shift;

    $self->load_plugins();

    ## session secret to encrypt the session cookies
    $self->app->secrets(['73ba117e0de616d437080866177c3f90']);

    ## Router
    my $r = $self->routes;

    $r->any('/login')->to('auth#login');
    $r->get('/logout')->to('auth#logout');

    ## Redirect to login if there is no valid username in the session
    ## variable
    my $auth = $r->under( sub {
        my $self = shift;

        unless ($self->session('username')) {
            $self->redirect_to('/login');
        }
    });

    ## Normal route to controller
    $auth->get('/')->to('example#welcome');
    $auth->get('/:username/')->to('bookmarks#show_all');
}

1;
