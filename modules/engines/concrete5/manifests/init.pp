class concrete5 (
  $version,
  $packages = [],
) {
  
  class { 'install': } ->
  class { 'theme': } ->
  class { 'config': } ->
  class { 'dock': }

}
