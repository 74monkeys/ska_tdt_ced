# Class: cppunit::params
#
# This class manages parameters for the cppunit module
#
class cppunit::params {
  case $::osfamily {
    'RedHat': {
      $cppunit_packages = [ 'cppunit' ]
    }
    'Debian': {
      $cppunit_packages = [ 'libcppunit-dev' ]
    }
    default: {
      fail("Class['cppunit::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
