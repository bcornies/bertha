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

$builder         = hiera('builder')
$cms             = hiera('cms')
$frameworks      = hiera('frameworks')
$library_manager = hiera('library_manager')

include bertha
include $builder
include $cms
include $frameworks
include $library_manager
