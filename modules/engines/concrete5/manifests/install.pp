class concrete5::install {

  $archive_file = "concrete${concrete5::version}.zip"

  $download_url = $concrete5::version? {
    '5.6.3.1' => 'http://www.concrete5.org/download_file/-/view/66159/8497/',
    default   => undef,
  }

  if !$download_url {
    fail("Unsupported version of Concrete5 specified: ${concrete5::version}")
  }

  package { 'wget':
    ensure   => installed,
    provider => brew,
  }

  ->

  exec { 'download concrete5':
    command => "wget -O ${archive_file} ${download_url}",
    cwd     => $bertha::dock_dir,
    creates => "${bertha::dock_dir}/concrete${concrete5::version}",
    path    => [ '/usr/local/bin' ],
  }

  ->

  exec { 'unpack concrete5':
    command => "unzip -o ${archive_file}",
    cwd     => $bertha::dock_dir,
    creates => "${bertha::dock_dir}/concrete${concrete5::version}",
    path    => [ '/usr/bin' ],
  }

  ->

  file { "${bertha::dock_dir}/${archive_file}": 
    ensure => absent,
  }

}
