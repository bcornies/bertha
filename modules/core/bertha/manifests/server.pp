class bertha::server {

	file { [
		"${bertha::website_home}/server",
		"${bertha::website_home}/server/manifests",
		"${bertha::website_home}/server/modules",
		]:
		ensure  => directory,
	}

	file { "${bertha::website_home}/Vagrantfile":
		ensure  => file,
		content => template("bertha/Vagrantfile.erb"),
	}

	[
		'server/modules',
		'.tmp',
		'.librarian',
		'.vagrant',
	].each |$line| {
		file_line { "gitignore_${line}":
			ensure => present,
			line   => $line,
			path   => "${bertha::website_home}/.gitignore",
		}
	}

	exec { 'librarian-puppet install':
		cwd         => "${bertha::website_home}/server",
		refreshonly => true,
	}

	file { "${bertha::website_home}/server/Puppetfile":
		ensure => file,
		source => "puppet:///modules/${::cms}/server/Puppetfile",
		notify => Exec['librarian-puppet install'],
	}

	file { "${bertha::website_home}/server/manifests/site.pp":
		ensure  => file,
		content => template("${::cms}/server/site.pp.erb"),
	}

	host { $bertha::server_name:
		ip => $bertha::server_ip,
	}

}
