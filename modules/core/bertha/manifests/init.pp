class bertha (
  $websites_dir,
  $server_ip,
  $server_network,
  $is_cms,
  $view_mode,
  $mysql_path,
  $sites = {},
  $dist_items = [],
  $include_libraries = {},
) {

  $website_home = "${bertha::websites_dir}/${::website}"
  $server_name  = "dev-${::website}"

  contain bertha::skeleton
  contain bertha::server

}
