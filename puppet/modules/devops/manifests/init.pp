class paf_dependencies {
    require cpan

    cpan { "IO::Tee":
        ensure  => present,
    }

    cpan { "File::Sync":
        ensure  => present,
    }

    cpan { "LWP::UserAgent":
        ensure  => present,
    }

    cpan { "Mozilla::CA":
        ensure  => present,
    }
}

class devops {
    require perl
    require paf_dependencies

    require git::client

    $devops_system_dir = "/usr/local/share/devops"
    $devdir = "$devops_system_dir/checkouts"
    $srcdir = "$devops_system_dir/repository"
    $exe = "/usr/local/bin/devops"

    group { "devops":
      ensure => present,
    }

    file { "$devops_system_dir":
      ensure => "directory",
      group => "devops"
    }

    vcsrepo { "$srcdir":
      require  => File["$devops_system_dir"],
      ensure   => present,
      provider => git,
      source   => "https://github.com/chrisjwilliams/devops.git",
      group => "devops",
      notify   => Exec[update_submodules]
    }

    vcsrepo { "$devdir":
      require  => File["$devops_system_dir"],
      ensure   => present,
      provider => git,
      source   => "https://github.com/chrisjwilliams/devops_pulsar.git",
      group => "devops",
      notify => Exec["configure_devops"]
    }

    exec { "init_repository":
           require  => Vcsrepo["$srcdir"],
           cwd => "$srcdir",
           command => "$git::client::exe submodule init",
         }

    exec { "update_submodules":
           require => Exec["init_repository"],
           cwd => "$srcdir",
           command => "$git::client::exe submodule update",
         }

    exec { "install_devops":
           require => [ Exec["update_submodules"], Class["paf_dependencies"] ],
           cwd => "$srcdir/Installation",
           command => "$perl::exe $srcdir/Installation/install_devops",
         }

    exec { "configure_devops":
           require => Exec["install_devops"],
           command => "$exe config -location $devops_system_dir add $devdir",
         }
}


