# Class: fftw3::params
#
# This class manages parameters for the fftw3 module
#
class fftw3::params {
  case $::osfamily {
    'RedHat': {
      $fftw3_packages = [ 'fftw3_devel' ]
    }
    'Debian': {
      $fftw3_packages = [ 'libfftw3-dev' ]
    }
    default: {
      fail("Class['fftw3::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
