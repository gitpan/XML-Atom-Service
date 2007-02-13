package XML::Atom::Service;

use warnings;
use strict;
use Carp;

use XML::Atom;
use XML::Atom::Workspace;
use XML::Atom::Collection;
use base qw( XML::Atom::Thing );

use version; our $VERSION = qv('0.0.2');

sub element_name { 'service' }

sub element_ns { 'http://purl.org/atom/app#' }

__PACKAGE__->mk_object_list_accessor(
    'workspace' => 'XML::Atom::Workspace',
    'workspaces',
);

1;
__END__

=head1 NAME

XML::Atom::Service - Atom Service Document object

=head1 SYNOPSIS

  use XML::Atom::Service;
  use XML::Atom::Categories;

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

  my $service = XML::Atom::Service->new;
  $service->add_workspace($workspace);

  my $xml = $service->as_xml;

  ## Get lists of the workspace, collection, and categories elements.
  my @workspace = $service->workspace;
  my @collection = $workspace[0]->collection;
  my @categories = $collection[0]->categories;

=head1 DESCRIPTION

For authoring to commence, a client needs to first discover the 
capabilities and locations of the available collections.  
Service Documents are designed to support this discovery process.
They describe the location and capabilities of one or more Collection.

The Service Document is defined in "The Atom Publishing Protocol," 
IETF Internet-Draft.

=head1 USAGE

=head2 XML::Atom::Service->new([ $stream ])

Creates a new Service Document object, and if I<$stream> is supplied, fills 
it with the data specified by I<$stream>.

Automatically handles autodiscovery if I<$stream> is a URI (see below).

Returns the new I<XML::Atom::Service> object. On failure, returns C<undef>.

I<$stream> can be any one of the following:

=over 4

=item * Reference to a scalar

This is treated as the XML body of the feed.

=item * Scalar

This is treated as the name of a file containing the Service Document XML.

=item * Filehandle

This is treated as an open filehandle from which the Service Document XML can be read.

=item * URI object

This is treated as a URI, and the Service Document XML will be retrieved from the URI.

=back

=head2 $service->workspace

If called in scalar context, returns an I<XML::Atom::Workspace> object
corresponding to the first I<E<lt>workspaceE<gt>> element found in the Service Document.

If called in list context, returns a list of I<XML::Atom::Workspace> objects
corresponding to all of the I<E<lt>workspaceE<gt>> elements found in the Service Document.

=head2 $service->add_workspace($workspace)

Adds the workspace I<$workspace>, which must be an I<XML::Atom::Workspace> object, to
the Service Document as a new I<E<lt>workspaceE<gt>> element. For example:

    my $workspace = XML::Atom::Workspace->new;
    $workspace->title('Foo Bar');
    $service->add_workspace($workspace);

=head2 $service->element_name

=head2 $service->element_ns

=head1 SEE ALSO

L<XML::Atom>

L<XML::Atom::Categories>

=head1 AUTHOR

Takeru INOUE, E<lt>takeru.inoue@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Takeru INOUE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
