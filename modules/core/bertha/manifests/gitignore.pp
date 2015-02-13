define bertha::gitignore {

  ensure_resource('file', "${bertha::website_home}/.gitignore", {
    'ensure' => 'file',
  })

  file_line { "gitignore_${title}":
    ensure => present,
    line   => $title,
    path   => "${bertha::website_home}/.gitignore",
  }

}
