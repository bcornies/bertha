class sass::install (
  $theme_dir = $wordpress::theme_dir,
) {

  package { 'sass':
    ensure   => installed,
    provider => 'gem',
  }

  file { "${theme_dir}/run_sass.sh":
    ensure => file,
    source => 'puppet:///modules/sass/run_sass.sh',
    mode   => '0755',
  }

  bertha::gitignore { '.sass-cache': }

  bertha::gitignore { '*.css.map': }

}
