class concrete5 {
  
  file { "${bertha::base_dir}/default.php":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/concrete5/default.php',
  }

  file { "${bertha::base_dir}/elements/header.php":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/concrete5/header.php',
  }

  file { "${bertha::base_dir}/elements/footer.php":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/concrete5/footer.php',
  }

  file { "${bertha::base_dir}/config/site.php.template":
    ensure => file,
    source => 'puppet:///modules/concrete5/site.php',
  }

  file { "${bertha::base_dir}/config/site.php":
    ensure => file,
    content => template('concrete5/site.php.erb'),
  }

  file { [
      "${bertha::base_dir}/elements",
      "${bertha::base_dir}/config"
    ]: 
    ensure => directory,
  }

}
