class wordpress::base {

  file { [
    "${bertha::website_home}/web_root",
    "${bertha::website_home}/wp-content",
    "${bertha::website_home}/wp-content/plugins",
    "${bertha::website_home}/wp-content/themes",
    "${bertha::website_home}/wp-content/uploads",
  ]:
    ensure => directory,
  }

  file { "${bertha::website_home}/web_root/wp-config.php":
    ensure => file,
    source => 'puppet:///modules/wordpress/wp-config.php',
  }

  file { "${bertha::website_home}/deploy.xml":
    ensure  => file,
    content => template('wordpress/server/deploy.xml.erb'),
  }

  $gitignore_rules = [
    'wp-content/plugins',
    'wp-content/uploads',
  ]

  $gitignore_rules.each |$rule| {
    bertha::gitignore { $rule: }
  }

}
