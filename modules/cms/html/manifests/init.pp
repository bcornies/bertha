class html {

  # Required for server integration!
  if $bertha::view_mode == 'dev' {
    $docroot = $bertha::website_home
  } else {
    $docroot = "${bertha::website_home}/dist"
  }

  file { "${bertha::website_home}/index.php":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/html/index.php',
  }

}
