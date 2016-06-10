class sass::skeleton {

  file { [
    "${bertha::website_home}/scss",
    "${bertha::website_home}/scss/alt",
  ]:
    ensure => directory,
  }

  file { "${bertha::website_home}/scss/lib":
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
  }

  # Boilerplate files - these do _not_ get replaced once created
  [
    'scss/global.scss',
    'scss/alt/_mobile.scss',
    'scss/alt/_retina.scss',
    'scss/alt/_ie.scss',
  ].each |$page| {
    bertha::boilerplate_file { "${bertha::website_home}/${page}":
      boilerplate_key => $page,
      default_source  => "puppet:///modules/sass/${page}",
    }
  }

}
