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
  $lcov_packages = $lcov::params::lcov_packages,
) inherits lcov::params {
  ensure_packages($lcov_packages)
}
