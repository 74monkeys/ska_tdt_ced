# Class: lcovswitch::params
#
# This class sets the lcov module needed
#
class lcov::params {
  if $::osfamily == 'Debian' and $::operatingsystemrelease =~ /^14\./ {
    $lcov_version = 'lcov::lcov113'
  }
  else {
    case $::osfamily {
      'RedHat': {
        $lcov_version = 'lcov::lcov113'
        $lcov_packages = [ 'lcov' ]
      }
      'Debian': {
        $lcov_version = 'lcov::lcov_standard'
        $lcov_packages = [ 'lcov' ]
      }
      default: {
        fail("Class['lcov::params']: Unsupported osfamily: ${::osfamily}")
      }
    }
  }
}
