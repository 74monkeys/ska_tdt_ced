define tarball::download($url, $tar_file, $install_dir, $work_dir=$tarball::work_dir) {

    include tarball

    package { "wget": ensure => "installed" }

    if $tar_file =~ /^\/.*/ {
        $pkg_file = "$tar_file"
    }
    else {
        $pkg_file = "$work_dir/$tar_file"
    }

    file { "$install_dir":
        ensure => directory,
    }

    exec {
      "Retrieve $url":
          command => "/usr/bin/wget -O $pkg_file $url",
          creates => "$pkg_file",
          timeout => 3600,
          logoutput => true,
          require => Package['wget'],
          notify => Exec["unpack $pkg_file"]
    }
  
    exec {
      "unpack $pkg_file":
        command => "/bin/tar xzvf $pkg_file -C $install_dir/",
        require => File["$install_dir"],
        user => root,
    }
}


