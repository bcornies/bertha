define wordpress::lib::include_script (
  $version   = '',
  $path      = 'js/lib',
  $theme_dir = $wordpress::theme_dir,
) {

  file_line { "include_script_${name}":
    ensure => present,
    line   => "  wp_enqueue_script( '${name}', get_template_directory_uri() . '/${path}/${name}.js', array(), '${version}', true );",
    path   => "${theme_dir}/includes/scripts.php",
    after  => "# scripts",
  }


}
