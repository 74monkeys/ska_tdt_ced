class lofar_dal {
    require cmake
    require devops
    require gcc
    require boost
    require hdf5

    exec { "get_lofar_dal":
            command => "$devops::exe checkout lofar_dal dev"
    }

    exec { "build_lofar_dal":
            command => "$devops::exe build lofar_dal dev development/lofar_dal/dev",
            timeout => 1200,
            require => Exec["get_lofar_dal"]
    }
}
