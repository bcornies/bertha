define sass::includes {

  ensure_resource('file', "${bertha::website_home}/scss/_includes.scss", {
    'ensure' => 'file',
  })

  file_line { "sass_includes_${title}":
    ensure => present,
    line   => "@import '${title}';",
    path   => "${bertha::website_home}/scss/_includes.scss",
  }

}
