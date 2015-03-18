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

include bertha
include $builder
include $cms
include $frameworks
include $library_manager
