class concrete5::config {

  file { "${bertha::website_home}/deploy.xml":
    ensure => file,
    content => template('concrete5/server/deploy.xml.erb'),
  }

  file { "${bertha::website_home}/config/database.php":
    ensure  => file,
    content => template('concrete5/database.php.erb'),
  }

  file { "${bertha::website_home}/config/database.php.template":
    ensure => file,
    source => 'puppet:///modules/concrete5/database.php',
  }

}
