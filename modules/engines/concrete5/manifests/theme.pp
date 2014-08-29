class concrete5::theme {

  file { [
      "${bertha::base_dir}/elements",
      "${bertha::base_dir}/config",
      "${bertha::base_dir}/packages",
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
    file { "${bertha::base_dir}/${page}":
      ensure  => file,
      replace => false,
      source  => "puppet:///modules/concrete5/${page}",
    }
  }

  file { "${bertha::base_dir}/description.txt":
    ensure  => file,
    replace => false,
    content => template('concrete5/description.txt.erb'),
  }

  file { "${bertha::base_dir}/thumbnail.png":
    ensure  => file,
    replace => false,
  }

  $packages.each |$package| {
    file { "${bertha::base_dir}/packages/${package}":
      ensure  => directory,
      source  => "puppet:///modules/concrete5/packages/${package}",
      recurse => true,
    }
  }

}
