class bertha::skeleton {

	file { [
		"${bertha::website_home}/js",
		"${bertha::website_home}/js/lib",
		"${bertha::website_home}/css",
		"${bertha::website_home}/css/lib",
		"${bertha::website_home}/includes",
	]:
		ensure  => directory,
		recurse => true,
		purge   => true,
		force   => true,
	}

	file { [
		$bertha::website_home,
		"${bertha::website_home}/img",
	]:
		ensure => directory,
	}

	boilerplate_file { "${bertha::website_home}/js/main.js":
		boilerplate_key => 'main.js',
		default_source  => 'puppet:///modules/bertha/main.js',
	}

	boilerplate_file { "${bertha::website_home}/css/global.css":
		boilerplate_key => 'global.css',
		default_source  => 'puppet:///modules/bertha/global.css',
	}

	file { [
		"${bertha::website_home}/includes/css.php",
		"${bertha::website_home}/includes/js.php",
	]:
		ensure => file,
	}

	$theme_path = chomp(template("${::cms}/theme_path.erb"))

	$::libraries['css'].each |$css_library| {

		file_line { "css_include_$css_library":
			ensure => present,
			line   => "<link rel=\"stylesheet\" type=\"text/css\" href=\"${theme_path}/css/lib/${css_library}.css\">",
			path   => "${bertha::website_home}/includes/css.php",
		}

	}

	file_line { "css_include_main":
		ensure => present,
		line   => "<link rel=\"stylesheet\" type=\"text/css\" href=\"${theme_path}/css/global.css\">",
		path   => "${bertha::website_home}/includes/css.php",
	}

	$::libraries['js'].each |$js_library| {

		file_line { "js_include_$js_library":
			ensure => present,
			line   => "<script type=\"text/javascript\" src=\"${theme_path}/js/lib/${js_library}.js\"></script>",
			path   => "${bertha::website_home}/includes/js.php",
		}

	}

	file_line { "js_include_main":
		ensure => present,
		line   => "<script type=\"text/javascript\" src=\"${theme_path}/js/main.js\"></script>",
		path   => "${bertha::website_home}/includes/js.php",
	}

}
