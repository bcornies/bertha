# Installs font-awesome assets
class font_awesome (
  $version,
) {

  # Download to cache

  exec { "wget http://fontawesome.io/assets/font-awesome-${version}.zip":
    cwd     => $bertha::cache_dir,
    creates => "${bertha::cache_dir}/font-awesome-${version}",
  }

  exec { "unzip font-awesome-${version}.zip":
    cwd         => $bertha::cache_dir,
    refreshonly => true,
  }

  file { "${bertha::cache_dir}/font-awesome-${version}.zip":
    ensure => absent,
  }

  Exec["wget http://fontawesome.io/assets/font-awesome-${version}.zip"] ~>
  Exec["unzip font-awesome-${version}.zip"]

  # Copy to web project

  file { "${bertha::website_home}/fonts":
    ensure  => directory,
    source  => "file:///${bertha::cache_dir}/font-awesome-${version}/fonts",
    recurse => true,
  }

  file { "${bertha::website_home}/css/font-awesome.css":
    ensure  => file,
    source  => "file:///${bertha::cache_dir}/font-awesome-${version}/css/font-awesome.css",
    replace => false,
  }

  # 4. Add to include points

  create_resources("${cms}::include_stylesheet", {
    'font-awesome' => {
      'version' => $version,
      'path'    => 'css',
    }
  })

}
