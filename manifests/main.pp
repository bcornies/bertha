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
$package_manager = hiera('package_manager')
$packages        = hiera('packages')

include bertha
include $builder
include $cms
include $frameworks
include $package_manager
