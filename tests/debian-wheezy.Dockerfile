FROM williamyeh/ansible:debian7-onbuild

RUN apt-get update
CMD ["sh", "tests/test-travis.sh"]

