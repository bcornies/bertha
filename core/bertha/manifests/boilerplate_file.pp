define bertha::boilerplate_file (
  $boilerplate_key,
  $default_source,
) {

  file { $title:
    ensure  => file,
    replace => false,
    source  => [
      "file://${bertha::boilerplate_dir}/${boilerplate_key}",
    ] << $default_source,
  }

}
