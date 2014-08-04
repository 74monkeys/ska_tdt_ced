# Class: hdf5
#
# This class installs hdf5
#
# Parameters:
#
# Actions:
#   - Install the hdf5 package
#
class hdf5(
  $hdf5_packages = $hdf5::params::hdf5_packages,
) inherits hdf5::params {
  ensure_packages($hdf5_packages)
}
