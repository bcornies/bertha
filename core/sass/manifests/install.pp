class sass::install (
  $theme_dir = $wordpress::theme_dir,
) {

  file_line { 'gem sass':
    line   => 'gem "sass"',
    path   => "${bertha::website_home}/Gemfile",
  }

  file { "${bertha::website_home}/run_sass.sh":
    ensure  => file,
    content => template('sass/run_sass.sh.erb'),
    mode    => '0755',
  }

  bertha::gitignore { '.sass-cache': }

  bertha::gitignore { '*.css.map': }

}
