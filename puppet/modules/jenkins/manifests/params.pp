# Class: jenkins::params
#
# This class manages parameters for the jenkins module
#
class jenkins::params {
  case $::osfamily {
    'RedHat': {
      yumrepo { 'jenkins':
        baseurl => 'http://pkg.jenkins-ci.org/redhat/jenkins.repo',
        gpgcheck => 1,
        enabled=> 1,
        gpgkey => 'http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key'
      }
      $jenkins_packages = [ 'jenkins' ]
    }
    'Debian': {
        if !defined(Class['apt']) {
            class { 'apt': }
        }

        apt::key { 'jenkins':
            key => '9B7D32F2D50582E6',
            key_source => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
            ensure => 'present'
        }

        apt::source { 'jenkins':
            location => 'http://pkg.jenkins-ci.org/debian-stable',
            release => '',
            repos => 'binary/',
            include_src => false,
            require => Apt::Key['jenkins']
        }
      
      $jenkins_packages = [ 'jenkins' ]
    }
    default: {
      fail("Class['jenkins::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
}
