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

  $website_home="${bertha::websites_dir}/${::website}"

  contain bertha::skeleton
  contain bertha::server
  contain bertha::git

}
