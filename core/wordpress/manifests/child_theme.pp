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
    file { "${theme_dir}/${page}":
      ensure  => file,
      replace => false,
      content => template("sass/${page}.erb"),
    }
  }

}
