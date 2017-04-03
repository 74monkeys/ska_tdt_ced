# Class: system_update::params
#
# This class manages parameters for the system_update module
#
class system_update::params {
  case $::osfamily {
    'RedHat': {
      $system_update_command = [ '/usr/bin/sudo yum -y update' ]
    }
    'Debian': {
      $system_update_command = [ '/usr/bin/sudo apt-get update' ]
    }
    default: {
      fail("Class['system_update::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
