if !$::website {
  fail('You must specify a website name!')
}

# Don't filebucket anything locally
File {
  backup => false,
  owner  => $::user,
}

$builder         = hiera('builder')
$dock            = hiera('dock')
$frameworks      = hiera('frameworks')
$package_manager = hiera('package_manager')
$server          = hiera('server')

class { bertha: } ->
class { $builder: } ->
class { $dock: } ->
class { $frameworks: } ->
class { $package_manager: } ->
class { $server: }
