# Class: lcov
#
# This class installs lcov
#
# Parameters:
#
# Actions:
#   - Install the lcov package
#
# Requires:
#
# Sample Usage:
#
class lcovswitch(
  $lcov_version = $lcovswitch::params::lcov_version,
) inherits lcovswitch::params {
  require $lcov_version
}
