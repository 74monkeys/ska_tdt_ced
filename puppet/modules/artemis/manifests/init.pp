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

    Package { ensure => "installed" }

    group {
        "artemis":
            ensure => present,
    }

    $devdir = "$devops::devdir/pelican-lofar"
    $srcdir = "$devdir/src"
    $builddir = "$devdir/build"

    file { "$devdir":
      ensure => "directory",
      owner => "vagrant"
    }

    file { "$builddir":
      ensure => "directory",
      require => File["$devdir"],
      owner => "vagrant"
    }

    vcsrepo { "$srcdir":
      require => File["$devdir"],
      ensure   => present,
      provider => git,
      source   => "https://github.com/pelican/pelican-lofar.git",
      notify   => Exec[build_pelican_lofar],
      user => "vagrant"
    }

    exec { "build_pelican_lofar":
           require => File["$builddir"],
           cwd => "$builddir",
           command => "cmake -DPELICAN_INCLUDE_DIR=$pelican::installdir/include -DPELICAN_INSTALL_DIR=$pelican::installdir -DLOFAR_DAL_INSTALL_DIR=$lofar_dal::installdir $srcdir/src && make",
           path => ["/bin", "/usr/bin"],
           user => "vagrant",
           timeout => 1200
         }

}
