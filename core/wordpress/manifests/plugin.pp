define wordpress::plugin {

  exec { "wget https://downloads.wordpress.org/plugin/${title}.zip":
    cwd     => "${bertha::website_home}/wp-content/plugins",
    creates => "${bertha::website_home}/wp-content/plugins/${title}",
  }

  exec { "unzip ${title}.zip":
    cwd         => "${bertha::website_home}/wp-content/plugins",
    creates     => "${bertha::website_home}/wp-content/plugins/${title}",
    refreshonly => true,
  }

  file { "${bertha::website_home}/wp-content/plugins/${title}.zip":
    ensure => absent,
  }

  Exec["wget https://downloads.wordpress.org/plugin/${title}.zip"] ~>
  Exec["unzip ${title}.zip"]

}
