# Install the docnow application
Ansible Installer the Docnow App

[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](./LICENSE)

## Purpose

The goal of this repository is to set up
[docnow/docnow](https://github.com/docnow/docnow) tool.

## Status of this Repo

### Components

- [ ] How to connect to Redis instance
- [ ] Copy all staging modules into and add  production
- [ ] Create Amazon DNS module
- [ ] Create Let's Encrypt module

### Critical cleanup and review

- [ ] How to run this repo as a user with Microsoft Windows (Packer)
- [ ] Improve documentation to include production

### Non-critical improvements

- [ ] Make it more DRY on the modules

### Prerequisites

* You must have [Terraform](https://www.terraform.io/) installed on your computer. 
* You must have [Ansible](https://ansible.com/) installed on your computer. 
* You must have an [Amazon Web Services (AWS) account](http://aws.amazon.com/).

**On Ubuntu**

```
cd ~
mkdir bin
cd bin
wget https://releases.hashicorp.com/terraform/0.11.5/terraform_0.11.5_linux_amd64.zip
unzip terraform_0.11.5_linux_amd64.zip
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

Your versions may differ from the terraform examples presented above. Please note that this code was written for Terraform 0.11.7

**On MacOS**

```
brew install terraform ansible
```

Your versions may differ from the terraform examples presented above. Please note that this code was written for Terraform 0.11.7

### Configuration

**Your own infrastructure**

If you intend to run this on your own infrastructure, you will need a [Docker Host](https://docker.com) and [Docker
compose](https://docs.docker.com/compose/) installed on the host. It is
recommended that you set up a reverse proxy web server ideally with TLS. Your
reverse proxy server will listen on port 3000 for the docnow application

Clone the docnow repo

```
git clone https://github.com/DocNow/docnow.git
```
From the cloned repo review the `docker-compose.yml` file and adjust
accordingly. Specifically determine where you plan to host your elasticsearch
and redis. Then run

```
docker-compose up -d
```

**AWS**

**Please note that this example will deploy real resources into your AWS account. We have made every effort to ensure 
all the resources qualify for the [AWS Free Tier](https://aws.amazon.com/free/), but we are not responsible for any
charges you may incur.** 

Configure your [AWS access 
keys](http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) as 
environment variables:

From your AWS access keys above you will need to create AWS
services. Enter the generated keys on a file named `~/.aws/credentials`

```
cat ~/.aws/credentials
[default]
aws_access_key_id = GENERATEDAWSKEYABOVE
aws_secret_access_key = randomstringofcharactersgeneratedabove
```

We will also need to create an ssh key that we will use to log into our created EC2
instances

*OpenSSH*

In order to log into your EC2 instance terraform will upload your ssh keys
to your AWS. To generate your keys

```
ssh-keygen -t rsa -C "docnow_key" -f ./docnow_key
```
then add them to your sessions with 

```
ssh-add -K docnow_key
```

Copy `hosts_example` to `hosts` in the `staging` directory and then copy
`docker-compose.yml-example` to `docker-compose.yml` in the docnow ansible role

## Configuration Options

### How it works

When all this is done create your AWS infrastructure from the `staging` or
`production` directory under the `terraform_*` environment you would like to
build

```
terraform init
```

This will initialize the repo and pull the correct terraform plugins

```
terraform get
```

This will build your docnow, elastic, and networking modules

```
terraform plan
```

where you will be prompted for the number of VMs you plan to have

```
terraform apply
```

Which repeats the same step as plan but creates your infrastructure. The process
will complete with information we will need for our ansible playbook.

The output for

* `docnow_ip`, `redis_ip`, and `elastic_ip` will be added to the `hosts` file
* `elastic_ip` and `redis_ip` will also be added to the `docker-compose.yml` file
* `bastion_host` will be appended to your `~/.ssh/config` file
* `elb_hostname` will be the URI to point to

The repo has examples of `ssh_config` and `hosts_example` above

Then run the playbook to complete the application

```
ansible-playbook ansible/deploy.yml -b
```

When this is done your playbook will list the IP of the completed end point to
log into. Below is an example of a completed play.

In that example pointing your browser to the `elb_hostname` variable

will lead you to your application.
