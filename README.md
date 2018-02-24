# docnow-ansible
Ansible Installer for Yet Another Docnow App

[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](./LICENSE)

## Purpose

The goal of this repository is to set up
[docnow/docnow](https://github.com/docnow/docnow) tool.

### Prerequisites

You will need to have [Terraform](https://terraform.io) installed on your
computer. In addition you will need to have [Ansible](https://ansible.com) installed. It is
recommended to use `pip` as your installer. In addition to ansible the Python
boto package will need to be installed. Both can be installed with the following
step


### Configuration

*AWS*

From your AWS account create access keys that you will need to create AWS
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

**Configuration Options**

### How it works

When all this is done create your AWS infrastructure from the `staging` or
`production` directory under the `terraform_*` environment you would like to
build

```
terraform get
```

which will build your docnow, elastic, and networking modules

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

* `docnow_ip` and `elastic_ip` will be added to the `hosts` file
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
