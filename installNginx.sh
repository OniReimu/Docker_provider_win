#!/bin/bash

echo "Hello world! Here is Nginx!!!"
echo `ansible --version`

cd /vagrant
ansible-playbook playbook.yml
mkdir /etc/nginx/html
git clone https://github.com/OniReimu/Docker_provider_win.git
cp /vagrant/Dockertest/default /etc/nginx/sites-available/default
/usr/sbin/nginx