class artemis {
    include tarball
    include git::client
    include gcc
    include fortran
    include pelican
    include cmake
    include cppunit
    include fftw3
    include lapack
    include blas

    Package { ensure => "installed" }

    group {
        "artemis":
            ensure => present,
    }

    $devdir = "/home/vagrant/development"
    $srcdir = "$devdir/pelican-lofar/src"
    $builddir = "$devdir/pelican-lofar/build"
    vcsrepo { "$srcdir":
      ensure   => present,
      provider => git,
      source   => "https://github.com/pelican/pelican-lofar.git",
      notify   => Exec[build_pelican_lofar],
      user => "vagrant"
    }

    exec { "build_pelican_lofar":
           command => "mkdir -p $builddir && cd $builddir && cmake -DPELICAN_INCLUDE_DIR=$pelican::installdir/include -DPELICAN_INSTALL_DIR=$pelican::installdir $srcdir/src && make",
           path => ["/bin", "/usr/bin"],
           user => "vagrant",
           timeout => 1200
         }

}
