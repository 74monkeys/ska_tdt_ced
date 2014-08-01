# Class: cmake
#
# This class installs cmake
#
# Parameters:
#
# Actions:
#   - Install the cmake package
#
# Requires:
#
# Sample Usage:
#
class cmake(
  $cmake_packages = $cmake::params::cmake_packages,
) inherits cmake::params {
  ensure_packages($cmake_packages)
}
