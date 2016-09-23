class bertha::server {

	file { [
		"${bertha::website_home}/server",
		"${bertha::website_home}/server/environments",
		"${bertha::website_home}/server/environments/dev",
		"${bertha::website_home}/server/environments/dev/manifests",
		"${bertha::website_home}/server/environments/dev/modules",
	]:
		ensure  => directory,
	}

	file { "${bertha::website_home}/Vagrantfile":
		ensure  => file,
		content => template("bertha/Vagrantfile.erb"),
	}

	$gitignore_rules = [
		'server/environments/dev/modules',
		'.tmp',
		'.librarian',
		'.vagrant',
	]

	$gitignore_rules.each |$rule| {
		bertha::gitignore { $rule: }
	}

	file { "${bertha::website_home}/server/environments/dev/Puppetfile":
		ensure => file,
		source => "puppet:///modules/${::cms}/server/Puppetfile",
	}

	file { "${bertha::website_home}/server/environments/dev/manifests/site.pp":
		ensure  => file,
		content => template("${::cms}/server/site.pp.erb"),
	}

	exec { 'librarian-puppet install':
		cwd         => "${bertha::website_home}/server/environments/dev",
		refreshonly => true,
		environment => [
			"HOME=${::home}"
		]
	}

	host { $bertha::server_name:
		ip => $bertha::server_ip,
	}

	File["${bertha::website_home}/server/environments/dev/Puppetfile"] ~>
	Exec['librarian-puppet install']

}
