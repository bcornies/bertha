class concrete5::tools {

  package { 'mysql':
    ensure   => present,
    provider => 'brew',
  }

}
