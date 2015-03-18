class bertha (
  $websites_dir,
  $server_network,
  $is_cms,
  $boilerplate_dir   = undef,
  $server_ip         = undef,
  $mysql_path        = undef,
  $view_mode         = 'dev',
  $sites             = {},
  $dist_items        = [],
  $libraries         = {},
) {

  $website_home = "${bertha::websites_dir}/${::website}"
  $server_name  = "dev-${::website}"

  contain bertha::skeleton
  contain bertha::server

}
