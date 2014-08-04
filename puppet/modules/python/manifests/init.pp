# Class: python
#
# This class installs python
#
# Parameters:
#
# Actions:
#   - Install the python package
#
# Requires:
#
# Sample Usage:
#
class python(
  $python_packages = $python::params::python_packages,
) inherits python::params {
  ensure_packages($python_packages)
}
