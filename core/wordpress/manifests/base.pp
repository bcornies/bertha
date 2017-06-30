class wordpress::base {

  file { [
    "${bertha::website_home}/data",
    "${bertha::website_home}/data/sql",
    "${bertha::website_home}/wp-content",
    "${bertha::website_home}/wp-content/plugins",
    "${bertha::website_home}/wp-content/themes",
    "${bertha::website_home}/wp-content/uploads",
  ]:
    ensure => directory,
  }

  file { "${bertha::website_home}/deploy.xml":
    ensure  => file,
    content => template('wordpress/server/deploy.xml.erb'),
  }

  $gitignore_rules = [
    'wp-content/plugins',
    'wp-content/uploads',
    'wp-content/index.php',
    'wp-content/themes/twenty*',
    'wp-content/themes/index.php',
    'www/*',
    '!www/.htaccess',
  ]

  $gitignore_rules.each |$rule| {
    bertha::gitignore { $rule: }
  }

}
