# Class: blas::params
#
# This class manages parameters for the blas module
#
class blas::params {
  case $::osfamily {
    'RedHat': {
      $blas_packages = [ 'blas_devel' ]
    }
    'Debian': {
      $blas_packages = [ 'libblas-dev' ]
    }
    default: {
      fail("Class['blas::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
