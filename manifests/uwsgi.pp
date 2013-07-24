class jo::uwsgi ($apps) {

  service { 'uwsgi':
    enable     => true,
    ensure     => running,
    hasrestart => true,
    hasstatus  => true,
  }

  # to mimic a for loop, we'll have $apps be a hash
  # We'll create a uwsgi_app resource for each key in $apps
  # Inside the resource we'll access the external $apps hash
  # to get the port which is needed in the template

  define uwsgi_app ($app) {
    $port = $apps[$app]

    file { "/etc/uwsgi/apps-available/$app.ini":
      ensure  => present,
      content => template('jo/uwsgi_app.ini.erb'),
    }
    file { "/etc/uwsgi/apps-enabled/$app.ini":
      ensure  => link,
      target  => "/etc/uwsgi/apps-available/$app.ini",
      require => File["/etc/uwsgi/apps-available/$app.ini",
    }
  }

  uwsgi_app { keys($apps):
    notify => Service ['uwsgi'],
  }
}
