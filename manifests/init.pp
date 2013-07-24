class jo {

  # app => port
  $apps => { 'wm'    => '3031',
             'utils' => '3032',
  }
  
  class { 'jo::packages': }
  class { 'jo::nginx':
    apps => $apps,
    require => Package['nginx'],
  }

  class { 'jo::uwsigi':
    apps => $apps,
    require => Package['nginx'],
  }
}
