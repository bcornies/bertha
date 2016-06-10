define wordpress::lib::library_source (
  $type,
  $source,
  $theme_dir = $wordpress::theme_dir,
) {

  file { "${theme_dir}/${type}/lib/${name}":
    ensure => file,
    source => $source,
  }

}
