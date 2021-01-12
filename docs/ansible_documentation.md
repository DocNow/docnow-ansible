# Introduction

[Ansible](https://www.ansible.com) is a configuration management system which is designed to streamling and
automate the process of controlling a large number of systems and/or minimize
the complexity of managing software installation. Ansible offers a simple
architecture that does not require special software on the remote nodes that one
will manage. We will be using Ansible to manage the process of installation and
maintenance of the docnow application.

## Process Flow

Ansible works by configuring managed machines. In our case the remote server on
a cloud provider. (Here on referred to as *managed node*). The process is run
from a client, your desktop, laptop etc., (Here on referred to as *client
node*).

The communication process is done using the SSH protocol where it retrieves
information about the remote server using a very modular process ensures that
the state of the remote state is what is defined in an ansible playbook.

## Prerequisites

To install the Docnow App, you will need:

* One Ansible Control Node: Select your platform below for steps to install
   Ansible on your preferred platform. Ansible will need to be installed and
   configured with SSH keys. The remote user connecting will need to have sudo
   privileges on the remote host
* A Remote Host: Select your [Cloud Provider](cloud_provider.md). The remote
   server will have the public key from the control node in the `authorized_keys` file.

### Microsoft Windows

### macOS

### Ubuntu Bionic
