# $Id$

package XML::Atom::Collection;
use strict;
use base qw( XML::Atom::Base );

use XML::Atom;

__PACKAGE__->mk_elem_accessors(qw( accept ));
__PACKAGE__->mk_attr_accessors(qw( href ));

sub element_name { 'collection' }

sub element_ns { 'http://purl.org/atom/app#' }

sub title {
    my $self   = shift;
    my $ns_uri = $XML::Atom::Util::NS_MAP{$XML::Atom::DefaultVersion};
    my $atom   = XML::Atom::Namespace->new( atom => $ns_uri );
    if (@_) {
	$self->set( $atom, 'title', $_[0] );
    }
    else {
	$self->get( $atom, 'title' );
    }
}

__PACKAGE__->mk_object_list_accessor(
    'categories' => 'XML::Atom::Categories',
);

1;
__END__

=head1 NAME

XML::Atom::Collection - Collection object

=head1 SYNOPSIS

  my $categories = XML::Atom::Categories->new;
  $categories->href('http://example.com/cats/forMain.cats');
  $categories->add_category($category);

  my $collection = XML::Atom::Collection->new;
  $collection->href('http://example.org/reilly/main');
  $collection->title('My Blog Entries');
  $collection->categories($categories);

  ## Get a list of the categories elements.
  my @categories = $collection->categories;

=head1 USAGE

=head2 XML::Atom::Collection->new

=head2 $collection->href

=head2 $collection->title

=head2 $collection->accept

=head2 $collection->categories

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

