class pssprotobuild (
    $jenkins_user = 'jenkins_slave',
    $jenkins_workspace = '/var/jenkins',
) {
    require devops
    require cmake
    require gcc
    require fortran
    require cppunit
    require fftw3
    require lapack
    require blas
    require lcov
    require boost

    Package { ensure => "installed" }

    user {
        $jenkins_user:
        ensure => present,
        home => "/home/$jenkins_user",
        managehome => 'true',
        comment => 'jenkins ci server use only',
    }

    ssh_authorized_key { 'jenkins_ssh':
        user => $jenkins_user,
        ensure => present,
        type => 'rsa',
        key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCpqH2Ikx52bW30DKo8VZH4fJBpiRF1Txn34TMHEpRZFWTAzh4YAlzLmuoSA+WavT/HuPSzX3PtJfg0YUqNpgyAU1Ey7UGRh7SJK6Gv3bEZW5YUmkFct9zA8qZpz2Cn0y+Eb1bFnx6EnFn3dFbBGrDMaxn4xXNcMfeKmYddpBfI3Utbxz/Zn41jyiK3YDL9PiIJ5a2BgyL9t0//uNJqMjI6M8Eh6yCDL8U1QduflDIpMHniUlFueoiounp4vOVLXcgSFDdS++BM/NFS3ePRUf3SZPljqjSmxzgoocRpqUfhrwp1GCpISNdTLDXiwPQxsz4JyTahelYPDyU/G+YBsPSj',
        require => User[$jenkins_user]
    }

    file { "$jenkins_workspace":
      ensure => "directory",
      owner => $jenkins_user
    }

    class { 'java': 
            distribution => 'jre'
         }

}
