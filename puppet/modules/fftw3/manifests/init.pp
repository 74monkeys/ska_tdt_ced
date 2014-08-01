# Class: fftw3
#
# This class installs fftw3
#
# Parameters:
#
# Actions:
#   - Install the fftw3 package
#
# Requires:
#
# Sample Usage:
#
class fftw3(
  $fftw3_packages = $fftw3::params::fftw3_packages,
) inherits fftw3::params {
  ensure_packages($fftw3_packages)
}
