class concrete5::config {

  file { "${bertha::website_home}/config/site.php.template":
    ensure => file,
    source => 'puppet:///modules/concrete5/site.php',
  }

  file { "${bertha::website_home}/config/site.php":
    ensure  => file,
    content => template('concrete5/site.php.erb'),
  }

}
