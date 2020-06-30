# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "generic/ubuntu1804"
  config.vm.box_check_update = true
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "kvm"
    # libvirt.host = "localhost"
    libvirt.connect_via_ssh = false
    libvirt.storage_pool_name = "default"
    #libvirt.default_prefix = ''
  end

#   config.ssh.forward_agent = true
  config.vm.define :default do |machine|
    machine.vm.synced_folder "./", "/home/vagrant/workspace", type: "nfs", nfs_version: "4", nfs_udp: false

    machine.vm.provider :libvirt do |libvirt|
      libvirt.cpus = 4
      libvirt.memory = "8192"
      libvirt.graphics_type = "none"
    end
  end
end
