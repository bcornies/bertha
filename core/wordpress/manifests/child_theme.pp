class wordpress::child_theme (
  $theme_dir = $wordpress::theme_dir,
) {

  file { $theme_dir:
    ensure => directory,
  }

  # Boilerplate files - these do _not_ get replaced once created
  [
    'style.css',
  ].each |$page| {
    bertha::boilerplate_file { "${theme_dir}/${page}":
      boilerplate_key => "wordpress/${page}",
      default_source  => "puppet:///modules/wordpress/${page}",
    }
  }

}
