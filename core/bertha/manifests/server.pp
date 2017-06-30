class bertha::server {

	file { "${bertha::website_home}/docker-compose.yml":
		ensure => file,
		source => 'puppet:///modules/bertha/docker-compose.yml',
	}

}
