# Class: jenkins
#
# This class installs jenkins
#
# Parameters:
#
# Actions:
#   - Install the jenkins package
#
# Requires:
#
# Sample Usage:
#
class jenkins(
  $jenkins_packages = $jenkins::params::jenkins_packages,
) inherits jenkins::params {
  ensure_packages($jenkins_packages)

  file_line { 'jenkins_default' : 
              path => '/etc/default/jenkins',
              line => 'JENKINS_ARGS="--webroot=/var/cache/jenkins/war --httpPort=$HTTP_PORT --ajp13Port=$AJP_PORT --prefix=$PREFIX"',
              match => 'JENKINS_ARGS=*'
            }
}
