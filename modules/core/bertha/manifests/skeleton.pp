class bertha::skeleton {

	file { [
		"${bertha::website_home}/js",
		"${bertha::website_home}/css",
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

	file { "${bertha::website_home}/js/main.js":
		ensure  => file,
		replace => false,
		source  => 'puppet:///modules/bertha/main.js',
	}

	file { "${bertha::website_home}/includes/css.php":
		ensure  => file,
		content => template("${::dock}/css.php.erb"),
		}

	file { "${bertha::website_home}/includes/js.php":
		ensure  => file,
		content => template("${::dock}/js.php.erb"),
	}

}
