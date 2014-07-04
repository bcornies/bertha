class concrete5::dock {

  file { "${bertha::dock_dir}/concrete5/packages":
    ensure => link,
    target => "${bertha::base_dir}/packages",
    force  => true,
  }

  file { "${bertha::dock_dir}/concrete5/themes/${::website}":
    ensure => link,
    target => "${bertha::base_dir}",
    force  => true,
  }

  file { "${bertha::dock_dir}/concrete5/config/site.php":
    ensure => link,
    target => "${bertha::base_dir}/config/site.php",
    force  => true,
  }

}
