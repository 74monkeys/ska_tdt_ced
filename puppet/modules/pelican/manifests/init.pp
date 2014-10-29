class pelican {
    require devops
    require gcc
    require cmake
    require qt4
    require boost
    require cppunit

    exec { "get_pelican":
            command => "$devops::exe checkout pelican dev"
    }

    exec { "build_pelican":
            command => "$devops::exe build pelican dev development/pelican/dev",
            timeout => 1200,
            require => Exec["get_pelican"]
    }
}
