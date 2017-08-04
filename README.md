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
pip install -r requirements.txt
```

On MacOS the following will need to be added or the boto library will fail to
work properly

```
export PYTHONPATH=/usr/local/lib/python2.7/site-packages
```

### Configuration

*AWS*

When you clone this repo it expects you to have an [Amazon EC2 Key
Pair](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
which you will need to add to your account. This information will be used in the
untracked `group_vars/all.yml` file which we have an example of in the
`group_vars/all_template.yml` file. 

Create a file under the `~/.aws/` directory named `credentials`. The contents of
this file will contain the keypair and look like this

```
cat ~/.aws/credentials
[default]
aws_access_key_id = GENERATEDAWSKEYABOVE
aws_secret_access_key = randomstringofcharactersgeneratedabove
```

We will also need to create an ssh key that we will use to log into our created EC2
instances

*OpenSSH*

In order to log into your EC2 instance this playbook will upload your ssh keys
to your AWS. To generate your keys

```
ssh-keygen -t rsa -f ~/.ssh/id_docnow
```

**Configuration Options**

* vpc_region will be your AWS region
* instance_type will be the size of EC2 instance (we default to the smallest
  free tier one)
* ssh_public_key will be the key you generated above to log into your EC2 instance
* aws_access_key and aws_secret_key are the keys you just created above

Make a copy of `group_vars/all_template.yml`

```
cp group_vars/all_template.yml group_vars/all.yml
```

and make the appropriate changes


### How it works

When all this is done run 

```
ansible-playbook -e 'aws_secret_key='randomstringofcharactersgeneratedabove -e 'aws_access_key=GENERATEDAWSKEYABOVE' -vv provision.yml -u ubuntu -b
```

the 

* ansible-playbook is the command
* the `e` flag allows us to pass the variables. You can also set these as
  environment variables in your shell using `export` or other
* the `vv` allows us to at least get the IP address of the AWS create EC2 instance
  where we will log in
* the `u` flag passes the ubuntu user that is used by the Amazon AMI
* the `b` flag gives elevated privileges to the remote user

When this is done your playbook will list the IP of the completed end point to
log into. Below is an example of a completed play.

```
PLAY RECAP ******************************************************************************************************************************************************************************************************************************************************************
54.235.55.73               : ok=13   changed=10   unreachable=0    failed=0
localhost                  : ok=9    changed=3    unreachable=0    failed=0
```

In that example pointing your browser to 

http://54.235.55.73:3000

will lead you to your application.
