About tests
===========

In my others Ansible roles, I use Travis with Docker with this project: [https://github.com/moul/travis-docker].

But in this role, I can't use it due to Docker limitations:

  - hostname can't be change (look [https://docs.docker.com/articles/networking/#configuring-dns])
  - reboot is impossible

The only way to test this role: VirtualBox. If you know an IC (like Travis) with this system, contact me!
