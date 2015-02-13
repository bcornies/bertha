class sass {

  package { 'sass':
    ensure   => installed,
    provider => 'gem',
  }

  file { [
      "${bertha::website_home}/scss",
      "${bertha::website_home}/scss/alt",
    ]:
    ensure => directory,
  }

  file { "${bertha::website_home}/scss/global.scss":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/sass/global.scss',
  }

  file { "${bertha::website_home}/scss/_includes.scss":
    ensure  => file,
  }

  file { "${bertha::website_home}/scss/alt/_mobile.scss":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/sass/mobile.scss',
  }

  file { "${bertha::website_home}/scss/alt/_retina.scss":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/sass/retina.scss',
  }

  file { "${bertha::website_home}/scss/alt/_ie.scss":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/sass/ie.scss',
  }

  file { "${bertha::website_home}/run_sass.sh":
    ensure => file,
    source => 'puppet:///modules/sass/run_sass.sh',
    mode   => '0755',
  }

  bertha::gitignore { '.sass-cache': }

}
