#!/usr/bin/perl -w

use strict;

use Test::More tests => 5;

use WebService::StreetMapLink;

use URI;
use URI::QueryParam;

{
    my %p = ( country => 'usa',
              address => '100 Some Street',
              city    => 'Testville',
              state   => 'MN',
              postal_code => '12345',
            );

    my $map = WebService::StreetMapLink->new(%p);

    my $uri = $map->uri;

    ok( $uri, 'some sort of url was generated' );

    my $obj = $map->uri_object;

    is( $obj->scheme, 'http', 'URL scheme is http' );

    is( $obj->host, 'maps.google.com', 'URL host is www.mapquest.com' );

    is( $obj->path, '/maps', 'URL path is /maps/map.adp' );

    my %expect = ( q => join ',', map { $p{$_} } qw( address city state postal_code ) );

    while ( my ( $k, $v ) = each %expect )
    {
        is( $obj->query_param($k), $v, "URL query param $k should be $v" );
    }
}
