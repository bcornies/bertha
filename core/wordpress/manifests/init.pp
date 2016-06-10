class wordpress (
  $theme_name = $::website,
  $plugins    = [],
) {

  $theme_dir = "${bertha::website_home}/wp-content/themes/${wordpress::theme_name}"  

  contain wordpress::base
  contain wordpress::theme
  wordpress::plugin { $plugins: }

}
