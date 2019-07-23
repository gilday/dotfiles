Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provision "shell", inline: "yum install -y epel-release && yum install -y ansible git"
end
