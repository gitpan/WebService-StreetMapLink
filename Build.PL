use strict;

use Module::Build;

my $builder =
    Module::Build->new
        ( module_name         => 'WebService::StreetMapLink',
          license             => 'perl',
          dist_author         => 'David Rolsky <autarch@urth.org>',
          requires            => { 'Class::Factory::Util' => 0,
                                   'Geography::States'    => 0,
                                   'Params::Validate'     => 0,
                                   'Test::More'           => 0,
                                 },
          add_to_cleanup      => [ 'WebService-StreetMapLink-*' ],
          create_makefile_pl  => 'passthrough',
          sign                => 1,
);

$builder->create_build_script();
