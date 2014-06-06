class bertha (
	$websites_dir,
  $sites = {},
  $dist_items = [],
  $is_cms,
) {

	$base_dir="${websites_dir}/${::website}"

	file { $base_dir:
		ensure => directory,
	}

	file { "$base_dir/build.xml":
		ensure => file,
		content => template('bertha/build.xml.erb')
	}

}