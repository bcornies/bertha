class bertha::includes {

  notify { 'Am I even used???': }

  file { [
    "${bertha::website_home}/includes/css.php",
    "${bertha::website_home}/includes/js.php",
  ]:
    ensure => file,
  }

  $theme_path = chomp(template("${::cms}/theme_path.erb"))

  if has_key($bertha::libraries, 'css') {
    $bertha::libraries['css'].each |$css_library| {
      file_line { "css_include_$css_library":
        ensure => present,
        line   => "<link rel=\"stylesheet\" type=\"text/css\" href=\"${theme_path}/css/lib/${css_library}.css\">",
        path   => "${bertha::website_home}/includes/css.php",
      }
    }
  }

  file_line { "css_include_main":
    ensure => present,
    line   => "<link rel=\"stylesheet\" type=\"text/css\" href=\"${theme_path}/css/global.css\">",
    path   => "${bertha::website_home}/includes/css.php",
  }

  if has_key($bertha::libraries, 'js') {
    $bertha::libraries['js'].each |$js_library| {
      file_line { "js_include_$js_library":
        ensure => present,
        line   => "<script type=\"text/javascript\" src=\"${theme_path}/js/lib/${js_library}.js\"></script>",
        path   => "${bertha::website_home}/includes/js.php",
      }
    }
  }

  file_line { "js_include_main":
    ensure => present,
    line   => "<script type=\"text/javascript\" src=\"${theme_path}/js/main.js\"></script>",
    path   => "${bertha::website_home}/includes/js.php",
  }

}
