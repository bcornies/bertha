class bertha::skeleton {

	file { $bertha::website_home:
    ensure => directory,
  }

}
