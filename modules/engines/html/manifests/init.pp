class html {

  # Required for server integration!
  if $bertha::view_mode == 'dev' {
    $docroot = $bertha::base_dir
  } else {
    $docroot = "${bertha::base_dir}/dist"
  }

  file { "${bertha::base_dir}/index.php":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/html/index.php',
  }

}
