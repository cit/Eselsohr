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

    $r->any('/')->to(cb => sub {
        my $c = shift;
        $c->render(template => 'core/index');
    });

    $r->any('/login')->to('auth#login');
    $r->any('/logout')->to('auth#logout');

    ## Redirect to login if there is no valid username in the session
    ## variable
    my $auth = $r->under( sub {
        my $self = shift;

        unless ($self->session('username')) {
            $self->redirect_to('/');
        }
    });

    ## Routes that are only accessible via login
    $auth->get('/:username/')->to('bookmarks#show_all');
    $auth->get('/:username/insert')->to('bookmarks#insert');
    $auth->get('/:username/delete/:id')->to('bookmarks#delete');
}

1;
