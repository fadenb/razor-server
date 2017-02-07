# razor-server

You'll need a Postgres server running somewhere; the container expects it to
have the name `postgres` so use appropriately.

Recommended way: use another Docker container:

  docker run -d --name razor-postgres \
             -e POSTGRES_PASSWORD=mypass -e POSTGRES_DB=razor \
             postgres


And then link it:             

  docker run --name razor-server \
             --hostname razor-server \
             -e DATABASE_HOSTNAME=postgres \
             -e DATABASE_USERNAME=postgres \
             -e DATABASE_PASSWORD=mypass \
             -d -p 8080:8080 \
             --link razor-postgres:postgres \
             antillion/razor-server

You will need a DHCP/TFTP server to point to this container.  As well as a
razor-client installed somewhere to interact with the container.


Original here: https://github.com/sedlund/dockerfiles
