class mamp (
  $install_dir = '/Applications/MAMP',
  $port = 80,
) {

  contain mamp::install
  contain mamp::config
  contain mamp::mongo
  contain mamp::service

  Class['mamp::config'] ~>
  Class['mamp::service']

  Class['mamp::mongo'] ~>
  Class['mamp::service']

}
