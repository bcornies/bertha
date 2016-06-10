define wordpress::plugin {

  ensure_resource('file', "${bertha::website_home}/plugins", { 'ensure' => 'directory' })

  exec { "wget https://downloads.wordpress.org/plugin/${title}.zip":
    cwd     => "${bertha::website_home}/plugins",
    creates => "${bertha::website_home}/plugins/${title}",
  }

  exec { "unzip ${title}.zip":
    cwd         => "${bertha::website_home}/plugins",
    creates     => "${bertha::website_home}/plugins/${title}",
    refreshonly => true,
  }

  file { "${bertha::website_home}/plugins/${title}.zip":
    ensure => absent,
  }

  Exec["wget https://downloads.wordpress.org/plugin/${title}.zip"] ~>
  Exec["unzip ${title}.zip"]

}
