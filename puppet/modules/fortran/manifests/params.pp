# Class: fortran::params
#
# This class manages parameters for the fortran module
#
# Parameters:
#
class fortran::params {
  case $::osfamily {
    'RedHat': {
      $fortran_packages = [ 'gcc-gfortran' ]
    }
    'Debian': {
      $fortran_packages = [ 'gfortran', 'build-essential' ]
    }
    default: {
      fail("Class['fortran::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
