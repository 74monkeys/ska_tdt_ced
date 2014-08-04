# Class: git
#
# This class installs git client
#
# Sample Usage:
#  include git::client
#

class git::client {
  case $::osfamily {
    'RedHat': {
      $git_package_name = [ 'git' ]
    }
    'Debian': {
      if $lsbmajdistrelease <= 10 {
         $git_package_name = 'git-core'
      }
      else {
         $git_package_name = [ 'git' ]
      }
    }
    default: {
      fail("Class['git::client']: Unsupported osfamily: ${::osfamily}")
    }
  }

  package { $git_package_name:
    ensure => installed,
  }
}
