class concrete5::dock {

  $concrete5::packages.each |$package| {
    file { "${concrete5::docroot}/packages/${package}":
      ensure => link,
      target => "${bertha::website_home}/packages/${package}",
      force  => true,
    }
  }

  file { "${concrete5::docroot}/application/themes/${::website}":
    ensure => link,
    target => "${bertha::website_home}",
    force  => true,
  }

  file { "${concrete5::docroot}/application/config/database.php":
    ensure => link,
    target => "${bertha::website_home}/config/database.php",
    force  => true,
  }

}
