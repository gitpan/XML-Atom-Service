use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'XML::Atom::Service',
    license             => 'perl',
    dist_author         => 'Takeru INOUE <takeru.inoue _ gmail.com>',
    dist_version_from   => 'lib/XML/Atom/Service.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,

        'Test::Perl::Critic' => 0,
        'XML::Atom'  => 0.27,
    },
    add_to_cleanup      => [ 'XML-Atom-Service-*' ],
);

$builder->create_build_script();
