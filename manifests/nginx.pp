class jo::nginx ($apps) {

  service { 'nginx':
    enable     => true,
    ensure     => running,
    hasrestart => true,
    hasstatus  => true,
  }

  file { 'main.conf':
    ensure  => present,
    path    => '/etc/nginx/sites-available/main.conf',
    content => template('jo/nginx_main.conf.erb'),
  }

  file { '/etc/nginx/sites-enabled/main.conf':
    ensure  => link,
    target  => '/etc/nginx/sites-available/main.conf',
    notify  => Service['nginx'],
    require => File['main.conf'],
  }

  file { '/var/www':
    ensure  => directory,
    replace => false,
    owner   => 'ubuntu',
    group   => 'ubuntu',
    require => User['ubuntu'],
  }
}
