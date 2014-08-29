class bertha::libraries {

  $include_libraries.each |$library_type, $libraries| {
    file { [
      "${website_home}/${library_type}",
      "${website_home}/${library_type}/libraries",
    ]:
      ensure => directory,
    }

    $libraries.each |$library| {
      file { "${website_home}/${library_type}/lib/${library}.${library_type}":
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

  # bertha::scss_import { 'bourbon/bourbon': }
  # bertha::scss_import { 'neat/neat': }
  #
  # Bertha::Scss_import['bourbon/bourbon'] ->
  # Bertha::Scss_import['neat/neat']

}
