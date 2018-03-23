class bertha::server {

  file { "${bertha::website_home}/docker-compose.yml":
    ensure  => file,
    content => template('bertha/docker-compose.yml.erb'),
  }

}
