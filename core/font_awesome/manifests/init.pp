# Installs font-awesome assets
class font_awesome (
  $version,
  $theme_dir = $wordpress::theme_dir,
) {

  # Download to cache

  $dir_name = $version ? {
    /^4/    => "font-awesome-${version}",
    default => "fontawesome-free-${version}",
  }

  $artifact_name = "${dir_name}.zip"

  $download_url = $version ? {
    /^4/    => "http://fontawesome.io/assets/${artifact_name}",
    default => "https://use.fontawesome.com/releases/v${version}/${artifact_name}",
  }

  exec { "wget ${download_url}":
    cwd     => $bertha::cache_dir,
    creates => "${bertha::cache_dir}/${dir_name}",
  }

  exec { "unzip ${artifact_name}":
    cwd         => $bertha::cache_dir,
    refreshonly => true,
  }

  file { "${bertha::cache_dir}/${artifact_name}":
    ensure => absent,
  }

  Exec["wget ${download_url}"] ~>
  Exec["unzip ${artifact_name}"]

  # Copy to web project

  if $version =~ /^4/ {

    file { "${theme_dir}/fonts":
      ensure  => directory,
      source  => "file:///${bertha::cache_dir}/${dir_name}/fonts",
      recurse => true,
    }

    file { "${theme_dir}/css/font-awesome.css":
      ensure  => file,
      source  => "file:///${bertha::cache_dir}/${dir_name}/css/font-awesome.css",
      replace => false,
    }

    # Add to include points

    create_resources("${cms}::lib::include_stylesheet", {
      'font-awesome' => {
        'version' => $version,
        'path'    => 'css',
      }
    })

  } else {

    file { "${theme_dir}/js/lib/fontawesome-all.min.js":
      ensure => directory,
      source => "file:///${bertha::cache_dir}/${dir_name}/svg-with-js/js/fontawesome-all.min.js",
    }

    create_resources("${cms}::lib::include_script", {
      'fontawesome-all.min' => {
        'version' => $version,
        'path'    => 'js/lib',
      }
    })

  }




}
