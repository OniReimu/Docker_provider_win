# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

DOCKER_HOST_NAME = "dockerhost" 
 
DOCKER_HOST_VAGRANTFILE = "./DockerHostVagrantfile" 

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.synced_folder ".", "/vagrant"

###### Nginx ######
  config.vm.define "docker_nginx" do |v|
    v.vm.provider "docker" do |d|
      d.name = "docker_nginx"
      d.cmd = ["/sbin/my_init", "--enable-insecure-key"]
      d.remains_running = true
      d.has_ssh = true
      d.build_dir = "."
      d.build_args = ["-t=docker_nginx"]
#      d.image = "phusion/baseimage"

      ### Mapping the port of Docker container onto the Host VM
#      d.volumes = ["/vagrant/:/vagrant"]
      d.ports = ["8080:8080"]
      d.vagrant_machine = "#{DOCKER_HOST_NAME}"
      d.vagrant_vagrantfile = "#{DOCKER_HOST_VAGRANTFILE}"

    end

    v.ssh.port = 22
    v.ssh.username = "root"
    v.ssh.private_key_path = "insecure_key"

    v.vm.provision :shell, path: "installNginx.sh"
    v.vm.provision "shell", inline: "echo 'Nginx!!!'"
  end

###### SQL ######
  config.vm.define "docker_sql" do |v|
    v.vm.provider "docker" do |d|
      d.name = "docker_sql"
      d.cmd = ["/sbin/my_init", "--enable-insecure-key"]
      d.remains_running = false
      d.has_ssh = true
      d.build_dir = "."
      d.build_args = ["-t=docker_sql"]
#      d.image = "phusion/baseimage"

      ### Mapping the port of Docker container onto the Host VM
#      d.volumes = ["/vagrant/:/vagrant"]
      d.ports = ["3300:3300"]
      d.link("docker_nginx:docker_nginx")
      d.vagrant_machine = "#{DOCKER_HOST_NAME}"
      d.vagrant_vagrantfile = "#{DOCKER_HOST_VAGRANTFILE}"

    end

    v.ssh.port = 22
    v.ssh.username = "root"
    v.ssh.private_key_path = "insecure_key"

    v.vm.provision :shell, path: "installSQL.sh"
    v.vm.provision "shell", inline: "echo 'SQL!!!'"
  end

end