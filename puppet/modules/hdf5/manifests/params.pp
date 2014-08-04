# Class: hdf5::params
#
# This class manages parameters for the hdf5 module
#
class hdf5::params {
  case $::osfamily {
    'RedHat': {
      $hdf5_packages = [ 'hdf5_devel' ]
    }
    'Debian': {
      $hdf5_packages = [ 'libhdf5-dev' ]
    }
    default: {
      fail("Class['hdf5::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
