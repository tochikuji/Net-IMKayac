use strict;
use Test::More;
use Net::IMKayac;

my $obj = new_ok( 'Net::IMKayac' => ['username', 'some_user'] );

done_testing;
