class jo::user {
  group { 'ubuntu':
    ensure => present,
  }

  user { 'ubuntu':
    name       => 'ubuntu',
    ensure     => present,
    home       => '/home/ubuntu',
    managehome => true,
    shell      => '/bin/bash',
    require    => Group['ubuntu'],
  }

  file { '/home/ubuntu':
    ensure  => directory,
    replace => false,
    owner   => 'ubuntu',
    group   => 'ubuntu',
    require => User['ubuntu'],
  }

  file { '/home/ubuntu/.ssh':
    ensure  => directory,
    replace => false,
    owner   => 'ubuntu',
    group   => 'ubuntu',
    mode    => '0700',
    require => File['/home/ubuntu'],
  }

  $ssh_key_split = extract_ssh_key('/etc/puppet/modules/jo/files/ubuntu.pub')

  ssh_authorized_key { 'ubuntu_pub':
    ensure => present,
    type   => $ssh_key_split[0],
    key    => $ssh_key_split[1],
    name   => $ssh_key_split[2],
    user   => 'ubuntu',
  }

  file { '/etc/sudoers.d/ubuntu':
    ensure  => present,
    content => "ubuntu ALL=(ALL) NOPASSWD: ALL\n",
    mode    => '0440',
  }
}
