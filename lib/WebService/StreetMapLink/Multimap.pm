package WebService::StreetMapLink::Multimap;

use strict;

use base 'WebService::StreetMapLink';


my %Query = ( switzerland => { db       => 'CH',
                               client   => 'public',
                               advanced => '',
                               overviewmap => '',
                             },
              france      => { db       => 'FR',
                               client   => 'public',
                               advanced => '',
                               overviewmap => '',
                             },
            );

sub Countries { keys %Query }
__PACKAGE__->RegisterSubclass();

sub new
{
    my $class = shift;
    my %p = @_;

    return if grep { ! defined } @p{ qw( address city postal_code ) };

    my %query = %{ $Query{ $p{country} } };

    $query{addr2} = $p{address};

    $query{addr3} = $p{city};

    $query{pc}    = $p{postal_code};

    return bless { host  => 'www.multimap.com',
                   path  => '/map/places.cgi',
                   query => \%query,
                 }, $class;
}


1;

__END__

=head1 NAME

WebService::StreetMapLink::Multimap - A WebService::StreetMapLink subclass for multimap.com

=head1 SYNOPSIS

    use WebService::StreetMapLink;

    my $map =
        WebService::StreetMapLink->new
            ( country => 'switzerland',
              address => 'rue de Paquis 25',
              city    => 'Geneva',
              state   => 'Geneve',
              postal_code => '1201',
            );

    my $uri = $map->uri;

=head1 DESCRIPTION

This subclass generates links to multimap.com.

=head1 COUNTRIES

This subclass handles France and Switzerland.

=head1 new() PARAMETERS

This subclass requires that you provide "address", "city", and
"postal_code" parameters.

=head1 AUTHOR

David Rolsky, C<< <autarch@urth.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-webservice-streetmaplink@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically
be notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2004-2005 David Rolsky, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included
with this module.

=cut
