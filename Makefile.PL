use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  VERSION   => '0.01',
  NAME      => 'Eselsohr',
  PREREQ_PM => {
      'Mojolicious' => '6.05',
      'ORLite'      => '1.98',
  },
  test      => {TESTS => 't/*.t'}
);
