class mamp::config {

	file { "${mamp::install_dir}/conf/apache/httpd.conf":
		ensure  => file,
		content => template('mamp/httpd.conf.erb'),
	}

	# Fix extension_dir php config (it's not set properly for some reason)
	ini_setting { "php extension_dir":
	  ensure  => present,
	  path    => "${mamp::install_dir}/bin/php/php5.6.1/conf/php.ini",
	  section => 'PHP',
	  setting => 'extension_dir',
	  value   => "${mamp::install_dir}/bin/php/php5.6.1/lib/php/extensions/no-debug-non-zts-20131226",
	}

}
