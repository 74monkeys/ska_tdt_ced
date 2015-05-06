# Class: lcov::params
#
# This class manages parameters for the lcov module
#
class lcov::params {
  case $::osfamily {
    'RedHat': {
      $lcov_packages = [ 'lcov' ]
    }
    'Debian': {
      $lcov_packages = [ 'lcov' ]
    }
    default: {
      fail("Class['lcov::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
