class concrete5::dock {

  $concrete5::packages.each |$package| {
    file { "${concrete5::docroot}/packages/${package}":
      ensure => link,
      target => "${bertha::base_dir}/packages/${package}",
      force  => true,
    }
  }

  file { "${concrete5::docroot}/themes/${::website}":
    ensure => link,
    target => "${bertha::base_dir}",
    force  => true,
  }

  file { "${concrete5::docroot}/config/site.php":
    ensure => link,
    target => "${bertha::base_dir}/config/site.php",
    force  => true,
  }

}
