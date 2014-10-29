# Class: make::params
#
# This class manages parameters for the make module
#
class make::params {
  case $::osfamily {
    'RedHat': {
      $make_packages = [ 'make' ]
    }
    'Debian': {
      $make_packages = [ 'make' ]
    }
    default: {
      fail("Class['make::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
