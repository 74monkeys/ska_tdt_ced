# Class: cfitsio
#
# This class installs cfitsio
#
# Parameters:
#
# Actions:
#   - Install the cfitsio package
#
# Requires:
#
# Sample Usage:
#
class cfitsio(
  $cfitsio_packages = $cfitsio::params::cfitsio_packages,
) inherits cfitsio::params {
  ensure_packages($cfitsio_packages)
}
