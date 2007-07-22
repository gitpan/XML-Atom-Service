use strict;
use warnings;
use Carp;
use Test::More tests => 17;
use Test::NoWarnings;
use XML::Atom;
use XML::Atom::Collection;
use XML::Atom::Categories;
use XML::Atom::Category;

$XML::Atom::DefaultVersion = '1.0';
$XML::Atom::Service::DefaultNamespace = 'http://www.w3.org/2007/app';

my $collection = XML::Atom::Collection->new;
isa_ok $collection, 'XML::Atom::Collection';

$collection->href('http://example.org/reilly/main');
is $collection->href, 'http://example.org/reilly/main';

$collection->title('Foo Bar');
is $collection->title, 'Foo Bar';
$collection->add_accept('image/png');
$collection->add_accept('image/jpeg');
my @accepts = $collection->accepts;
is @accepts, 2;
is $accepts[0], 'image/png';
is $accepts[1], 'image/jpeg';

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
like $xml, qr!<collection xmlns="http://www.w3.org/2007/app"(?: xmlns:atom="$ns_uri")?!;
like $xml, qr!href="http://example.org/reilly/main"!;
like $xml, qr!<atom:title xmlns:atom="$ns_uri">Foo Bar</atom:title>!;
like $xml, qr!<accept(?: xmlns="http://purl.org/atom/app#")?>image/png</accept>!;
like $xml, qr!<accept(?: xmlns="http://purl.org/atom/app#")?>image/jpeg</accept>!;
like $xml, qr!<categories!;
like $xml, qr!</collection>$!;

