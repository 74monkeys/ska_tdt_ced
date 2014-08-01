# Class: blas
#
# This class installs blas
#
# Parameters:
#
# Actions:
#   - Install the blas package
#
# Requires:
#
# Sample Usage:
#
class blas(
  $blas_packages = $blas::params::blas_packages,
) inherits blas::params {
  ensure_packages($blas_packages)
}
