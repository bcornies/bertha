class local (
  $packages_dir = "${::home}/packages",
) {

  $::packages.each |$package_type, $packages| {

    file { [
      "${bertha::website_home}/${package_type}/lib",
    ]:
      ensure => directory,
      recurse => true,
      purge   => true,
      force   => true,
    }

    $packages.each |$package| {

      file { "${bertha::website_home}/${package_type}/lib/${package}.${package_type}":
        ensure => file,
        source => "file://${packages_dir}/${package_type}/${package}.${package_type}",
      }

    }

  }

}
