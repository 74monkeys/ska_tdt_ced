class ci_server {

    require jenkins

    package { 'git':
    	    ensure => '1:1.9.1-1',
    }

    package { 'emacs':
    	    ensure => '45.0ubuntu1',
    }

    $doc_root='/var/www/docs'

    class { 'apache':
        default_mods  => false,
        default_confd_files => false,
        docroot => $doc_root
    }

    include apache::mod::proxy_ajp

    class { 'apache::mod::proxy':
        proxy_requests => 'Off'
    }

    $servername = 'skabuildmaster.physics.ox.ac.uk'

    # redirect all traffic to the ssl port
    apache::vhost { 'skabuildmaster non-ssl':
      servername      => $servername,
      port            => '80',
      docroot         => $doc_root,
      redirect_status => 'permanent',
      redirect_dest   => 'https://$servername'
    }

    apache::vhost { 'skabuildmaster':
        servername => $servername,
        docroot => $doc_root,
	port    => '443',
        proxy_pass => [
                        { 'path' => '/jenkins', 'url' => 'http://localhost:8080',
                          'reverse_urls' => [ 'http://localhost:8080' ]
                        }
                      ],
	ssl => true,
        ssl_cert => '/vagrant/ssl/ssl/certs/apache.crt',
        ssl_key  => '/vagrant/ssl/ssl/private/apache.key',
    }
}
