# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  boxes = [
      {
          :box => "ubuntu/trusty64",
          :prefix => "ubuntu",
          :boxURL => "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
      }
  ]

  boxes.each do |box|

    #config.vm.provision :puppet do |puppet|
    #   puppet.manifests_path = "puppet/manifests"
    #   puppet.module_path = "puppet/modules"
    #end

    # All Vagrant configuration is done here. The most common configuration
    # options are documented and commented below. For a complete reference,
    # please see the online documentation at vagrantup.com.
    config.vm.define box[:prefix] + "-" +  "artemis", autostart: false do |artemis|
      artemis.vm.box = box[:box]
      if box.key?(:boxURL)
        artemis.vm.box_url = box[:boxURL]
      end
      artemis.vm.hostname = box[:prefix] + "-" + "artemis"
      artemis.vm.provision :puppet do |puppet|
           puppet.manifests_path = "puppet/manifests"
           puppet.module_path = "puppet/modules"
           puppet.manifest_file  = "artemis_dev_box.pp"
      end
    end

    config.vm.define box[:prefix] + "-" +  "pulsar_analysis", autostart: false do |pulsar_analysis|
      pulsar_analysis.vm.box = box[:box]
      if box.key?(:boxURL)
        pulsar_analysis.vm.box_url = box[:boxURL]
      end
      pulsar_analysis.vm.hostname = box[:prefix] + "-" + "pulsar"
      pulsar_analysis.vm.provision :puppet do |puppet|
           puppet.manifests_path = "puppet/manifests"
           puppet.module_path = "puppet/modules"
           puppet.manifest_file  = "pulsar_analysis_box.pp"
      end
    end


    # -- throwaway ubunutu box for running puppet unit tests
    config.vm.define box[:prefix] + "-" +  "ubuntu_test", autostart: false do |ubuntu_test|
      ubuntu_test.vm.box = box[:box]
      if box.key?(:boxURL)
        ubuntu_test.vm.box_url = box[:boxURL]
      end
      ubuntu_test.vm.hostname = box[:prefix] + "-" +  "ubuntu-test"
      ubuntu_test.vm.provision :puppet do |puppet|
           puppet.manifests_path = "puppet/manifests"
           puppet.module_path = "puppet/modules"
           puppet.manifest_file  = "ubuntu_default.pp"
      end
    end

    config.vm.define box[:prefix] + "-" +  "pssprotobuild", autostart: false do |pssprotobuild|
      pssprotobuild.vm.box = box[:box]
      if box.key?(:boxURL)
        pssprotobuild.vm.box_url = box[:boxURL]
      end
      pssprotobuild.vm.hostname = box[:prefix] + "-" +  "pssprotobuild"
      pssprotobuild.vm.provision :puppet do |puppet|
           puppet.manifests_path = "puppet/manifests"
           puppet.module_path = "puppet/modules"
           puppet.manifest_file  = "pss_proto_build.pp"
      end
    end


    # Every Vagrant virtual environment requires a box to build off of.
    #config.vm.box = "ubuntu/trusty64"


    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    # config.vm.box_url = "http://domain.com/path/to/above.box"
    #config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"
    #config.vm.box_url = " http://files.vagrantup.com/lucid32.box"
    #config.vm.box_url = "https://vagrantcloud.com/ubuntu/trusty64.box"
    #config.vm.box_url = "https://vagrantcloud.com/ubuntu/trusty64/version/1/provider/virtualbox.box"

    #config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  end

  # For the next set of definitions add another OS
  boxes << {
    :box => "centos/7",
    :prefix => "centos",
    :preinstall => <<ENDSCRIPT
      rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
      yes | yum -y install puppet
ENDSCRIPT
  }
  #:boxURL => "http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1601_01.VirtualBox.box"
  #:box => "puppetlabs/centos-7.0-64-puppet",
  #:box => "centos/7",

  boxes.each do |box|

    config.vm.define box[:prefix] + "-" +  "ciserver", autostart: false do |ciserver|
      ciserver.vm.box = box[:box]
      if box.key?(:boxURL)
        ciserver.vm.box_url = box[:boxURL]
      end
      #ciserver.vm.synced_folder ".", "/vagrant", type: "virtualbox"
      ciserver.vm.hostname = box[:prefix] + "-" + "ciserver"
      ciserver.vm.network "forwarded_port", guest: 80, host: 8098
      ciserver.vm.network "forwarded_port", guest: 443, host: 8099
      if box.key?(:preinstall)
        config.vm.provision "shell", inline: box[:preinstall]
      end
      ciserver.vm.provision :puppet do |puppet|
           puppet.manifests_path = "puppet/manifests"
           puppet.module_path = "puppet/modules"
           puppet.manifest_file  = "ci_server_box.pp"
           puppet.facter = {
              'fqdn' => 'skabuildmaster'
           }
      end
    end

  end
  config.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # Create a forwarded port mapping which allows access jenkins via host port 1234
  # config.vm.network :forwarded_port, guest: 8080, host: 1234
  # ---> moved to ci-server section please test!

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "init.pp"
  # end
    # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
