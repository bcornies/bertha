# == Class: local
#
# The local library manager is a simple way of including any third-party libraries
# (js, css, scss files, etc.) you depend on in your website. It looks for a local
# library "repository" on your filesystem and copies all specified libraries into
# your website's appropriate directories.
#
# === Parameters
#
# [*libraries_dir*]
#   The location of your local library "repository". Your repository should be organized
#   as follows:
#
#   <libraries_dir>
#     - js
#       - jquery-1.11.1.js
#       - ...other js libs
#     - css
#       - cssreset.css
#       - ...other css libs
#
# === Variables
#
# [*libraries*]
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
  $libraries_dir = "${::home}/libraries",
) {

  $::libraries.each |$library_type, $libraries| {

    $libraries.each |$library| {

      file { "${bertha::website_home}/${library_type}/lib/${library}.${library_type}":
        ensure => file,
        source => "file://${libraries_dir}/${library_type}/${library}.${library_type}",
      }

    }

  }

}
