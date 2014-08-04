# Class: swig::params
#
# This class manages parameters for the swig module
#
class swig::params {
  case $::osfamily {
    'RedHat': {
      $swig_packages = [ 'swig' ]
    }
    'Debian': {
      $swig_packages = [ 'swig' ]
    }
    default: {
      fail("Class['swig::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
