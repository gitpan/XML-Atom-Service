# $Id$

use strict;
use warnings;
use Test::More 'no_plan';
use XML::Atom::Collection;
use XML::Atom::Categories;
use XML::Atom::Category;

#$XML::Atom::DefaultVersion = '1.0';

my $collection = XML::Atom::Collection->new;
isa_ok $collection, 'XML::Atom::Collection';

$collection->href('http://example.org/reilly/main');
is $collection->href, 'http://example.org/reilly/main';

$collection->title('Foo Bar');
is $collection->title, 'Foo Bar';
$collection->accept('image/*');
is $collection->accept, 'image/*';

my $categories = XML::Atom::Categories->new;
my $category = XML::Atom::Category->new;
$category->term('joke');
$categories->add_category($category);

$collection->categories($categories);
$categories = $collection->categories;
isa_ok $categories, 'XML::Atom::Categories';
$category = $categories->category;
isa_ok $category, 'XML::Atom::Category';
is $category->term, 'joke';

my $xml = $collection->as_xml;
my $ns_uri = $XML::Atom::Util::NS_MAP{ $XML::Atom::DefaultVersion };
like $xml, qr!<collection xmlns="http://purl.org/atom/app#" xmlns:atom="$ns_uri"!;
like $xml, qr!href="http://example.org/reilly/main"!;
like $xml, qr!<atom:title xmlns:atom="$ns_uri">Foo Bar</atom:title>!;
like $xml, qr!<accept xmlns="http://purl.org/atom/app#">image/\*</accept>!;
like $xml, qr!<categories!;
like $xml, qr!</collection>$!;
