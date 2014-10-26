use strict;
use warnings;
use Carp;
use Test::More 'no_plan';
use XML::Atom::Service;
use XML::Atom::Workspace;

$XML::Atom::DefaultVersion = '1.0';

my $service = XML::Atom::Service->new;
isa_ok $service, 'XML::Atom::Service';

my $workspace = XML::Atom::Workspace->new;
$workspace->title('Foo Bar');
$service->add_workspace($workspace);

$workspace = $service->workspace;
is $workspace->title, 'Foo Bar';

my $workspace2 = XML::Atom::Workspace->new;
$workspace2->title('Baz Quux');
$service->add_workspace($workspace2);

my @workspace = $service->workspace;
is scalar(@workspace), 2;
is $workspace[0]->title, 'Foo Bar';
is $workspace[1]->title, 'Baz Quux';

@workspace = $service->workspaces;
is scalar(@workspace), 2;
is $workspace[0]->title, 'Foo Bar';
is $workspace[1]->title, 'Baz Quux';

my $xml = $service->as_xml;
like $xml, qr!^<\?xml version="1.0" encoding="utf-8"\?>!;

my $ns_uri = $XML::Atom::Util::NS_MAP{ $XML::Atom::DefaultVersion };
like $xml, qr!<service xmlns="http://purl.org/atom/app#"(?: xmlns:atom="$ns_uri">)?!;
like $xml, qr!<workspace(?: xmlns="http://purl.org/atom/app#")?(?: xmlns:atom="$ns_uri">)?!;
like $xml, qr!<atom:title xmlns:atom="$ns_uri">Foo Bar</atom:title>!;
like $xml, qr!<atom:title xmlns:atom="$ns_uri">Baz Quux</atom:title>!;
like $xml, qr!</service>$!;

my $sample = "t/samples/atom-$XML::Atom::DefaultVersion/04.atomsrv";
$service = XML::Atom::Service->new($sample);
isa_ok $service, 'XML::Atom::Service';

@workspace = $service->workspace;
is $workspace[0]->title, 'Main Site';
is $workspace[1]->title, 'Side Bar Blog';

