class jo::packages {

  Package { ensure => installed, }

  package { 'nginx' : }
  package { 'uwsgi' : }

}
