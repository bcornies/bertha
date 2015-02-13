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

  file { "${bertha::website_home}/scss/_grid.scss":
    ensure  => file,
    source  => 'puppet:///modules/bourbon/grid.scss',
    replace => false,
  }

  sass::includes { [
    'bourbon/bourbon',
    'neat/neat',
    'grid'
  ]: }

}
