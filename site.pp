node default {
  class { 'jo':
    apps => { 'wm'    => '3031',
              'utils' => '3032' }
  }
}
