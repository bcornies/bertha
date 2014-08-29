class html {

  file { "${bertha::base_dir}/index.php":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/html/index.php',
  }

}