class bertha (
  $websites_dir,
  $is_cms,
  $mysql_path,
  $dock_dir = undef,
  $sites = {},
  $dist_items = [],
  $include_libraries = {},
) {

  $base_dir="${websites_dir}/${::website}"

  anchor { 'begin::bertha': } ->
  class { 'ant': } ->
  class { 'libraries': } ->
  anchor { 'end::bertha': }

	file { [
      $base_dir,
      "${base_dir}/js",
      "${base_dir}/css",
      "${base_dir}/scss",
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

  file { "${base_dir}/js/main.js":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/bertha/main.js',
  }

  file { "${base_dir}/build.xml":
    ensure  => file,
    content => template('bertha/build.xml.erb')
  }

  file { "${base_dir}/run_sass.sh":
    ensure => file,
    source => 'puppet:///modules/bertha/run_sass.sh',
    mode   => '0755',
  }

  file { "${base_dir}/includes/css.php":
    ensure  => file,
    content => template("${::engine}/css.php.erb"),
  }

  file { "${base_dir}/includes/js.php":
    ensure  => file,
    content => template("${::engine}/js.php.erb"),
  }

}
