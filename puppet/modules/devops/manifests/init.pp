class devops {
    require git::client

    $devdir = "/home/vagrant/development"

    file { "$devdir":
      ensure => "directory",
      owner => "vagrant"
    }
}
