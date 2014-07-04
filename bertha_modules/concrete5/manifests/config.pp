class concrete5::config {

  file { "${bertha::base_dir}/config/site.php.template":
    ensure => file,
    source => 'puppet:///modules/concrete5/site.php',
  }

  file { "${bertha::base_dir}/config/site.php":
    ensure  => file,
    content => template('concrete5/site.php.erb'),
  }

}
