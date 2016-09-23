if !$::website {
  fail('You must specify a website name!')
}

validate_re(
  $::website,
  '^[A-Za-z0-9\-\.]+$',
  'The website name can only contain letters, numbers, underscores and dots.'
)

File {
  backup => false,
  owner  => $::user,
  group  => 'staff',
}

Exec {
  logoutput => on_failure,
  path      => hiera('default_path'),
  user      => $::user,
  group     => 'staff',
}

$builder         = hiera('builder', undef)
$cms             = hiera('cms', undef)
$frameworks      = hiera('frameworks', undef)
$library_manager = hiera('library_manager', undef)

include bertha
include $builder
include $cms
include $frameworks
include $library_manager
