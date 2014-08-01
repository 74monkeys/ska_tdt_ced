# Class: lapack
#
# This class installs lapack
#
# Parameters:
#
# Actions:
#   - Install the lapack package
#
# Requires:
#
# Sample Usage:
#
class lapack(
  $lapack_packages = $lapack::params::lapack_packages,
) inherits lapack::params {
  ensure_packages($lapack_packages)
}
