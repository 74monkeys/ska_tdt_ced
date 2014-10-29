# Class: make
#
# This class installs make
#
# Parameters:
#
# Actions:
#   - Install the make package
#

class make(
  $make_packages = $make::params::make_packages,
) inherits make::params {
  ensure_packages($make_packages)
}
