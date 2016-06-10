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
class local_libs (
  $libraries_dir    = "${::home}/libraries",
  $libraries        = $bertha::libraries,
  $project_libs_dir = getvar("${cms}::theme::theme_dir"),
) {

  $libraries.each |$library_type, $libs| {

    $libs.each |$lib| {

      # Find the source file for the library

      if $lib['version'] {
        $file_source = "file://${libraries_dir}/${library_type}/${lib['name']}-${lib['version']}.${library_type}"
      } else {
        $file_source = "file://${libraries_dir}/${library_type}/${lib['name']}.${library_type}"
      }

      # Now delegate to the cms for what to do with it

      create_resources("${cms}::lib::library_source", {
        "${lib['name']}.${library_type}" => {
          type   => $library_type,
          source => $file_source,
        }
      })

      case $library_type {
        'js': {
          create_resources("${cms}::lib::include_script", {
            $lib['name'] => {
              'version' => $lib['version'],
            }
          })
        }
        'css': {
          create_resources("${cms}::lib::include_stylesheet", {
            $lib['name'] => {
              'version' => $lib['version'],
            }
          })
        }
        default: {
          fail ("Unspported library_type: ${library_type}")
        }

      }

    }

  }

}
