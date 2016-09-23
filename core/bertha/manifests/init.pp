class bertha (
  $server_network,
  $is_cms,
  $cms_props,
  $websites_dir      = "${::home}/bertha/projects",
  $boilerplate_dir   = "${::home}/bertha/boilerplate_files",
  $server_ip         = undef,
  $mysql_path        = "/Applications/MAMP/Library/bin",
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

  $cache_dir    = "${::home}/.bertha"
  $website_home = "${bertha::websites_dir}/${::website}"
  $server_name  = "dev-${::website}"

  contain bertha::skeleton
  contain bertha::server
  contain bertha::cache
  contain bertha::tools

}
