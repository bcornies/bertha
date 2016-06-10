define wordpress::lib::include_stylesheet (
  $version   = '',
  $path      = 'css/lib',
  $theme_dir = $wordpress::theme_dir,
) {

  file_line { "include_stylesheet_${name}":
    ensure => present,
    line   => "  wp_enqueue_style( '${name}', get_template_directory_uri() . '/${path}/${name}.css', array(), '${version}' );",
    path   => "${theme_dir}/includes/scripts.php",
    after  => "# stylesheets",
  }

}
