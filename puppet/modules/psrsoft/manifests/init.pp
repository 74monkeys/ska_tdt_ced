class psrsoft {
    require gcc 
    require fortran
    require python
    include tarball

    Package { ensure => "installed" }

    $tar_file = "psrsoft.tar.gz"
    $url = "http://www.atnf.csiro.au/people/Michael.Keith/psrsoft/$tar_file"
    
    tarball::download { 
        'fetch tarball':
        install_dir => "/opt",
        url => $url,
        tar_file => $tar_file,
        notify => File["/opt/psrsoft/config/profile"],
    }

    group {
        "psrsoft":
            ensure => present,
    }
   
    file { "/opt/psrsoft/config/profile":
          group => "psrsoft",
          mode => 0444,
          source => "puppet:///modules/psrsoft/profile",
          require => Group["psrsoft"]
    }

}
