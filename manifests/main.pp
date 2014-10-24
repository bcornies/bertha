if !$::website {
  fail('You must specify a website name!')
}

# Don't filebucket anything locally
File {
  backup => false,
  owner  => $::user,
}

Exec {
  path => hiera('default_path')
}

$builder         = hiera('builder')
$dock            = hiera('dock')
$frameworks      = hiera('frameworks')
$package_manager = hiera('package_manager')
$server          = hiera('server')

include bertha
include $builder
include $dock
include $frameworks
include $package_manager
include $server
