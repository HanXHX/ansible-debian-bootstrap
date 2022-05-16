# -*- mode: ruby -*-
# vi: set ft=ruby :
# vi: set tabstop=2 :
# vi: set shiftwidth=2 :

Vagrant.configure("2") do |config|

  vms_debian = [
    { :name => "debian-stretch",           :box => "debian/stretch64", :vars => { dbs_use_systemd: true  } },
    { :name => "debian-stretch-sysvinit",  :box => "debian/stretch64", :vars => { dbs_use_systemd: false } },
    { :name => "debian-buster",            :box => "debian/buster64",  :vars => { dbs_use_systemd: true  } },
    { :name => "debian-buster-sysvinit",   :box => "debian/buster64",  :vars => { dbs_use_systemd: false } },
    { :name => "debian-bullseye",          :box => "debian/bullseye64",  :vars => { dbs_use_systemd: true  } },
    { :name => "debian-bullseye-sysvinit", :box => "debian/bullseye64",  :vars => { dbs_use_systemd: false } },
    { :name => "devuan-ascii",             :box => "https://files.devuan.org/devuan_ascii/virtual/devuan_ascii_2.0.0_amd64_vagrant.box" },
    { :name => "raspbian-stretch",         :box => "gvfoster/raspbian",:vars => { dbs_use_systemd: true } },
    { :name => "ubuntu-bionic",            :box => "ubuntu/bionic64",  :vars => { dbs_use_systemd: true } },
    { :name => "ubuntu-focal",             :box => "ubuntu/focal64",  :vars => { dbs_use_systemd: true } },
    { :name => "ubuntu-jammy",             :box => "ubuntu/jammy64",  :vars => { dbs_use_systemd: true } },
  ]

  conts = [
    { :name => "docker-debian-stretch",  :docker => "hanxhx/vagrant-ansible:debian9", :vars => {} },
    { :name => "docker-debian-buster",   :docker => "hanxhx/vagrant-ansible:debian10", :vars => {} },
    { :name => "docker-debian-bullseye", :docker => "hanxhx/vagrant-ansible:debian11", :vars => {} },
    { :name => "docker-ubuntu-bionic",   :docker => "hanxhx/vagrant-ansible:ubuntu18.04", :vars => {} },
    { :name => "docker-ubuntu-focal",    :docker => "hanxhx/vagrant-ansible:ubuntu20.04", :vars => {} },
    { :name => "docker-ubuntu-jammy",    :docker => "hanxhx/vagrant-ansible:ubuntu22.04", :vars => {} }
  ]

  config.vm.network "private_network", type: "dhcp"

  conts.each do |opts|
    config.vm.define opts[:name] do |m|
      m.vm.provider "docker" do |d|
        d.image = opts[:docker]
        d.remains_running = true
        d.has_ssh = true
      end

      m.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/test.yml"
        ansible.verbose = 'vv'
        ansible.become = true
        ansible.extra_vars = opts[:vars]
        ansible.raw_arguments = ["-D"]
        ansible.compatibility_mode = "2.0"
      end
    end
  end

  vms_debian.each do |opts|
    config.vm.define opts[:name] do |m|
      if opts[:name].include? "devuan" or opts[:name].include? "ubuntu"
        m.vm.provision "shell", inline: "apt-get update -qq && apt-get -y install python"
      end

      if opts[:name].include? "devuan"
        m.vm.box_url = opts[:box]
        m.vm.box = opts[:name]
      else
        m.vm.box = opts[:box]
      end

      m.vm.provider "virtualbox" do |v|
        v.cpus = 1
        v.memory = 512
      end
      m.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/test.yml"
        ansible.verbose = 'vv'
        ansible.become = true
        ansible.extra_vars = opts[:vars]
        ansible.raw_arguments = ["-D"]
        ansible.compatibility_mode = "2.0"
      end
    end
  end
end
