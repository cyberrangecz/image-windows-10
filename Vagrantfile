# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "mybox"
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "4096"
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.verbose = true
    ansible.extra_vars = {
        "ansible_winrm_server_cert_validation" => "ignore",
        "ansible_winrm_transport" => "basic",
        "ansible_winrm_scheme" => "http"
    }
  end
end
