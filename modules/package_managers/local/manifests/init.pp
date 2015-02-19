# == Class: local
#
# The local package manager is a simple way of including any third-party packages
# (js, css, scss files, etc.) you depend on in your website. It looks for a local
# package "repository" on your filesystem and copies all specified packages into
# your website's appropriate directories.
#
# === Parameters
#
# [*packages_dir*]
#   The location of your local package "repository". Your repository should be organized
#   as follows:
#
#   <packages_dir>
#     - js
#       - jquery-1.11.1.js
#       - ...other js libs
#     - css
#       - cssreset.css
#       - ...other css libs
#
# === Variables
#
# [*packages*]
#   This should be set in an approprate *.yaml file in the configuration directory.
#   See defaults.yaml.template for an example.
#
# === Examples
#
#  class { 'example_class':
#    ntp_servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Bryan Cornies <bryan@sixsquarestudio.com>
#
class local (
  $packages_dir = "${::home}/packages",
) {

  $::packages.each |$package_type, $packages| {

    $packages.each |$package| {

      file { "${bertha::website_home}/${package_type}/lib/${package}.${package_type}":
        ensure => file,
        source => "file://${packages_dir}/${package_type}/${package}.${package_type}",
      }

    }

  }

}
