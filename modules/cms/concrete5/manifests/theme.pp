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
    'elements/header.php',
    'elements/footer.php',
  ].each |$page| {
    bertha::boilerplate_file { "${bertha::website_home}/${page}":
      boilerplate_key => $page,
      default_source  => "puppet:///modules/concrete5/${page}",
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

}
