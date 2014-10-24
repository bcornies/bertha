class mamp (
  $install_dir = '/Applications/MAMP',
  $port = 80,
  ) {

  file { "${install_dir}/conf/apache/httpd.conf":
    ensure  => file,
    content => template('mamp/httpd.conf.erb'),
  }

  service { 'apachectl':
    ensure     => running,
    status     => 'pgrep httpd',
    start      => "sudo ${install_dir}/Library/bin/apachectl start",
    restart    => "sudo ${install_dir}/Library/bin/apachectl restart",
    stop       => "sudo ${install_dir}/Library/bin/apachectl stop",
    hasrestart => true,
    provider   => 'init',
    path       => ["${install_dir}/Library/bin"],
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

  File["${install_dir}/conf/apache/httpd.conf"] ~>
  Service['apachectl']

}
