# Class: boost::params
#
# This class manages parameters for the boost module
#
class boost::params {
  case $::osfamily {
    'RedHat': {
      $boost_packages = [ 'boost' ]
    }
    'Debian': {
      $boost_packages = [ 'libboost-all-dev', 'libboost-filesystem-dev' ]
    }
    default: {
      fail("Class['boost::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
