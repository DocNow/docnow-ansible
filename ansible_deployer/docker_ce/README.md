Role Name
=========

Install [docker ce](https://www.docker.com/)

Requirements
------------

The role targets Ubuntu and CentOS based systems build on the `x86_64` architecture.



Role Variables
--------------


Dependencies
------------


Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: docker_ce, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a
website (HTML is not allowed).
