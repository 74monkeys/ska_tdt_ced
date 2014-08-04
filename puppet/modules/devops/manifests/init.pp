class devops {

    $devdir = "/home/vagrant/development"

    file { "$devdir":
      ensure => "directory",
      owner => "vagrant"
    }
}
