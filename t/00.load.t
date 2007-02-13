use Test::More tests => 4;

BEGIN {
use_ok( 'XML::Atom::Categories' );
use_ok( 'XML::Atom::Collection' );
use_ok( 'XML::Atom::Workspace' );
use_ok( 'XML::Atom::Service' );
}

diag( "Testing XML::Atom::Service $XML::Atom::Service::VERSION" );
