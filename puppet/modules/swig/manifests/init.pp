# Class: swig
#
# This class installs swig
#
# Parameters:
#
# Actions:
#   - Install the swig package
#
# Requires:
#
# Sample Usage:
#
class swig(
  $swig_packages = $swig::params::swig_packages,
) inherits swig::params {
  ensure_packages($swig_packages)
}
