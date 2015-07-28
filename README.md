Ansible Debian bootstrap
========================

This role bootstraps Debian server:

  - Configure APT (sources.list)
  - Install minimal packages (vim, htop...)
  - Install Intel/AMD microcode if needed
  - Install and configure Local DNS with [Unbound](https://www.unbound.net). Feature in beta-test!
  - Install and configure [OpenNTPd](http://www.openntpd.org/)
  - Add user with SSH key, sudoers
  - Deploy bashrc, vimrc for root
  - Update few alternatives
  - Configure system: hostname, timezone and locale
  - Purge, delete and avoid systemd if wanted
  - Sysctl tuning


Requirements
------------

This role needs `sudo` package already installed.

Role Variables
--------------

### APT configuration

Theses variables define hostname to configure APT (normal repo and backports):

  - `dbs_debian_backport_host`
  - `dbs_apt_default_host`
  - `dbs_apt_use_src`: install "deb-src" repositories (default: false)
  - `dbs_apt_components`: components uses in sources.list (default: "main contrib non-free")

### System configuration

  - `dbs_hostname`: system hostname
  - `dbs_default_locale`: default system locale
  - `dbs_locales`: list of installed locales
  - `dbs_timezone`: system timezone
  - `dbs_sysctl_config: list of kernel parameters, see`: [default/main.yml]
  - `dbs_use_systemd`: delete systemd if set to false (persistent)
  - `dbs_use_unbound`: configure Local DNS and manage network (default is false)

### NTPd

  - `dbs_ntp_host`: hostname of NTP server. Don't prepend with "0.", "1."...

### User

  - `dbs_users`: list of user

Each row have few keys:

  - `name`: username on system
  - `shell`: default is /bin/bash
  - `sudo`: boolean (true = can sudo)
  - `ssh_keys`: list of ssh public keys


### Readonly vars

  - `dbs_packages`: list of packages to install
  - `dbs_hostname_files`: list of file where we should substitute bad hostname
  - `dbs_microcode_apt_distribution`: location of package to install microcode
  - `dbs_distro_packages`: list specific package to install (related to debian version)

TODO
----

  - Manage syslog daemons: rsyslog, syslog-ng...
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

  - You can find many other roles in my GitHub "lab": https://github.com/HanXHX/my-ansible-playbooks
  - All issues, pull-request are welcome :)
