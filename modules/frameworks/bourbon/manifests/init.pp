class bourbon {

  package { [
      'bourbon',
      'neat'
    ]:
    ensure   => installed,
    provider => 'gem',
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

}
