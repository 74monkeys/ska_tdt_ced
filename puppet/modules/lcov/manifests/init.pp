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
class lcov(
  $lcov_version = $lcov::params::lcov_version,
) inherits lcov::params {
  require $lcov_version
}
