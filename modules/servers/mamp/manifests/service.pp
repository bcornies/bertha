class mamp::service {

	service { 'apachectl':
		ensure     => running,
		status     => 'pgrep httpd',
		start      => "sudo ${mamp::install_dir}/Library/bin/apachectl start",
		restart    => "sudo ${mamp::install_dir}/Library/bin/apachectl restart",
		stop       => "sudo ${mamp::install_dir}/Library/bin/apachectl stop",
		hasrestart => true,
		provider   => 'init',
		path       => ["${mamp::install_dir}/Library/bin"],
	}

	# I have no idea how to manage the mysqld service from Puppet...
	exec { 'echo "mysql needs to be started from the MAMP console!"':
		unless => 'pgrep mysqld',
	}

	# ...this feels like it _should_ work but it doesn't
	# service { 'mysql':
	#   ensure   => running,
	#   stop     => 'stopMysql.sh',
	#   start    => 'startMysql.sh',
	#   provider => 'base',
	#   status   => 'pgrep mysql',
	#   path     => ["${install_dir}/bin"],
	# }

}
