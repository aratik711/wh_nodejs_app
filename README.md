# wh_nodejs_app

Presumptions:
1. Nginx and nodejs servers are placed in the same machine.
2. Nodejs application runs on 8090 port
3. Nginx default port is 8080
4. Nodejs app is routed via nginx at port 8080
5. The application will be deployed on Ubuntu 16.04 machine.


Prerequisites:
1. Install Python >=2.7 
2. Terraform and ansible installed on Centos machine. Both configured on same machine.
3. Terraform version v0.9.2 (latest). Installation steps: https://www.terraform.io/intro/getting-started/install.html
4. Ansible version  2.2.1.0 (latest). Installation steps: http://docs.ansible.com/ansible/intro_installation.html
5. Clone this repository: git clone https://github.com/aratik711/wh_nodejs_app.git
6. Execute the following steps:
a. cd wh_nodejs_app
b. ssh-keygen -t rsa -f wh_terraform/setup/dta/wh_nodejs_key
c. openssl rsa -in wh_terraform/setup/dta/wh_nodejs_key -outform pem > wh_terraform/setup/dta/wh_nodejs_key.pem
d. export AWS_ACCESS_KEY_ID="Your AWS access key"
e. export AWS_SECRET_ACCESS_KEY="Your AWS secret key"


