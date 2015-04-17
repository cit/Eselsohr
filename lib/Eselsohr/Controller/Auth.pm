package Eselsohr::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller';

use Eselsohr::Model;

## This function gets the username and password as a parameter and
## checks if these values are also in the database.
sub login {
    my $self = shift;

    my $username = $self->param('username') || undef;
    my $password = $self->param('password') || undef;

    my ($user) = Eselsohr::Model::Users->select('WHERE username=?', $username);
    my $crypted_pass = $user->{'password'} || '';

    if ($self->bcrypt_validate($password, $crypted_pass)) {
        ## Valid Login
        $self->set_session_data($user);
        $self->redirect_to('/' . $username);
    }
    else {
        ## Invalid Login
        $self->stash(error => 1);
        $self->render(template => 'core/index', msg => 'login');
    }
}

## This function sets all the session data for a successful login
sub set_session_data {
    my ($self, $user) = @_;

    $self->session(username => $self->param('username'));
    $self->session(user_id  => $user->{'id'});

    ## Check if a user has checked the keep_me_signed_in Option
    if ($self->param('keep_me_signed_in')) {
        $self->session(expiration => 0);
    }
    else {
        $self->session(expiration => $self->config->{expiration});
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
