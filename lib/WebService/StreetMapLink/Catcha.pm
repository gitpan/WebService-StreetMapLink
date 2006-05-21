package WebService::StreetMapLink::Catcha;

use strict;

use Geography::States;

use base 'WebService::StreetMapLink';


my %Query = ( singapore => {},
            );

my %Host  = ( singapore => 'www.catcha.com.sg',
            );

my %Path  = ( singapore => '/cgi-bin/maps/parseform.cgi',
            );

sub Countries { keys %Query }
__PACKAGE__->RegisterSubclass();

sub new
{
    my $class = shift;
    my %p = @_;

    my %query = %{ $Query{ $p{country} } };

    my $m = "_$p{country}_query";
    $class->$m( \%p, \%query )
        or return;

    return bless { host  => $Host{ $p{country} },
                   path  => $Path{ $p{country} },
                   query => \%query,
                 }, $class;
}

sub _singapore_query
{
    shift;
    my ( $p, $q ) = @_;

    return unless defined $p->{postal_code};

    $q->{postalcode} = $p->{postal_code};

    return 1;
}


1;

__END__

=head1 NAME

WebService::StreetMapLink::Catcha - A WebService::StreetMapLink subclass for catcha.com

=head1 SYNOPSIS

    use WebService::StreetMapLink;

    my $map =
        WebService::StreetMapLink->new
            ( country => 'australia',
              address => '606 Station Street',
              city    => 'Box Hill',
              state   => 'Victoria',
              postal_code => '3128',
            );

    my $uri = $map->uri;

=head1 DESCRIPTION

This subclass generates links to catcha.com.  There are several host
names for this service, each for a different country.

=head1 COUNTRIES

This subclass handles Singapore.

=head1 new() PARAMETERS

For Singapore, all that is required is a "postal_code".

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

