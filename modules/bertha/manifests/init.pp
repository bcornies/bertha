class bertha (
	$websites_dir,
  $sites = {},
  $dist_items = [],
  $is_cms,
  $include_libraries = {},
) {

	$base_dir="${websites_dir}/${::website}"

	file { [
      $base_dir,
      "${base_dir}/includes",
      "${base_dir}/img",
    ]:
		ensure => directory,
	}

  file { "${base_dir}/scss/global.scss":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/bertha/global.scss',
  }

  file { "${base_dir}/scss/mixins.scss":
    ensure  => file,
    source  => 'puppet:///modules/bertha/mixins.scss',
  }

  file { "${base_dir}/js/main.js":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/bertha/main.js',
  }

  file { "${base_dir}/build.xml":
    ensure  => file,
    content => template('bertha/build.xml.erb')
  }

  file { "${base_dir}/index.php":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/bertha/index.php',
  }

  file { "${base_dir}/run_sass.sh":
    ensure => file,
    source => 'puppet:///modules/bertha/run_sass.sh',
    mode   => '0755',
  }

  file { "${base_dir}/includes/css.php":
    ensure  => file,
    content => template('bertha/css.php.erb'),
  }

  $include_libraries.each |$library_type, $libraries| {
    file { [
      "${base_dir}/${library_type}",
      "${base_dir}/${library_type}/libraries",
    ]:
      ensure => directory,
    }

    $libraries.each |$library| {
      file { "${base_dir}/${library_type}/libraries/${library}.${library_type}":
        ensure => file,
        source => "puppet:///modules/bertha/libraries/${library_type}/${library}.${library_type}",
      }
    }
  }

}
