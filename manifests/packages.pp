class jo::packages {

  Package { ensure => installed, }

  package { 'nginx': }
  package { 'git': }
  package { 'acl': }
  package { 'python-pip': }
  package { 'build-essential': }
  package { 'python': }
  package { 'python-dev':
    require => Package['python'],
  }
  package { 'uwsgi' :
    provider => 'pip',
    require  => Package['python-pip', 'python', 'build-essential'],
  }

}
