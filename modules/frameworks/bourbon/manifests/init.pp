class bourbon (
  $bourbon_version,
  $neat_version,
) {

  include sass

  package { 'bourbon':
    ensure   => $bourbon_version,
    provider => 'gem',
    notify   => Exec['bourbon install'],
  }

  package { 'neat':
    ensure   => $neat_version,
    provider => 'gem',
    notify   => Exec['neat install']
  }

  exec { 'bourbon install':
    cwd     => "${bertha::website_home}/scss",
    creates => "${bertha::website_home}/scss/bourbon",
  }

  exec { 'neat install':
    cwd     => "${bertha::website_home}/scss",
    creates => "${bertha::website_home}/scss/neat",
  }

  file_line { 'bourbon/bourbon':
    ensure => present,
    line   => "@import 'bourbon/bourbon';",
    path   => "${bertha::website_home}/scss/_includes.scss",
  }

  file_line { 'neat/neat':
    ensure => present,
    line   => "@import 'neat/neat';",
    path   => "${bertha::website_home}/scss/_includes.scss",
  }

  file { "${bertha::website_home}/scss/_grid.scss":
    ensure  => file,
    source  => 'puppet:///modules/bourbon/grid.scss',
    replace => false,
  }

  file_line { 'grid':
    ensure => present,
    line   => "@import 'grid';",
    path   => "${bertha::website_home}/scss/_includes.scss",
  }

}
