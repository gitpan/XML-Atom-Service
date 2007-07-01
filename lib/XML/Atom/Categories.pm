package XML::Atom::Categories;

use warnings;
use strict;
use Carp;

use XML::Atom;
use XML::Atom::Category;
use base qw( XML::Atom::Thing );

__PACKAGE__->mk_attr_accessors(qw( fixed scheme href ));

sub element_name { 'categories' }

sub element_ns { 'http://www.w3.org/2007/app' }

*{XML::Atom::Category::element_ns} = sub {
    $XML::Atom::Util::NS_MAP{$XML::Atom::DefaultVersion}
};

sub XML::Atom::Client::getCategories {
    my $client = shift;
    my($uri) = @_;
    return $client->error("Must pass a ServiceURI before retrieving category document")
        unless $uri;
    my $req = HTTP::Request->new(GET => $uri);
    my $res = $client->make_request($req);
    return $client->error("Error on GET $uri: " . $res->status_line)
        unless $res->code == 200;
    my $categories = XML::Atom::Categories->new(Stream => \$res->content)
        or return $client->error(XML::Atom::Categories->errstr);
    $categories;
}

*XML::Atom::Client::getCategory = \&XML::Atom::Client::getCategories;

1;
__END__

=head1 NAME

XML::Atom::Categories - Atom Category Document object

=head1 SYNOPSIS

  use XML::Atom::Categories;

  my $category = XML::Atom::Category->new;
  $category->scheme('http://example.org/extra-cats/');
  $category->term('joke');

  my $categories = XML::Atom::Categories->new;
  $categories->href('http://example.com/cats/forMain.cats');
  $categories->add_category($category);

  my $xml = $categories->as_xml;

  ## Get a list of the category elements.
  my @category = $categories->category;

  ## Get category document by using XML::Atom::Client
  use XML::Atom::Client;

  my $client = XML::Atom::Client->new;
  my $category = $client->getCategories($category_uri);


=head1 DESCRIPTION

Category Documents contain lists of categories described using the 
"atom:category" element from the Atom Syndication Format [RFC4287].

The Category Document is defined in "The Atom Publishing Protocol," 
IETF Internet-Draft.

=head1 METHODS

=head2 XML::Atom::Categories->new([ $stream ])

Creates a new Category Document object, and if I<$stream> is supplied, fills 
it with the data specified by I<$stream>.

Automatically handles autodiscovery if I<$stream> is a URI (see below).

Returns the new I<XML::Atom::Categories> object. On failure, returns C<undef>.

I<$stream> can be any one of the following:

=over 4

=item * Reference to a scalar

This is treated as the XML body of the feed.

=item * Scalar

This is treated as the name of a file containing the Category Document XML.

=item * Filehandle

This is treated as an open filehandle from which the Category Document XML can be read.

=item * URI object

This is treated as a URI, and the Category Document XML will be retrieved from the URI.

=back

=head2 $categories->category

If called in scalar context, returns an I<XML::Atom::Category> object
corresponding to the first I<E<lt>categoryE<gt>> element found in the Category Document.

If called in list context, returns a list of I<XML::Atom::Category> objects
corresponding to all of the I<E<lt>categoryE<gt>> elements found in the Service Document.

=head2 $service->add_category($category)

Adds the category I<$category>, which must be an I<XML::Atom::Category> object, to
the Service Document as a new I<E<lt>categoryE<gt>> element. For example:

    my $category = XML::Atom::Category->new;
    $category->term('joke');
    $categories->add_category($category);

=head2 $categories->fixed

=head2 $categories->scheme

=head2 $categories->href

=head2 $categories->element_name

=head2 $categories->element_ns

=head2 XML::Atom::Client::getCategories($category_uri)

Retrieves the category document at $category_uri.

Returns an XML::Atom::Categories object representing the category document
returned from the server.


=head1 SEE ALSO

L<XML::Atom>
L<XML::Atom::Service>

=head1 AUTHOR

Takeru INOUE, E<lt>takeru.inoue _ gmail.comE<gt>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2007, Takeru INOUE C<< <takeru.inoue _ gmail.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

=cut
