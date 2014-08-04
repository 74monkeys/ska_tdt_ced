# Class: python::params
#
# This class manages parameters for the python module
#
class python::params {
  case $::osfamily {
    'RedHat': {
      $python_packages = [ 'python_devel' ]
    }
    'Debian': {
      $python_packages = [ 'python-dev' ]
    }
    default: {
      fail("Class['python::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
