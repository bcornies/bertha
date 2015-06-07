class bertha::cache {

  file { $bertha::cache_dir:
    ensure => directory,
  }

}
