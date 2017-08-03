# docnow-ansible
Ansible Installer for Yet Another Docnow App

[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](./LICENSE)

## Purpose

The goal of this repository is to set up
[docnow/docnow](https://github.com/docnow/docnow) tool.

### Prerequisites

You will need to have [Ansible](https://ansible.com) installed. It is
recommended to use `pip` as your installer. In addition to ansible the Python
boto package will need to be installed. Both can be installed with the following
step

```
pip install ansible boto
```

On MacOS the following will need to be added or the boto library will fail to
work properly

```
export PYTHONPATH=/usr/local/lib/python2.7/site-packages
```

### Configuration

When you clone this repo it expects you to have an [Amazon EC2 Key
Pair](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
which you will need to add to your account. This information will be used in the
untracked `group_vars/all.yml` file which we have an example of in the
`group_vars/all_template.yml` file. 

We will need to create an ssh key that we will use to log into our created EC2
instances

**Configuration Options**

* vpc_region will be your AWS region
* instance_type will be the size of EC2 instance (we default to the smallest
  free tier one)
* ssh_public_key will be the key you generate to log into your EC2 instance
* aws_access_key and aws_secret_key are the keys you just created above


