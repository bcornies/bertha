class concrete5::server {

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

  file { "${bertha::website_home}/server/Puppetfile":
    ensure => file,
    source => "puppet:///modules/concrete5/server/Puppetfile",
    notify => Exec['librarian-puppet install'],
  }

  file { "${bertha::website_home}/server/manifests/site.pp":
    ensure  => file,
    content => template("concrete5/server/site.pp.erb"),
  }

}
