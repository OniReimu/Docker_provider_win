#!/bin/bash

echo "Hello world! Here is SQL!!!"
echo `ansible --version`

apt-get update
cd /vagrant
ansible-playbook playbook_SQL.yml

wget -qO - --save-headers http://docker_nginx:8080

echo "HTTP REQUEST DONE!!!"


