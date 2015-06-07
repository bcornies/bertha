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

	if $bertha::is_cms {
		file { [
			"${bertha::website_home}/content",
			"${bertha::website_home}/content/uploads",
		]:
			ensure  => directory,
		}
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

	create_resources("${cms}::include_script", {
    'main' => {
      'path' => 'js',
    }
  })

	boilerplate_file { "${bertha::website_home}/css/global.css":
		boilerplate_key => 'global.css',
		default_source  => 'puppet:///modules/bertha/global.css',
	}

	create_resources("${cms}::include_stylesheet", {
    'global' => {
      'path' => 'css',
    }
  })

	if defined("${::cms}::includes") {
		debug("Found class ${::cms}::includes. Including in catalog.")
		include "${::cms}::includes"
	} else {
		debug("${::cms}::includes is not defined. Falling back to default bertha::includes.")
		include bertha::includes
	}

}
