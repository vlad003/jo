class jo ($apps) {
  
  class { 'jo::packages': }
  class { 'jo::nginx':
    apps => $apps,
    require => Package['nginx'],
  }

  class { 'jo::uwsgi':
    apps => $apps,
    require => Package['uwsgi'],
  }

  class { 'jo::user': }
}
