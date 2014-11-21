class concrete5 (
  $version,
  $packages = [],
) {

  # Required for server integration!
  $docroot = "${bertha::dock_dir}/concrete${concrete5::version}"

  contain 'concrete5::install'
  contain 'concrete5::theme'
  contain 'concrete5::config'
  contain 'concrete5::dock'
  contain 'concrete5::vagrant'

}
