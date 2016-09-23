class bertha::skeleton {

	exec { "mkdir -p ${bertha::website_home}":
		creates => $bertha::website_home,
		user    => $::user,
		group   => 'staff',
	}

}
