# Class: cmake::params
#
# This class manages parameters for the cmake module
#
class cmake::params {
  case $::osfamily {
    'RedHat': {
      $cmake_packages = [ 'cmake' ]
    }
    'Debian': {
      $cmake_packages = [ 'cmake', 'cmake-curses-gui' ]
    }
    default: {
      fail("Class['cmake::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
