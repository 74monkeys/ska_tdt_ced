class ci_server {

    require jenkins

    #package { 'git':
    #	    ensure => '1:1.9.1-1',
    #}

    #package { 'emacs':
    #	    ensure => '45.0ubuntu1',
    #}

    $doc_root='/var/www/html'

    class { 'apache':
        default_vhost => false, # would otherwise create a vhost on :80 that would conflict w/ ssl vhost on :80
        default_mods  => false,
        default_confd_files => false,
        docroot => $doc_root
    }

    # Apache JServ Protocol for load balancing cluster
    #include apache::mod::proxy_ajp

    class { 'apache::mod::proxy':
        proxy_requests => 'Off'
    }

    $servername = 'skabuildmaster.physics.ox.ac.uk'

    # SSL Proxy to Jenkins 
    # (port 80 is the only port that is open for the inet on skabuildmaster)
    apache::vhost { 'skabuildmaster ssl jenkins':
        servername => $servername,
    	docroot => $doc_root,
	port    => '80',
        proxy_pass => [
                        { 'path' => '/jenkins', 'url' => 'http://localhost:8080',
                          'reverse_urls' => [ 'http://localhost:8080' ]
                        }
                      ],
	ssl => true,
	ssl_certs_dir => '/vagrant/ssl/ssl/certs',
        ssl_cert => '/vagrant/ssl/ssl/certs/apache.crt',
        ssl_key  => '/vagrant/ssl/ssl/private/apache.key',
    }

    # redirect all traffic to the ssl port - not working!
    # On 'skabuildmaster ssl jenkins' set port to 443, docroot 
    # should not point to same docroot like 'skabuildmaster non-ssl' ?!
    #apache::vhost { 'skabuildmaster non-ssl':
    #  servername      => $servername,
    #  port            => '80',
    #  docroot         => $doc_root,
    #  redirect_status => 'permanent',
    #  redirect_dest   => 'https://localhost:443/jenkins'
    #}

}
