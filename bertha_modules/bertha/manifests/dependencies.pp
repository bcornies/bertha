class bertha::dependencies {

  file { [
    "${::home}/.ant",
    "${::home}/.ant/lib",
  ]:
    ensure => directory,
  }

  $antlibs = [
    'commons-net-3.0.1.jar',
    'compiler.jar',
    'yuicompressor-2.4.7.jar',
  ]

  $antlibs.each |$antlib| {
    file { "${::home}/.ant/lib/${antlib}":
      ensure => file,
      source => "puppet:///modules/bertha/ant/${antlib}",
      mode   => '0644',
    }
  }

}
