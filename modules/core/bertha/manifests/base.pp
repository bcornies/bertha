class bertha::base {

  file { [
      $bertha::website_home,
      "${bertha::website_home}/js",
      "${bertha::website_home}/css",
      "${bertha::website_home}/scss",
      "${bertha::website_home}/scss/alt",
      "${bertha::website_home}/includes",
      "${bertha::website_home}/img",
    ]:
    ensure => directory,
  }

  file { "${bertha::website_home}/scss/global.scss":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/bertha/global.scss',
  }

  file { "${bertha::website_home}/scss/_includes.scss":
    ensure  => file,
  }

  file { "${bertha::website_home}/scss/alt/_mobile.scss":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/bertha/mobile.scss',
  }

  file { "${bertha::website_home}/scss/alt/_retina.scss":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/bertha/retina.scss',
  }

  file { "${bertha::website_home}/scss/alt/_ie.scss":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/bertha/ie.scss',
  }

  file { "${bertha::website_home}/js/main.js":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/bertha/main.js',
  }

  file { "${bertha::website_home}/build.xml":
    ensure  => file,
    content => template('bertha/build.xml.erb')
  }

  file { "${bertha::website_home}/run_sass.sh":
    ensure => file,
    source => 'puppet:///modules/bertha/run_sass.sh',
    mode   => '0755',
  }

  file { "${bertha::website_home}/includes/css.php":
    ensure  => file,
    content => template("${::engine}/css.php.erb"),
  }

  file { "${bertha::website_home}/includes/js.php":
    ensure  => file,
    content => template("${::engine}/js.php.erb"),
  }

}
