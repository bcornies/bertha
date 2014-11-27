class bertha::git {

	file { "${bertha::website_home}/.gitignore":
		ensure  => file,
	}

}
