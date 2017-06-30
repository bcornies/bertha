class bertha::tools {

  $package_provider = $::osfamily ? {
    'Darwin' => 'brew',
    'RedHat' => 'yum',
  }

  package { 'wget':
    provider => $package_provider,
    ensure   => installed,
  }

  package { 'mysql':
    provider => $package_provider,
    ensure   => installed,
  }

  file { "${bertha::website_home}/Gemfile":
    ensure  => file,
    content => "source \"https://rubygems.org\"\n\n",
    replace => false,
  }

}
