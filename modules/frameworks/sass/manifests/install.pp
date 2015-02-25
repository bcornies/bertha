class sass::install {

  package { 'sass':
    ensure   => installed,
    provider => 'gem',
  }

  file { "${bertha::website_home}/run_sass.sh":
    ensure => file,
    source => 'puppet:///modules/sass/run_sass.sh',
    mode   => '0755',
  }

  bertha::gitignore { '.sass-cache': }

}
