# Class: qt4
#
# This class installs qt4
#
# Parameters:
#
# Actions:
#   - Install the qt4 package
#
# Requires:
#
# Sample Usage:
#
class qt4(
  $qt4_packages = $qt4::params::qt4_packages,
) inherits qt4::params {
  ensure_packages($qt4_packages)
}
