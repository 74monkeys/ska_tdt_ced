define tarball::unpack($pkg_tgz, $install_dir) {

    include tarball

    $work_dir = "$tarball::work_dir"

    # create the install directory
    file { "$install_dir":
        ensure  => directory,
    }

    # untar the tarball at the desired location
    exec { "untar $work_dir/$pkg_tgz":
        command => "/bin/tar xzvf $work_dir/pkg_tgz -C $install_dir/",
        refreshonly => true,
        require => File["$work_dir/$pkg_tgz", "$install_dir"],
    }
}


