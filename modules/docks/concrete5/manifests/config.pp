class concrete5::config {

  file { "${bertha::website_home}/config/database.php":
    ensure  => file,
    content => template('concrete5/database.php.erb'),
  }

  file { "${bertha::website_home}/config/database.php.template":
    ensure => file,
    source => 'puppet:///modules/concrete5/database.php',
  }

}
