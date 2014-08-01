# Class: fortran
#
# This class installs fortran
#
# Parameters:
#
# Actions:
#   - Install the fortran package
#
# Requires:
#
# Sample Usage:
#
class fortran(
  $fortran_packages = $fortran::params::fortran_packages,
) inherits fortran::params {
  ensure_packages($fortran_packages)
}
