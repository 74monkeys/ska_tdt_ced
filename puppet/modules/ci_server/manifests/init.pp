class ci_server {


    $servername = 'skabuildmaster.physics.ox.ac.uk'
    $doc_root='/var/www/html'

    # -- configure apache reverse proxy
    class { 'apache':
        default_mods  => false,
        default_confd_files => false,
        docroot => $doc_root
    }

    include apache::mod::proxy_ajp
    include apache::mod::proxy_http
    include apache::mod::ssl

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

        custom_fragment => '
            ProxyPreserveHost On
            SSLProxyEngine On
            SSLProxyProtocol TLSv1
            AllowEncodedSlashes NoDecode

            # --- SSL Reverse Proxy to Jenkins ---
            <Location /jenkins>
                SSLRequireSSL
                ProxyPass http://127.0.0.1:8080/jenkins/
                ProxyPassReverse http://127.0.0.1:8080/jenkins/
            </Location>
            <Location /jenkins/credential-store>
                SSLRequireSSL
                ProxyPass https://127.0.0.1:8080/jenkins/credential-store/
                ProxyPassReverse https://127.0.0.1:8080/jenkins/credential-store/
            </Location>',

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
