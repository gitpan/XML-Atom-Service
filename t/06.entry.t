use strict;
use warnings;
use Carp;
use Test::More tests => 13;
use Test::NoWarnings;
use XML::Atom::Entry;
use XML::Atom::Service;

$XML::Atom::DefaultVersion = '1.0';

my $entry = XML::Atom::Entry->new;

$entry->edited('2007-01-01T00:00:00Z');
is $entry->edited, '2007-01-01T00:00:00Z';

my $control = XML::Atom::Control->new;
isa_ok $control, 'XML::Atom::Control';

$control->draft('yes');
is $control->draft, 'yes';
$entry->control($control);

my $content = XML::Atom::Content->new( Version => 1.0 );
$content->src('http://example.com/foo.png');
$content->type('image/png');
is $content->src, 'http://example.com/foo.png';
is $content->type, 'image/png';
$entry->content($content);

my $ns_uri = quotemeta $XML::Atom::Service::DefaultNamespace;
like $entry->as_xml, qr{<app:edited(?: xmlns:app="$ns_uri")?>2007-01-01T00:00:00Z</app:edited>};
like $entry->as_xml, qr{<control xmlns="$ns_uri">\s*<draft>yes</draft>\s*</control>}ms;

my $sample = "t/samples/atom-$XML::Atom::DefaultVersion/06.entry";
$entry = XML::Atom::Entry->new($sample);
isa_ok $entry, 'XML::Atom::Entry';

is $entry->title, 'Title';
is $entry->edited, '2007-01-01T00:00:00Z';
is $entry->control->draft, 'yes';
is $entry->content->src, 'http://example.com/foo.png';
