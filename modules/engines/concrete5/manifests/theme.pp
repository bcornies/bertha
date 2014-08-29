class concrete5::theme {

  file { [
      "${bertha::website_home}/elements",
      "${bertha::website_home}/config",
      "${bertha::website_home}/packages",
    ]: 
    ensure => directory,
  }

  # Boilerplate files - these do _not_ get replaced once created
  [ 
    'default.php',
    'view.php',
    'elements/header.php',
    'elements/footer.php',
  ].each |$page| {
    file { "${bertha::website_home}/${page}":
      ensure  => file,
      replace => false,
      source  => "puppet:///modules/concrete5/${page}",
    }
  }

  file { "${bertha::website_home}/description.txt":
    ensure  => file,
    replace => false,
    content => template('concrete5/description.txt.erb'),
  }

  file { "${bertha::website_home}/thumbnail.png":
    ensure  => file,
    replace => false,
  }

  $packages.each |$package| {
    file { "${bertha::website_home}/packages/${package}":
      ensure  => directory,
      source  => "puppet:///modules/concrete5/packages/${package}",
      recurse => true,
    }
  }

}
