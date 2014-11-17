class pssprotobuild {
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
        "pssprotobuild":
            ensure => present,
    }

    $devdir = "$devops::devdir/pssprotobuild"
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
      source   => "https://repo.oerc.ox.ac.uk/karsten.wiesner/pipeline-prototype.git",
      notify   => Exec[build_pipeline_prototype],
      user => "vagrant"
    }

    exec { "build_pipeline_prototype":
           require => File["$builddir"],
           cwd => "$builddir",
           command => "make",
           path => ["/bin", "/usr/bin"],
           user => "vagrant",
           timeout => 1200
         }

}
