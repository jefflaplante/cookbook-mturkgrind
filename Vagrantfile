# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

CHEF_ORG = "mturkgrind"
CHEF_ENV = "dev"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Box Image
  config.vm.box = "chef/ubuntu-12.04"

  # Install particular version of chef
  #config.omnibus.chef_version = "11.12.8"

  # Cache packages outside of VM to speed up building new VMs.
  # config.cache.auto_detect = true
   
  # Enable Berkshelf integration
  config.berkshelf.enabled = false
  
  # Enable tty for ssh
  # config.ssh.pty = true

  # Skeleton VM Setup
  config.vm.define "mturkgrind", primary: true do |skel|
    skel.vm.hostname = "mtgdev"
    # skel.vm.network :forwarded_port, guest: 80, host: 8080
    # skel.vm.network "public_network", bridge: 'en5: USB Ethernet'
    skel.vm.network "public_network", bridge: 'en0: (Wi-fi)'
    skel.ssh.forward_agent = true

    skel.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      # Add these two VM customizations to speed up cookbook download on vagrant VM
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    # skel.vm.provision :shell do |s|
    #   s.inline = "sudo apt-get install curl -y; curl -L https://www.opscode.com/chef/install.sh | sudo bash"
    # end
 
    # Define node specific chef attributes
    skel.vm.provision :chef_client do |chef|
      chef.chef_server_url = "https://api.opscode.com/organizations/#{CHEF_ORG}"
      chef.validation_client_name = "#{CHEF_ORG}-validator"
      chef.validation_key_path = "~/.chef/validators/#{CHEF_ORG}-validator.pem"
      chef.environment = CHEF_ENV
      chef.delete_node = true 
      chef.delete_client = true 

      #chef.node_name = 'override-hostname' # Override the node name which defaults to hostname
      #chef.add_recipe 'test'               # Add recipes with multiple lines like this
      #chef.add_role 'test'                 # Add roles with multiple lines like this

      chef.run_list = [
      ]

    end
  end
end
