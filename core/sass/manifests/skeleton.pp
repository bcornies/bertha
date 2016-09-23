class sass::skeleton (
  $theme_dir = $wordpress::theme_dir,
) {

  file { [
    "${theme_dir}/scss",
    "${theme_dir}/scss/alt",
    "${theme_dir}/scss/pages",
  ]:
    ensure => directory,
  }

  file { "${theme_dir}/scss/lib":
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
  }

  file { "${theme_dir}/scss/_includes.scss":
    ensure => file,
  }

  # Boilerplate files - these do _not_ get replaced once created
  [
    'scss/site.scss',
    'scss/_foundation.scss',
    'scss/alt/_mobile.scss',
    'scss/alt/_retina.scss',
    'scss/alt/_ie.scss',
    'scss/pages/home.scss',
    'scss/pages/404.scss',
  ].each |$page| {
    bertha::boilerplate_file { "${theme_dir}/${page}":
      boilerplate_key => $page,
      default_source  => "puppet:///modules/sass/${page}",
    }
  }

}
