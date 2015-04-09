use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  VERSION   => '0.01',
  NAME      => 'Eselsohr',
  PREREQ_PM => {
      'Mojolicious'                 => '6.05',
      'ORLite'                      => '1.98',
      'Mojolicious::Plugin::Bcrypt' => '0.14',
      'DateTime'                    => '1.18',
  },
  test      => {TESTS => 't/*.t'}
);
