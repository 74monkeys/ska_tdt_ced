# Class: gsl
#
# This class installs gsl (GNU Scientific Library)
#
# Parameters:
#
# Actions:
#   - Install the gsl package
#
# Requires:
#
# Sample Usage:
#
class gsl(
  $gsl_packages = $gsl::params::gsl_packages,
) inherits gsl::params {
  ensure_packages($gsl_packages)
}
