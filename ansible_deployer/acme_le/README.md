Role Name
=========

This role installs [ACME LE](https://certbot.eff.org/all-instructions)

Requirements
------------


Role Variables
--------------

You need to modify the settings in the `defaults/main.yml` file to be yours


Dependencies
------------


Example Playbook
----------------


    - hosts: servers
      roles:
         - { role: acme_le, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a
website (HTML is not allowed).
