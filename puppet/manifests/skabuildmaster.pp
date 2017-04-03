group { "puppet":
    ensure => "present",
}

include system_update

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
    content => "Welcome to the ska tdt continous integration workflow server.\n"
}

class { 'ci_server': 
            servername => "skabuildmaster.physics,ox.ac.uk",
            configuration_repo => "git@repo.oerc.ox.ac.uk:christopher.williams/skabuildmaster_jenkins_config.git",
            require => Exec['system-update']
      }
