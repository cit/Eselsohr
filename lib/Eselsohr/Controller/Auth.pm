package Eselsohr::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller';

use Eselsohr::Model;

## This function gets the username and password as a parameter and
## checks if these values are also in the database.
sub login {
    my $self = shift;

    my $username = $self->param('username') || undef;
    my $password = $self->param('password') || undef;

    ## Don't check username and password if one of these parameters is
    ## undefined
    unless ($username or $password) {
        $self->render(msg => 'login');
        return;
    }

    my ($user) = Eselsohr::Model::Users->select('WHERE username=?', $username);
    my $crypted_pass = $user->{'password'} || '';

    if ($self->bcrypt_validate($password, $crypted_pass)) {
        ## Valid Login

        ## Set session data
        $self->session(username   => $username);
        $self->session(expiration => $self->config->{expiration});

        $self->redirect_to('/' . $username);
    }
    else {
        ## Invalid Login
        $self->stash(error => 1);
        $self->render(template => 'core/index', msg => 'login');
    }
}

## This function deletes the session cookie and redirects to login
## page.
sub logout {
    my $self = shift;

    ## Delete the cookie by setting a expiration date in the past
    $self->session(expires => 1);
    $self->redirect_to('/');
}

1;
