class local (
  $packages,
) {

  $packages.each |$package_type, $packages| {
    file { [
      "${bertha::website_home}/${package_type}/lib",
    ]:
      ensure => directory,
    }

    $packages.each |$package| {
      file { "${bertha::website_home}/${package_type}/lib/${package}.${package_type}":
        ensure => file,
        source => "puppet:///modules/local/${package_type}/${package}.${package_type}",
      }
    }
  }

  # Bourbon Installation

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

  Package['bourbon'] ->
  Exec['bourbon install']

  Package['neat'] ->
  Exec['neat install']

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

  File_line['bourbon/bourbon'] ->
  File_line['neat/neat']
}
