# Vagrant with docker provider on Win 7
Vagrant version >=1.6, Docker-compose plugin can be replaced with Vagrantfile itself no matter in Linux, Windows or Mac OS. Docker-compose is commonly used together with docker provisioner but not provider. I will explain this thinking in the documentation after I validating its correctness.

# Environment:
  - Windows 7 Premium
  - VirtualBox-4.3.12-93733-Win
  - Vagrant-1.8.6
  - Host VM base box (Note that 900+MB too heavy to be uploaded, thus you cannot preperly run this project without this base box)
      - Ubuntu-14.04 LTS from https://atlas.hashicorp.com/phusion/boxes/ubuntu-14.04-amd64
      - With customizations
           - Customized docker image with the original version from https://github.com/phusion/baseimage-docker
               - $ apt-get install inetutils-ping
               - $ apt-get install net-tools
               - $ apt-get install python
               - $ apt-get install python-pip
               - $ apt-get install ansible
               - $ apt-get install sudo
               - $ apt-get install rsync
               - $ apt-get install git
               - $ vim /etc/ssh/ssh_config
                   - StrictHostKeyChecking ask  --->  StrictHostKeyChecking no
               - $ vim /etc/ssh/sshd_config
                   - IgnoreUserKnownHosts no  --->  IgnoreUserKnownHosts yes
           - Docker-1.9.1
           - Git
           
# Steps to setup:
  1. Create a new file as your working directory for vagrant. Make sure you have all priviledges accessing to this directory.
  2. Clone all the files in this directory.
  3. CMD
  4. When you have the base box：
       - $ vagrant add box ubuntu_phusion_docker2 ubuntu-docker2.box
  5. Check if the base box has been added successfully:
       - $ vagrant box list
  6. Run:
       - $ vagrant up --provision --no-parallel
  7. You will see "Thank you for using nginx.", meaning it has been successfully setup.
  8. Check the status of docker containers you just created:
       - $ vagrant global-status
  9. SSH into the Host VM using third-party tool such as Putty, SecureCRT or Xshell. IPAddress: 192.168.58.31:22.
    - Look up the docker container:
       - $ docker ps 
    - Enter the specific docker container:
       - $ docker exec -it <Container ID> /bin/bash

# Files:
  - Vagrantfile 
    - Used to create the docker containers as a cluster instead of using docker-compose plugin.
  - DockerHostVagrantfile
    - Used to create the Host VM of docker containers when running in Windows or Mac OS.
  - Dockerfile
    - Used to commit the customized docker images.    
  - Insecure_key
    - Private key of docker image.
  - su2root.expect
    - Ask for root priviledge.
  - installNginx.sh
    - Shell provisioning for setting up Nginx. 
  - installSQL.sh
    - Shell provisioning for setting up SQL.
  - playbook.yml
    - Ansible script for installing Nginx.
  - playbook_SQL.yml
    - Ansible script for installing SQL .

Note that SQL is not actually installed since I have not decided which SQL I will use. Thus it is just a normal sript validating the connection between two containers. And Vagrant itself should have supported the ansible provisioning directly without shell provisioning. However, the latest version of ansible contains some bugs that cause Vagrantfile cannot check the existance of ansible installed in containers.
