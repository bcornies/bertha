class concrete5::dock {

  $concrete5::packages.each |$package| {
    file { "${concrete5::docroot}/packages/${package}":
      ensure => link,
      target => "${bertha::website_home}/packages/${package}",
      force  => true,
    }
  }

  file { "${concrete5::docroot}/themes/${::website}":
    ensure => link,
    target => "${bertha::website_home}",
    force  => true,
  }

  file { "${concrete5::docroot}/config/site.php":
    ensure => link,
    target => "${bertha::website_home}/config/site.php",
    force  => true,
  }

}
