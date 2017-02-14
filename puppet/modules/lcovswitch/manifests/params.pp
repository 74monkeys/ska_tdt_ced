# Class: lcovswitch::params
#
# This class sets the lcov module needed
#
class lcovswitch::params {
  if $::osfamily == 'Debian' and $::operatingsystemrelease =~ /^14\./ {
    notice("Debian 14.")
    $lcov_version = 'lcov113'
  }
  else {
    notice("Not version we are targetting")
    $lcov_version = 'lcov'
  }
}
