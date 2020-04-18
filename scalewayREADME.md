## Scaleway Service Provider

***Using these instructions will cost you money***

* Follow the instructions to [create an account here](https://www.scaleway.com/en/docs/create-your-scaleway-account/)
  * You can generate an API token via the Scaleway [console](https://cloud.scaleway.com/#/credentials) you will need to add that to the [ansible_deployer/playbooks/scaleway_deploy](ansible_deployer/group_vars/vars.yml) `scw_api_key` variable
  * You will need to use the contents of organization id in your user account in the ![alt text](images/scaleway_org_credentials.png "scaleway organization credentials") [ansible_deployer/group_vars/scaleway/vars.yml](ansible_deployer/group_vars/scaleway/vars.yml) `organization_id` variable.
* Follow the instructions to create and configure an [SSH Key on Scaleway](https://www.scaleway.com/en/docs/configure-new-ssh-key/)
  * You will need to use the contents from the public key above in the [ansible_deployer/group_vars/scaleway/vars.yml](ansible_deployer/group_vars/scaleway/vars.yml) `add_your_key` variable.
