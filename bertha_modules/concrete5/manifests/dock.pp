class concrete5::dock {

  $concrete5::packages.each |$package| {
    file { "${bertha::dock_dir}/concrete${concrete5::version}/packages/${package}":
      ensure => link,
      target => "${bertha::base_dir}/packages/${package}",
      force  => true,
    }
  }

  file { "${bertha::dock_dir}/concrete${concrete5::version}/themes/${::website}":
    ensure => link,
    target => "${bertha::base_dir}",
    force  => true,
  }

  file { "${bertha::dock_dir}/concrete${concrete5::version}/config/site.php":
    ensure => link,
    target => "${bertha::base_dir}/config/site.php",
    force  => true,
  }

}
