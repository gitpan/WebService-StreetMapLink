#!/usr/bin/perl -w

use strict;

use Test::More tests => 6;

use WebService::StreetMapLink;

use URI;
use URI::QueryParam;

{
    my $map = WebService::StreetMapLink->new( country => 'singapore',
                                              address => '208 Jalan Besar',
                                              city    => 'Singapore',
                                              state   => 'Singapore',
                                              postal_code => '208894',
                                            );

    my $uri = $map->uri;

    ok( $uri, 'some sort of url was generated' );

    my $obj = $map->uri_object;

    is( $obj->scheme, 'http', 'URL scheme is http' );

    is( $obj->host, 'www.catcha.com.sg', 'URL host is www.catcha.com.sg' );

    is( $obj->path, '/cgi-bin/maps/parseform.cgi', 'URL path is /map.jsp' );

    my %expect = ( postalcode => '208894',
                 );

    while ( my ( $k, $v ) = each %expect )
    {
        is( $obj->query_param($k), $v, "URL query param $k should be $v" );
    }
}

{
    my $map = WebService::StreetMapLink->new( country => 'singapore',
                                              address => '208 Jalan Besar',
                                              city    => 'Singapore',
                                              state   => 'Singapore',
                                            );

    ok( ! $map, 'No map object was returned.' );
}
