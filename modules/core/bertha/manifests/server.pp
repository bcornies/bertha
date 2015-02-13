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

	$gitignore_rules = [
		'server/modules',
		'.tmp',
		'.librarian',
		'.vagrant',
	]

	$gitignore_rules.each |$rule| {
		bertha::gitignore { $rule: }
	}

	exec { 'librarian-puppet install':
		cwd         => "${bertha::website_home}/server",
		refreshonly => true,
	}

	host { $bertha::server_name:
		ip => $bertha::server_ip,
	}

}
