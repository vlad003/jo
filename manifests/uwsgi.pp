class jo::uwsgi ($apps) {

  file { '/etc/init/uwsgi.conf':
    ensure => present,
    source => 'puppet:///modules/jo/upstart_uwsgi.conf',
    before => Service['uwsgi'],
  }

  service { 'uwsgi':
    enable     => true,
    ensure     => running,
    hasrestart => true,
    hasstatus  => true,
  }

  file { ['/etc/uwsgi',
          '/etc/uwsgi/apps-enabled',
          '/etc/uwsgi/apps-available']:
    ensure => directory,
    replace => false,
  }

  # to mimic a for loop, we'll have $apps be a hash
  # We'll create a uwsgi_app resource for each key in $apps
  # Inside the resource we'll access the external $apps hash
  # to get the port which is needed in the template

  define uwsgi_app ($apps) {
    $app = $title
    $port = $apps[$app]

    file { "/etc/uwsgi/apps-available/$app.ini":
      ensure  => present,
      content => template('jo/uwsgi_app.ini.erb'),
    }
    file { "/etc/uwsgi/apps-enabled/$app.ini":
      ensure  => link,
      target  => "/etc/uwsgi/apps-available/$app.ini",
      require => File["/etc/uwsgi/apps-available/$app.ini"],
    }
  }

  $apps_keys = keys($apps)

  uwsgi_app { $apps_keys:
    apps    => $apps,
    notify  => Service['uwsgi'],
    require => File['/etc/uwsgi/apps-enabled', '/etc/uwsgi/apps-available'],
  }
}
