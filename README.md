Ansible Debian bootstrap
========================

This role bootstraps Debian server:

  - Configure APT (sources.list)
  - Install minimal packages (vim, htop...)
  - Install Intel/AMD microcode if needed
  - Install and configure [OpenNTPd](http://www.openntpd.org/)
  - Add user with SSH key, sudoers
  - Deploy bashrc, vimrc for root
  - Update few alternatives
  - Configure system: hostname, timezone and locale
  - Sysctl tuning


Requirements
------------

This role needs sudo package allready installed.

Role Variables
--------------

### APT configuration

Theses variables define hostname to configure APT (normal repo and backports):

  - dbs\_debian\_backport\_host
  - dbs\_apt\_default\_host

### System configuration

  - dbs\_hostname: system hostname
  - dbs\_default\_locale: default system locale
  - dbs\_locales: list of installed locales 
  - dbs\_timezone: system timezone
  - dbs\_sysctl\_config: list of kernel parameters, see: [default/main.yml]

### NTPd

  - dbs\_ntp\_host: hostname of NTP server. Don't prepend with "0.", "1."...

### User

  - dbs\_users: list of user

Each row have few keys:

  - name: username on system
  - shell: default is /bin/bash
  - sudo: boolean (true = can sudo)


### Readonly vars

  - dbs\_packages: list of packages to install
  - dbs\_hostname\_files: list of file where we should substitute bad hostname
  - dbs\_microcode\_apt\_distribution: location of package to install microcode
  - dbs\_distro\_packages: list specific package to install (related to debian version)

TODO
----

  - Deploy to Ansible Galaxy
  - Add travis IC
  - Manage syslog daemons: rsyslog, syslog-ng...
  - Uninstall systemd (Jessie)
  - Support Devuan
  - DNS management: pdns-recursor, resolv.conf...
  - IP management

Dependencies
------------

None.

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: HanXHX.debian_bootstrap }

License
-------

GPLv2

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
