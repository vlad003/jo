class jo ($apps) {
  
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
