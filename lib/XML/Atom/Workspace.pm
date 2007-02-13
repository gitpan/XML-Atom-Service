package XML::Atom::Workspace;

use warnings;
use strict;
use Carp;

use XML::Atom;
use base qw( XML::Atom::Base );

sub element_name { 'workspace' }

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
    'collection' => 'XML::Atom::Collection',
    'collections',
);

1;
__END__

=head1 NAME

XML::Atom::Workspace - Workspace object

=head1 SYNOPSIS

  my $categories = XML::Atom::Categories->new;
  $categories->href('http://example.com/cats/forMain.cats');
  $categories->add_category($category);

  my $collection = XML::Atom::Collection->new;
  $collection->href('http://example.org/reilly/main');
  $collection->title('My Blog Entries');
  $collection->categories($categories);

  my $workspace = XML::Atom::Workspace->new;
  $workspace->title('Main Site');
  $workspace->add_collection($collection);

  ## Get lists of the collection and categories elements.
  my @collection = $workspace->collection;
  my @categories = $collection[0]->categories;

=head1 USAGE

=head2 XML::Atom::Workspace->new

=head2 $workspace->title

=head2 $workspace->collection

=head2 $workspace->add_collection

=head2 $workspace->element_name

=head2 $workspace->element_ns

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

