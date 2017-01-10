# Install lcov v1.13
class lcov113 {
  require git::client
  require make

  $srcfiles = '/tmp/lcov'

  vcsrepo { $srcfiles:
    ensure   => present,
    provider => git,
    source   => 'https://github.com/linux-test-project/lcov.git',
    revision => 'v1.13',
  }

  exec { "Install_lcov_1_13":
         require  => Vcsrepo["$srcfiles"],
         cwd => "$srcfiles",
         command => "/usr/bin/make install",
       }

}
