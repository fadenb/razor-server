Start centos-razor-server and attach storage and link ports.

  docker run --name razor-server --hostname razor-server -d -p 8080:8080 antillion/razor-server

You will need a DHCP/TFTP server to point to this container.  As well as a
razor-client installed somewhere to interact with the container.


Original here: https://github.com/sedlund/dockerfiles
