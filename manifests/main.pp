if !$::website {
  fail('You must specify a website name!')
}

$template = hiera('template')

include bertha
