# Class: boost
#
# This class installs boost
#
# Parameters:
#
# Actions:
#   - Install the boost package
#
# Requires:
#
# Sample Usage:
#
class boost(
  $boost_packages = $boost::params::boost_packages,
) inherits boost::params {
  ensure_packages($boost_packages)
}
