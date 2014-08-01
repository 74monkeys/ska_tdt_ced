class pelican {
    include git::client
    include gcc
    include cmake
    include qt4
    include boost
    include cppunit

    $devdir = "/home/vagrant/development"
    $srcdir = "$devdir/pelican/src"
    $builddir = "$devdir/pelican/build"
    $installdir = "$devdir/pelican/install"
    vcsrepo { "$srcdir":
      ensure   => present,
      provider => git,
      source   => "https://github.com/pelican/pelican.git",
      notify   => Exec[build_pelican],
      user => "vagrant"
    }

    exec { "build_pelican":
           command => "mkdir -p $builddir && cd $builddir && cmake -DCMAKE_INSTALL_PREFIX=$installdir $srcdir/pelican && make install",
           path => ["/bin", "/usr/bin"],
           user => "vagrant",
           timeout => 1200
         }
}
