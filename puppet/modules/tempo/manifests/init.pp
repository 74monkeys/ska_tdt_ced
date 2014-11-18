class tempo {

    package { "csh":
               ensure => "installed"
            }
    package { "autoconf":
               ensure => "installed"
            }

    require cfitsio
    require fortran
    require fftw3
    require devops
    require gcc
    require gsl

    exec { "get_tempo":
            command => "$devops::exe checkout tempo dev development/tempo/dev"
    }

    exec { "build_tempo":
            command => "$devops::exe build tempo dev development/tempo/dev",
            timeout => 1200,
            require => [Exec["get_tempo"], Package["autoconf"], Package["csh"]];
    }
}
