package XML::Atom::Categories;

use warnings;
use strict;
use Carp;

use XML::Atom;
use XML::Atom::Category;
use base qw( XML::Atom::Thing );

__PACKAGE__->mk_attr_accessors(qw( fixed scheme href ));

sub element_name { 'categories' }

sub element_ns { 'http://purl.org/atom/app#' }

*{XML::Atom::Category::element_ns} = sub { 
    $XML::Atom::Util::NS_MAP{$XML::Atom::DefaultVersion}
};

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

=head1 DESCRIPTION

Category Documents contain lists of categories described using the 
"atom:category" element from the Atom Syndication Format [RFC4287].

The Category Document is defined in "The Atom Publishing Protocol," 
IETF Internet-Draft.

=head1 USAGE

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

=head1 SEE ALSO

L<XML::Atom>

L<XML::Atom::Service>

=head1 AUTHOR

Takeru INOUE, E<lt>takeru.inoue@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Takeru INOUE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
