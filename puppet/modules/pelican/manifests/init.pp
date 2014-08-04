class pelican {
    require devops
    require git::client
    require gcc
    require cmake
    require qt4
    require boost
    require cppunit

    $devdir = "$devops::devdir/pelican"
    $srcdir = "$devdir/src"
    $builddir = "$devdir/build"
    $installdir = "$devdir/install"

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
      source   => "https://github.com/pelican/pelican.git",
      notify   => Exec[build_pelican],
      user => "vagrant"
    }

    exec { "build_pelican":
           cwd => "$builddir",
           command => "cmake -DCMAKE_INSTALL_PREFIX=$installdir $srcdir/pelican && make install",
           path => ["/bin", "/usr/bin"],
           user => "vagrant",
           timeout => 1200
         }
}
