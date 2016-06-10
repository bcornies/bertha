notify { 'please work': }

file { '/tmp/bryan_copy.test':
  ensure => file,
  source => 'file:///tmp/bryan.test',
  # backup => false,
}
