# Class: lapack::params
#
# This class manages parameters for the lapack module
#
class lapack::params {
  case $::osfamily {
    'RedHat': {
      $lapack_packages = [ 'lapack-devel' ]
    }
    'Debian': {
      $lapack_packages = [ 'liblapack-dev' ]
    }
    default: {
      fail("Class['lapack::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
