class bertha (
  $websites_dir,
  $is_cms,
  $view_mode,
  $mysql_path,
  $dock_dir = undef,
  $sites = {},
  $dist_items = [],
  $include_libraries = {},
) {

  $website_home="${websites_dir}/${::website}"

  anchor { 'begin::bertha': } ->
  class { 'ant': } ->
  class { 'libraries': } ->
  anchor { 'end::bertha': }

	file { [
      $website_home,
      "${website_home}/js",
      "${website_home}/css",
      "${website_home}/scss",
      "${website_home}/includes",
      "${website_home}/img",
    ]:
		ensure => directory,
	}

  file { "${website_home}/scss/global.scss":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/bertha/global.scss',
  }

  file { "${website_home}/js/main.js":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/bertha/main.js',
  }

  file { "${website_home}/build.xml":
    ensure  => file,
    content => template('bertha/build.xml.erb')
  }

  file { "${website_home}/run_sass.sh":
    ensure => file,
    source => 'puppet:///modules/bertha/run_sass.sh',
    mode   => '0755',
  }

  file { "${website_home}/includes/css.php":
    ensure  => file,
    content => template("${::engine}/css.php.erb"),
  }

  file { "${website_home}/includes/js.php":
    ensure  => file,
    content => template("${::engine}/js.php.erb"),
  }

}
