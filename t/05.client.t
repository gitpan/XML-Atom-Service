use strict;
use warnings;
use Carp;
use Test::More tests => 3;
use Test::NoWarnings;
use XML::Atom::Client;
use XML::Atom::Service;
use XML::Atom::Categories;

$XML::Atom::DefaultVersion = '1.0';

my $client = XML::Atom::Client->new;

ok $client->can('getService');
ok $client->can('getCategories');
