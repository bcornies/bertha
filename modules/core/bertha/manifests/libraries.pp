class bertha::libraries {

  $bertha::include_libraries.each |$library_type, $libraries| {
    file { [
      "${bertha::website_home}/${library_type}/lib",
    ]:
      ensure => directory,
    }

    $libraries.each |$library| {
      file { "${bertha::website_home}/${library_type}/lib/${library}.${library_type}":
        ensure => file,
        source => "puppet:///modules/bertha/libraries/${library_type}/${library}.${library_type}",
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
    path    => ['/usr/bin'],
  }

  exec { 'neat install':
    cwd     => "${bertha::website_home}/scss",
    creates => "${bertha::website_home}/scss/neat",
    path    => ['/usr/bin'],
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
