#!/usr/bin/perl -w

use strict;

use Test::More tests => 2;

use_ok('WebService::StreetMapLink::MapQuest');

my $map =
    WebService::StreetMapLink::MapQuest->new
        ( country => 'usa',
          address => '100 Some Street',
          city    => 'Testville',
          state   => 'MN',
          postal_code => '12345',
        );

ok( $map, 'can call ->new() on MapQuest subclass directly' );
