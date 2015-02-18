class jenkins::repos()
{
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
      fail("Class['jenkins::install']: Unsupported osfamily: ${::osfamily}")
    }
  }
}

class jenkins::install()
{
    require jenkins::repos
    ensure_packages($jenkins::repos::jenkins_packages)
}

