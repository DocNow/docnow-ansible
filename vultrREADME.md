## Vultr Service Provider

***The following instructions will cost you money. Please remember to turn off your VPS when you are done***

* Mininally you will need to [install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) Ansible will be used to configure the Virtual Private Server you will be setting up on [Scaleway](https://www.scaleway.com/en/) that will be hosting the docnow app.
* You will need to [create ssh-keys](https://www.vultr.com/docs/how-do-i-generate-ssh-keys)

### Configure your account

* Follow the instructions to [create an account here](https://www.vultr.com/register/)
  * You can generate an API token via the Vultr [console](https://my.vultr.com/settings/#settingsapi) you will need to add that to the [ansible_deployer/group_vars/vultr/vars.yml](ansible_deployer/group_vars/vultr/vars.yml) `vultr_api_key` variable
