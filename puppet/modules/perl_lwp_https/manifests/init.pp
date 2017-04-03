# Class: perl_lwp_https
#
# This class installs perl_lwp_https
#
# Sample Usage:
#  include perl_lwp_https
#


class perl_lwp_https {

  case $::osfamily {
    'RedHat': {
        $perl_lwp_https_package_name = [ 'perl-LWP-Protocol-https' ]
    }
    'Debian': {
        $perl_lwp_https_package_name = 'liblwp-protocol-https-perl'
    }
    default: {
        # use cpan
        require cpan
        cpan { "LWP::Protocol::https":
                ensure  => present,
        }
    }
  }

  package { $perl_lwp_https_package_name:
    ensure => installed,
  }
}
