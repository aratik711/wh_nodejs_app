# wh_nodejs_app

## Description: 
* The wh_nodejs_app project is used to deploy a simple nodejs appication on an AWS instance. 
* The nodejs application will display the current timestamp of the AWS instance.
* The nodejs app will be routed via nginx.
* This project will provision the instance via terraform and deploy nodejs and nginx via ansible.
* The application will be available on the public ip of the AWS instance on port 80. The public IP will be provided in the output of terraform command.

## Presumptions:
1. Nginx and nodejs servers are placed in the same machine.
2. Nodejs application runs on 8090 port
3. Nginx default port is 8080
4. Nodejs app is routed via nginx at port 80
5. The application will be deployed on Ubuntu 16.04 machine.


## Prerequisites:
1. Install Python >=2.7 
2. Terraform and ansible installed on Centos machine. Both configured on same machine.
3. Terraform version v0.9.2 (latest). Installation steps: https://www.terraform.io/intro/getting-started/install.html
4. Ansible version  2.2.1.0 (latest). Installation steps: http://docs.ansible.com/ansible/intro_installation.html
5. Clone this repository: `git clone https://github.com/aratik711/wh_nodejs_app.git`
6. The ssh key should be present in the ~/.ssh directory of the user you will be executing the terraform and ansible. If not then generate it using  
`ssh-keygen -t rsa`
7. The user with which you will be executing the terraform and ansible commands should have sudo rights and must have passwordless sudo access. 
    1. To enable sudo. Login with root user. Edit /etc/sudoers and add the line:  
    `username ALL=(ALL)       ALL`  
    Replace the username with your username. 
    2. To enable passwordless sudo. Login with root user. Edit /etc/sudoers and add the line:  
    `username ALL=(ALL)       NOPASSWD: ALL`  
    Replace the username with your username.   
    Save and exit. You will now have passwordless sudo rights.
8. Execute the following commands:
    * `cd wh_nodejs_app`
    * `ssh-keygen -t rsa -f wh_terraform/setup/dta/wh_nodejs_key`
    * `openssl rsa -in wh_terraform/setup/dta/wh_nodejs_key -outform pem > wh_terraform/setup/dta/wh_nodejs_key.pem`
    * `export AWS_ACCESS_KEY_ID="Your AWS access key"`
    * `export AWS_SECRET_ACCESS_KEY="Your AWS secret key"`

## Variables to edit:
1. Edit the wh_nodejs_app/wh_terraform/variables.tf
    * Set the `tf_home` variable to the directory where the wh_terraform directory is cloned.<b>(required)</b>
    * Set the `aws_key_name` to the name of the key to be created in the region of your choice.(optional)
    * Set the `aws_region` to the ID of the region of your choice.(optional)
    * Set the `instance_type` to the size of instance you require.(default: t2.medium)(optional)
    * Set the `server_names` variable to the name you want the instance to display in AWS EC2 console.(optional)
    * Set the `username` to the user you want to create in the new machine.(optional)
    <br/>Note: If the username is changed here then please also execute the following steps:
      1. Set the `user` variable in wh_nodejs_app/wh_ansible/nginx.yml and wh_nodejs_app/wh_ansible/nodejs.yml.
      2. Set the `app_user` variable in wh_nodejs_app/wh_ansible/group_vars/all/main.yml
    * Set the `user_password` to set the password of the above created user.<b>(required)</b>
    * Set the `hostnames` variable to set the internal hostname of the instance(optional)
    <br/>Note: If the hostname is changed here then execute the following steps:
      1. Edit the wh_nodejs_app/wh_ansible/inventories/servers. Change the `hostname` in nodejs and nginx block.  
      Both the hostnames will be same.

## How to execute:

1. To provision the machine with terraform execute the following command:  
`cd wh_nodejs_app/wh_terraform`  
`terraform apply -state=state/dta/wh-aws-nodejs.tfstate`
2. The above command should display the hostname/public IP address, username, password to connect to the instance. You should be able to do a passwordless ssh to the instance from the machine where terraform was executed.
3. From the same machine from where terraform command was executed, execute the following  
`cd wh_nodejs_app/wh_ansible`  
`ansible-playbook -i inventories/servers site.yml`
4. After a few minutes your nodejs application will be accessible on the public IP of the instance on port 80. Just enter the public IP of the instance provided in terraform output in your browser and you will be able to see the current timestamp of the instance in your browser.

## Known Issues/ Limitations:
1. The code has been tested on AWS Seoul and Virginia region but will work on other regions as well.
2. The nodejs app displays static timestamp (current timestamp when the webpage was loaded).
3. The terraform and ansible controller machines have to be Centos 6/7 OS.
4. The nodejs and nginx will be deployed on Ubuntu 16 OS.

## Cleanup
1. Edit /etc/sudoers and remove the entry of the AWS nodejs instance.
2. Edit ~/.ssh/known_hosts remove the entry for AWS nodejs instance
3. Execute the following commands:  
    * `cd wh_nodejs_app/wh_terraform`
    * `terraform destroy -state=state/dta/wh-aws-nodejs.tfstate`  
    You will be asked for confirmation type `yes`. All of the created resources will be deleted.
