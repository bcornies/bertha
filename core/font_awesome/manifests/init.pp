# Installs font-awesome assets
class font_awesome (
  $version,
  $theme_dir = $wordpress::theme_dir,
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

  file { "${theme_dir}/fonts":
    ensure  => directory,
    source  => "file:///${bertha::cache_dir}/font-awesome-${version}/fonts",
    recurse => true,
  }

  file { "${theme_dir}/css/font-awesome.css":
    ensure  => file,
    source  => "file:///${bertha::cache_dir}/font-awesome-${version}/css/font-awesome.css",
    replace => false,
  }

  # Add to include points

  create_resources("${cms}::lib::include_stylesheet", {
    'font-awesome' => {
      'version' => $version,
      'path'    => 'css',
    }
  })

}
