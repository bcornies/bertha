class concrete5::vagrant {

	file_line { "Puppetfile_apache":
		ensure => present,
		line   => "mod 'puppetlabs-apache'",
		path   => "${bertha::website_home}/puppet/Puppetfile",
		notify => Exec['librarian-puppet install'],
	}

	file_line { "Puppetfile_mysql":
		ensure => present,
		line   => "mod 'puppetlabs-mysql'",
		path   => "${bertha::website_home}/puppet/Puppetfile",
		notify => Exec['librarian-puppet install'],
	}

	file_line { "Puppetfile_stdlib":
		ensure => present,
		line   => "mod 'puppetlabs-stdlib'",
		path   => "${bertha::website_home}/puppet/Puppetfile",
		notify => Exec['librarian-puppet install'],
	}

}
