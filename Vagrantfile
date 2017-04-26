# -*- mode: ruby -*-
# vi: set ft=ruby :
# vi: set tabstop=2 :
# vi: set shiftwidth=2 :

Vagrant.configure("2") do |config|

  vms = [
    [ "debian-wheezy", "debian/wheezy64" ],
    [ "debian-jessie", "debian/jessie64" ],
    [ "devuan-jessie", "https://files.devuan.org/devuan_jessie_rc/virtual/devuan_jessie_1.0.0-RC_amd64_vagrant.box" ]
  ]

  config.vm.provider "virtualbox" do |v|
    v.cpus = 1
    v.memory = 256
  end

  vms.each do |vm|
    config.vm.define vm[0] do |m|
      m.vm.box = vm[1]
      m.vm.network "private_network", type: "dhcp"

      if vm[0] == "devuan-jessie"
          config.ssh.username = "root"
          config.ssh.password = "toor"
          config.vm.guest = :debian
          config.vm.synced_folder ".", "/vagrant", disabled: true
      end

      m.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/test.yml"
        ansible.verbose = 'vv'
        ansible.sudo = true
      end
    end
  end
end
