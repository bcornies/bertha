class mamp::mongo {

	package { 'mongodb':
		ensure   => installed,
		provider => 'brew',
	}

	package { 'autoconf':
		ensure   => installed,
		provider => 'brew',
	}

	exec { 'install mongo lib':
		command => 'pecl install mongo',
		path    => "${mamp::install_dir}/bin/php/php5.6.1/bin",
		creates => "${mamp::install_dir}/bin/php/php5.6.1/lib/php/extensions/no-debug-non-zts-20131226/mongo.so",
	}

	file { "${mamp::install_dir}/bin/php/php5.6.1/lib/php/extensions/no-debug-non-zts-20131226/mongo.so":
		ensure => file,
		mode   => '775',
	}

	ini_setting { 'mongo.so':
		ensure  => present,
		path    => "${mamp::install_dir}/bin/php/php5.6.1/conf/php.ini",
		section => 'PHP',
		setting => 'extension',
		value   => 'mongo.so',
	}

}
