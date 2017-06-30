class wordpress (
  $theme_name     = $::website,
  $is_child_theme = false,
  $plugins        = [],
) {

  $theme_dir = "${bertha::website_home}/wp-content/themes/${wordpress::theme_name}"

  contain wordpress::base
  if $is_child_theme {
    contain wordpress::child_theme
  } else {
    contain wordpress::theme
  }

  wordpress::plugin { $plugins: }

}
