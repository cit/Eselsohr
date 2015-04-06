use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use Eselsohr::Model;

my $t = Test::Mojo->new('Eselsohr');
$t->get_ok('/')->status_is(200);

## Test an login without username
$t->post_ok('/login' => form => {password => 'bar'})
    ->status_is(200)->content_like(qr/invalid/i);

## Test an login without password
$t->post_ok('/login' => form => {username => 'foo'})
    ->status_is(200)->content_like(qr/invalid/i);

## Test an invalid login
$t->post_ok('/login' => form => {username => 'foo', password => 'bar'})
  ->status_is(200)->content_like(qr/invalid/i);

## Add test user to the database
my $testuser = Eselsohr::Model::Users->new(
    username => 'authtestuser',
    password => $t->app->bcrypt('password'),
)->insert;

## Test successful login
$t->post_ok('/login' => form => {username => 'authtestuser', password => 'password'})
  ->status_is(302);

##Delete test user
$testuser->delete;

done_testing();
