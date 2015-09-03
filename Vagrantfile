# -*- mode: ruby -*-
# vi: set ft=ruby :

CLOUD_CONFIG_PATH = File.join(File.dirname(__FILE__), "user-data")

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.box = "trustytahr"

  config.vm.define "relk" do |relk|
    relk.vm.network "private_network", ip: "192.168.33.100"
    relk.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.name = "relk.example"
    end
    # relk.vm.provision :shell, :inline => "apt-get update"
    # relk.vm.provision "docker", version: "1.7.1", images: [
    #                               "rabbitmq:3.5.4-management",
    #                               "elasticsearch:1.7.1",
    #                               "logstash:1.5.4-1",
    #                               "kibana:4.1.1"
    #                           ]

    files = [
        "docker-ssl.sh",
        "docker-rabbitmq.sh",
        "docker-rabbitmq-configure.sh",
        "docker-elasticsearch.sh",
        "docker-logstash.sh",
        "docker-logstash-configure.sh",
        "docker-kibana.sh"
    ]

    files.each do |file|
      relk.vm.provision :file,
                        :source => File.join(File.dirname(__FILE__), file),
                        :destination => File.join("/home/vagrant", file)
    end

    relk.vm.provision :shell, :inline => "mkdir -p /opt/elasticsearch/data"
    relk.vm.provision :shell, :inline => "/home/vagrant/docker-ssl.sh"

    relk.vm.provision :shell, :inline => "mkdir -p /etc/pki/tls/certs/logstash-forwarder/"
    relk.vm.provision :shell, :inline => "mkdir -p /etc/pki/tls/private/logstash-forwarder/"

    relk.vm.provision :shell, :inline => "mv lumberjack.crt /etc/pki/tls/certs/logstash-forwarder/"
    relk.vm.provision :shell, :inline => "mv lumberjack.key /etc/pki/tls/private/logstash-forwarder/"

    relk.vm.provision :shell, :inline => "mkdir -p /home/vagrant/logstash/conf.d", :privileged => false

    files = [
        "100_input_lumberjack.conf",
        "100_input_rabbitmq.conf",
        "400_output_server.conf"
    ]

    files.each do |file|
      relk.vm.provision :file,
                        :source => File.join(File.dirname(__FILE__), "logstash/conf.d", file),
                        :destination => File.join("/home/vagrant/logstash/conf.d", file)
    end

  end

  config.vm.define "app01" do |app01|
    app01.vm.network "private_network", ip: "192.168.33.101"
    app01.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.name = "app01.example.com"
    end
    app01.vm.provision :shell, :inline => "apt-get update"
    app01.vm.provision "docker", version: "1.7.1", images: ["rudijs/docker-logstash-forwarder"]
  end

end
