if !$::website {
  fail('You must specify a website name!')
}

if $::website =~ /^[A-Za-z0-9\-\.]+$/ {
  notice("Website named '${::website}' is valid.")
} else {
  fail("Website named '${::website}' is invalid. The website name can only contain letters, numbers, dashes and dots.")
}

$sites_test = lookup('bertha::sites', { default_value => undef })
if $sites_test {
  notice("Found configuration file for website named '${::website}'")
} else {
  fail("Could not find a valid configuration file for website named '${::website}'")
}

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

$builder         = lookup('builder', { default_value => undef })
$cms             = lookup('cms', { default_value => undef })
$frameworks      = lookup('frameworks', { default_value => undef })
$library_manager = lookup('library_manager', { default_value => undef })

include bertha
include $builder
include $cms
include $frameworks
include $library_manager
