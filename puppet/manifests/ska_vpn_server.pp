group { "puppet":
    ensure => "present",
}

exec { 'system-update':
    command => '/usr/bin/sudo apt-get update'
}

Exec['system-update'] -> Package <| |>

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
    content => "Welcome to the ska vpn server"
}

class { 'softethervpn::server': 
        servername => "vpn.ska.physics,ox.ac.uk",
        require => Exec['system-update']
}
