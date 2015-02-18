class ci_server (
    $servername = 'skabuildmaster.physics.ox.ac.uk',
    $doc_root = '/var/www/html',
    $configuration_repo = ""
    )
{
    include jenkins

    class { 'jenkins' : 
              configuration_repo => "$configuration_repo" }

    # -- configure apache reverse proxy
    class { 'apache':
        default_mods  => false,
        default_confd_files => false,
        docroot => $doc_root
    }

    include apache::mod::proxy_ajp
    include apache::mod::proxy_http
    include apache::mod::ssl
    include apache::mod::headers

    class { 'apache::mod::proxy':
        proxy_requests => 'Off',
    }


    apache::vhost { 'skabuildmaster':
        servername => $servername,
    	docroot => $doc_root,
        port    => '443',
	    ssl => true,
	    # ssl_certs_dir => '/vagrant/ssl/ssl/certs',
        # ssl_cert => '/vagrant/ssl/ssl/certs/apache.crt',
        ssl_cert => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
        ssl_key  => '/etc/ssl/private/ssl-cert-snakeoil.key',

        proxy_preserve_host => 'On',

        proxy_pass => [
            {
                'path' => '/jenkins', 
                'url' => 'http://127.0.0.1:8080/jenkins',
                'keywords' => ['nocanon'],
                'reverse_urls' => [ "https://$servername/jenkins" ]
            }
            ],

        custom_fragment => '
        AllowEncodedSlashes NoDecode

        # - SSL Reverse Proxy to Jenkins ---
        <Location /jenkins>
            RequestHeader set X-Forwarded-Proto "https"
            RequestHeader set X-Forwarded-Port "443"
        </Location>
            '
    }

    # redirect all traffic to the ssl port
    apache::vhost { 'skabuildmaster non-ssl':
        servername      => $servername,
        port            => '80',
        docroot         => $doc_root,
        redirect_status => 'permanent',
        redirect_dest   => 'https://$servername:443'
    }

}
