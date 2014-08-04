class lofar_dal {
    require cmake
    require devops
    require git::client
    require gcc
    require boost
    require hdf5

    $devdir = "$devops::devdir/lofar_dal"
    $srcdir = "$devdir/src"
    $builddir = "$devdir/build"
    $installdir = "$devdir/install"

    vcsrepo { "$srcdir":
      require => File["$devdir"],
      ensure   => present,
      provider => git,
      source   => "https://github.com/nextgen-astrodata/DAL.git",
      notify   => Exec[build_lofar_dal],
      user => "vagrant"
    }

    file { "$devdir":
      ensure => "directory",
      owner => "vagrant"
    }

    file { "$builddir":
      ensure => "directory",
      require => File["$devdir"],
      owner => "vagrant"
    }

    exec { "build_lofar_dal":
           require => File["$builddir"],
           cwd => "$builddir",
           command => "cmake -DCMAKE_INSTALL_PREFIX=$installdir -DPYTHON_BINDINGS=OFF $srcdir && make install",
           path => ["/bin", "/usr/bin"],
           user => "vagrant",
           timeout => 1200
         }
}
