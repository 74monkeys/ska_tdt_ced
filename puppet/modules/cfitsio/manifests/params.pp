# Class: cfitsio::params
#
# This class manages parameters for the cfitsio module
#
class cfitsio::params {
  case $::osfamily {
    'RedHat': {
      $cfitsio_packages = [ 'cfitsio_devel' ]
    }
    'Debian': {
      $cfitsio_packages = [ 'libcfitsio3-dev' ]
    }
    default: {
      fail("Class['cfitsio::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
