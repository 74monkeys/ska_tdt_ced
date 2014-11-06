class artemis {
    require devops
    require cmake
    require gcc
    require fortran
    require pelican
    require cppunit
    require fftw3
    require lapack
    require lofar_dal
    require blas
    require hdf5

    group {
        "artemis":
            ensure => present,
    }

    exec { "get_pelican_lofar":
            command => "$devops::exe checkout pelican-lofar dev"
    }

    exec { "build_pelican_lofar":
            command => "$devops::exe build pelican-lofar dev development/pelican-lofar/dev",
            timeout => 1200,
            require => Exec["get_pelican_lofar"]
    }
}
