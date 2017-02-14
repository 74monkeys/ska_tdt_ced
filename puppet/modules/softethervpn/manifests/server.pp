# Class: softethervpn
#
# This class installs the softethervpn server
#
# Sample Usage:
#  include softethervpn::server
#

class softethervpn::server (
    $servername = 'vpn.ska.physics.ox.ac.uk',
)
{
    include tarball
    require make
    require gcc

    $version = "v4.22-9634-beta"
    $version_date = "2016.11.27"
    $tarball = "softether-vpnserver-${version}-${version_date}-linux-x64-64bit.tar.gz"
    $tarball_url = "http://www.softether-download.com/files/softether/${version}-${version_date}-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/$tarball"

    $working_dir="/usr/local/src/softether"
    $tar_file="$working_dir/$tarball"

    tarball::download { 'fetch tarball':
        install_dir => "$working_dir",
        url => $tarball_url,
        tar_file => $tar_file,
        notify  => Exec["unpack softethervpn"]
    }

    exec { "unpack softethervpn":
        command     => "$tarball::tar_exe -xzf ${tar_file} && chown -R root:root ${working_dir}/vpnserver",
        cwd         => "${working_dir}",
        refreshonly => true,
        notify      => Exec["make softethervpn"]
    }

    exec { "make softethervpn":
        cwd         => "${working_dir}/vpnserver",
        command     => "/usr/bin/make i_read_and_agree_the_license_agreement",
        logoutput   => true,
        refreshonly => true,
        notify      => Exec["install softethervpn"]
    }

    exec { "install softethervpn":
        command     => "/bin/echo Installing softether vpn server",
        notify      => [File["vpncmd_link"]]
    }

    file { "vpncmd_link":
        path        => "/usr/local/bin/vpncmd",
        ensure      => present,
        content     => template('softethervpn/vpncmd_launcher.erb'),
        owner       => "root",
        group       => "root",
        mode        => 0775,
    }

    file { "vpnserver_service_startup_script":
        path        => "/etc/init.d/vpnserver",
        ensure      => present,
        content     => template('softethervpn/service_script.erb'),
        owner       => "root",
        group       => "root",
        mode        => 0775,
        before      => Service['vpnserver']
    }

    service { 'vpnserver':
        enable => true,
    }

}

