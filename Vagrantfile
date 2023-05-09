# -*- mode: ruby -*-
# vi: set ft=ruby :

masters = {
  "k8s-m01" => { :ip => "192.168.56.10", :cpus => 2, :mem => 2048 },
}

workers = {
  "k8s-w01" => { :ip => "192.168.56.20", :cpus => 1, :mem => 1024 },
  "k8s-w02" => { :ip => "192.168.56.21", :cpus => 1, :mem => 1024 },
}
 
Vagrant.configure(2) do |config|

  # create workers
  workers.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |worker|
      worker.vm.provider :virtualbox do |vb, override|
        config.vm.box = "generic/ubuntu2204"
        override.vm.network :private_network, ip: "#{info[:ip]}"
        override.vm.hostname = hostname
        vb.name = hostname
        vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpus], "--hwvirtex", "on"]
      end
    end
  end

  # create masters
  masters.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |master|
      master.vm.provider :virtualbox do |vb, override|
        config.vm.box = "generic/ubuntu2204"
        override.vm.network :private_network, ip: "#{info[:ip]}"
        override.vm.hostname = hostname
        vb.name = hostname
        vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpus], "--hwvirtex", "on"]
      end
      master.vm.provision "file", run: "always", source: "./provisioning", destination: "/home/vagrant/ansible"
      master.vm.provision "shell", run: "always", path: "./provisioning/master.sh"
    end
  end
end
