class bertha (
  $websites_dir,
  $server_network,
  $is_cms,
  $cms_props,
  $boilerplate_dir   = undef,
  $server_ip         = undef,
  $mysql_path        = undef,
  $view_mode         = 'dev',
  $sites             = {},
  $dist_items        = [],
  $libraries         = {},
) {

  if $is_cms {
    validate_absolute_path($cms_props['install_dir'])
    validate_string($cms_props['uploads_dir'])
    validate_string($cms_props['config_file'])
    validate_string($cms_props['themes_dir'])
  }

  $website_home = "${bertha::websites_dir}/${::website}"
  $server_name  = "dev-${::website}"

  contain bertha::skeleton
  contain bertha::server

}
