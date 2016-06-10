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
  ].each |$page| {
    bertha::boilerplate_file { "${theme_dir}/${page}":
      boilerplate_key => "wordpress/${page}",
      default_source  => "puppet:///modules/wordpress/${page}",
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

  bertha::boilerplate_file { "${theme_dir}/js/main.js":
    boilerplate_key => 'main.js',
    default_source  => 'puppet:///modules/bertha/main.js',
  }

  wordpress::lib::include_script { 'main':
    path => 'js',
  }

  bertha::boilerplate_file { "${theme_dir}/css/global.css":
    boilerplate_key => 'global.css',
    default_source  => 'puppet:///modules/bertha/global.css',
  }

  wordpress::lib::include_stylesheet { 'global':
    path => 'css',
  }

  file { "${theme_dir}/functions.php":
    ensure  => file,
    content => template('wordpress/functions.php.erb'),
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
