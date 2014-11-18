# Class: gsl::params
#
# This class manages parameters for the gsl module
#
class gsl::params {
  case $::osfamily {
    'RedHat': {
      $gsl_packages = [ 'gsl_devel' ]
    }
    'Debian': {
      $gsl_packages = [ 'libgsl0-dev' ]
    }
    default: {
      fail("Class['gsl::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
