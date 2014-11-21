class bertha (
  $websites_dir,
  $is_cms,
  $view_mode,
  $mysql_path,
  $dock_dir = undef,
  $sites = {},
  $dist_items = [],
  $include_libraries = {},
) {

  $website_home="${websites_dir}/${::website}"

  file { [
      "${bertha::website_home}/js",
      "${bertha::website_home}/css",
      "${bertha::website_home}/includes",
    ]:
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
  }

  file { [
      $bertha::website_home,
      "${bertha::website_home}/img",
    ]:
    ensure => directory,
  }

  file { "${bertha::website_home}/js/main.js":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/bertha/main.js',
  }

  file { "${bertha::website_home}/includes/css.php":
    ensure  => file,
    content => template("${::dock}/css.php.erb"),
  }

  file { "${bertha::website_home}/includes/js.php":
    ensure  => file,
    content => template("${::dock}/js.php.erb"),
  }

  file { [
      "${bertha::website_home}/puppet",
      "${bertha::website_home}/puppet/manifests",
      "${bertha::website_home}/puppet/modules",
    ]:
    ensure  => directory,
  }

  file { "${bertha::website_home}/Vagrantfile":
    ensure  => file,
    content => template("bertha/Vagrantfile.erb"),
  }

  file { "${bertha::website_home}/puppet/manifests/site.pp":
    ensure  => file,
    content => template("bertha/site.pp.erb"),
  }

  file { "${bertha::website_home}/.gitignore":
    ensure  => file,
  }

  [
    'puppet/modules',
    '.tmp',
    '.librarian',
    '.vagrant',
    '.sass',
  ].each |$line| {
    file_line { "gitignore_${line}":
      ensure => present,
      line   => $line,
      path   => "${bertha::website_home}/.gitignore",
    }
  }

  file { "${bertha::website_home}/puppet/Puppetfile":
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/bertha/Puppetfile'
  }

  exec { 'librarian-puppet install':
    cwd         => "${bertha::website_home}/puppet",
    refreshonly => true,
  }


}
