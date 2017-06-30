class wordpress::theme (
  $theme_dir = $wordpress::theme_dir,
) {

  file { [
    $theme_dir,
    "${theme_dir}/img",
  ]:
    ensure => directory,
  }

  # Boilerplate files - these do _not_ get replaced once created
  [
    'index.php',
    'page.php',
    'header.php',
    'footer.php',
    'style.css',
    'js/main.js',
  ].each |$page| {
    file { "${theme_dir}/${page}":
      ensure  => file,
      replace => false,
      content => template("wordpress/${page}.erb")
    }
  }

  file { [
    "${theme_dir}/js",
    "${theme_dir}/js/lib",
    "${theme_dir}/css",
    "${theme_dir}/css/lib",
    "${theme_dir}/includes",
  ]:
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
  }


  wordpress::lib::include_script { 'main':
    path => 'js',
  }

  wordpress::lib::include_stylesheet { 'site':
    path => 'css',
  }

  file { "${theme_dir}/functions.php":
    ensure  => file,
    content => template('wordpress/functions.php.erb'),
    replace => false,
  }

  file { "${theme_dir}/includes/scripts.php":
    ensure  => file,
    content => template('wordpress/scripts.php.erb'),
    replace => false,
  }

  file { "${theme_dir}/includes/scripts-min.php":
    ensure  => file,
    content => template('wordpress/scripts-min.php.erb'),
  }

}
