class perl {

  $exe = "/usr/bin/perl"
  $cpan = "/usr/bin/cpan"

  case $::osfamily {
          'RedHat': {
              $perl_packages = [ 'perl' ]
          }
          'Debian': {
              $perl_packages = [ 'perl' ]
          }
          default: {
              warning("Class['perl::params']: Unsupported osfamily: ${::osfamily}")
              $perl_packages = [ 'perl' ]
          }
   }

    ensure_packages($perl_packages)
}
