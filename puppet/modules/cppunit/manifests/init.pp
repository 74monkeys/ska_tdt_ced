# Class: cppunit
#
# This class installs cppunit
#
# Parameters:
#
# Actions:
#   - Install the cppunit package
#
class cppunit(
  $cppunit_packages = $cppunit::params::cppunit_packages,
) inherits cppunit::params {
  ensure_packages($cppunit_packages)
}
