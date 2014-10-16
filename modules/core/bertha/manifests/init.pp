class bertha (
  $websites_dir,
  $is_cms,
  $view_mode,
  $mysql_path,
  $dock_dir = undef,
  $sites = {},
  $dist_items = [],
  $include_libraries = {},
) {

  $website_home="${websites_dir}/${::website}"

  anchor { 'begin::bertha': } ->
  class { 'base': } ->
  class { 'sass': } ->
  class { 'ant': } ->
  class { 'libraries': } ->
  anchor { 'end::bertha': }

}
