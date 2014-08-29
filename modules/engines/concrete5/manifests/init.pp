class concrete5 (
  $version,
  $packages = [],
) {

  # Required for server integration!
  $docroot = "${bertha::dock_dir}/concrete${concrete5::version}"

  class { 'install': } ->
  class { 'theme': } ->
  class { 'config': } ->
  class { 'dock': }

}
