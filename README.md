# Vagrant with docker provider on Win 7

Notice that virtualbox version should be < 4.3.13

           
# Steps to setup:
  1. Create a new file as your working directory for vagrant. Make sure you have all priviledges accessing to this directory.
  2. Clone all the files in this directory.
  3. CMD
  4. Run:
       - $ vagrant up --provision --no-parallel
  5. You will see "Thank you for using nginx.", meaning it has been successfully setup.
  6. Check the status of docker containers you just created:
       - $ vagrant global-status
  7. Use third-party tool such as Putty to SSH into Host VM
    - Look up the docker container:
       - $ docker ps 
    - Enter the specific docker container:
    
       - $ docker exec -it (Container ID) /bin/bash
       
  8. Still use Putty to SSH into container because the port forwarding has been introduced. 


  
Note that SQL is not actually installed since I have not decided which SQL I will use. Thus it is just a normal sript validating the connection between two containers. And Vagrant itself should have supported the ansible provisioning directly without shell provisioning. However, the latest version of ansible contains some bugs that cause Vagrantfile cannot check the existance of ansible installed in containers.
