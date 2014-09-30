class jenkins {

    exec { "wget_jenkins":
           command => "wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -",
	   path => "/usr/bin/",
         }

    exec { "sources_list_jenkins":
           command => "sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'",
           path => "/usr/bin/",
         }

    exec { "install_jenkins":
            command => "sudo apt-get update | sudo apt-get -y install jenkins",
            path => "/usr/bin/",
         }
}

#    Jenkins will be launched as a daemon up on start. See /etc/init.d/jenkins for more details.
#    The 'jenkins' user is created to run this service.
#    Log file will be placed in /var/log/jenkins/jenkins.log. Check this file if you are troubleshooting Jenkins.
#    /etc/default/jenkins will capture configuration parameters for the launch like e.g JENKINS_HOME
#    By default, Jenkins listen on port 8080. Access this port with your browser to start configuration.
