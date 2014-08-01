# Class: qt4::params
#
# This class manages parameters for the qt4 module
#
# Parameters:
#
# Actions:
#
class qt4::params {
  case $::osfamily {
    'RedHat': {
      $qt4_packages = [ 'qt4_devel', 'qwt5_devel' ]
    }
    'Debian': {
      $qt4_packages = [ 'libqt4-dev', 'libqwt5-qt4-dev' ]
    }
    default: {
      fail("Class['qt4::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
