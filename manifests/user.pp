class jo::user {
  user { 'ubuntu':
    name       => 'ubuntu',
    ensure     => present,
    home       => '/home/ubuntu',
    managehome => true,
    shell      => '/bin/bash',
  }

  $ssh_key => 'puppet:///modules/jo/id_rsa.pub'

  ssh_authorized_key { 'ubuntu_pub':
    ensure => present,
    type   => extract_ssh_key($ssh_key)[0],
    key    => extract_ssh_key($ssh_key)[1],
    name   => extract_ssh_key($ssh_key)[2],
    user   => 'ubuntu',
  }
}



