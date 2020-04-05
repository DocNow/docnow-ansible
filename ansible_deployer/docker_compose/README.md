Role Name
=========

A role to install [docker-compose](https://github.com/docker/compose)

Requirements
------------

The role targets Ubuntu and CentOS based systems build on the `x86_64` architecture

The [docker engine](https://www.docker.com/) has to be installed on the target machine for docker-compose to function correctly.

Role Variables
--------------



Dependencies
------------

The role depends on the presence of [docker](https://www.docker.com/) but has no dependencies

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: docker_compose, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a
website (HTML is not allowed).
