class lcov::lcov_standard(
  $lcov_packages = $lcov::params::lcov_packages,
) inherits lcov::params {
  ensure_packages($lcov_packages)
}
