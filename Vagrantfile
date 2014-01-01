# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "Berksfile.local"

  config.omnibus.chef_version = :latest 
  config.vm.box = "CentOS-6.5-x86_64"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box"

  config.vm.network :private_network, ip: "192.168.33.150"

  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize [
      "modifyvm", :id, 
      "--memory", "1024"
    ]
  end

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      "mysql" => {
        "server_debian_password" => "test",
        "server_repl_password" => "test",
        "server_root_password" => "test"
      },
      "growthforecast" => {
        "system" => {
          "perlbrew_ver" => "perl-5.18.0"
        },
        "user" => {
          "name" => "growthf"
        },
        "system" => {
          "data_dir" => "/home/growthf/grf-data"
        },
        "database" => {
          "db_name" => "growthforecast",
          "user_name" => "growthforecast",
          "password" => "",
          "host" => "localhost"
        }
      },
      "perlbrew" => {
        "perlbrew_root" => "/opt/perlbrew",
        "perls" => [
          "perl-5.18.0"
        ],
        "install_options" => "-j 4",
        "cpanm_options" => "",
        "self_upgrade" => true
      }
    }

    chef.add_recipe "disable-iptables"
    chef.add_recipe "growthforecast::default"

  end

end
