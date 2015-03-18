if !$::website {
  fail('You must specify a website name!')
}

File {
  backup => false,
  owner  => $::user,
  group  => 'staff',
}

Exec {
  logoutput => on_failure,
  path      => hiera('default_path'),
  user      => $::user,
  group     => 'staff',
}

$builder         = hiera('builder', undef)
$cms             = hiera('cms', undef)
$frameworks      = hiera('frameworks', undef)
$library_manager = hiera('library_manager', undef)

# TODO: where does this belong?
$libraries       = hiera('libraries', {})
validate_hash($libraries)

include $cms
include $builder
include $frameworks
include $library_manager
include bertha
