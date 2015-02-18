# Class: jenkins
#
# This class installs jenkins
#   - install from the jenkins repositories  
#   - setup configuration from a provided git
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
    $configuration_repo = undef
) inherits jenkins::params {

  require jenkins::install

  jenkins::configuration { 'config': 
                           repo => $configuration_repo,
                           require => Class['jenkins::install'],
                           notify => Service['jenkins']
                         }

  file_line { 'jenkins_default' : 
              path => '/etc/default/jenkins',
              line => 'JENKINS_ARGS="--webroot=/var/cache/jenkins/war --httpPort=$HTTP_PORT --ajp13Port=$AJP_PORT --prefix=$PREFIX"',
              match => 'JENKINS_ARGS=*',
              require => Class['jenkins::install'],
              notify => Service['jenkins']
            }

  service { 'jenkins':
    enable => 'true',
    ensure => 'running'
  }
}
