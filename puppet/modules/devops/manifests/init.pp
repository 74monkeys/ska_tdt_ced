class devops {
    require git

    $devdir = "/home/vagrant/development"

    file { "$devdir":
      ensure => "directory",
      owner => "vagrant"
    }
}
