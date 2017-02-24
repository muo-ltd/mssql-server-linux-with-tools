# mssql-server-linux-with-tools
Microsoft SQL Server Docker image with tools installed.

This image is based upon the [mssql-server-linux](https://hub.docker.com/r/microsoft/mssql-server-linux/). It adds the 
[SQL Server Command Line Tools](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-connect-and-query-sqlcmd) 
to the image to make it easier for local development. It also overcomes a few simple problems I had 
whilst preparing the image, such as lack of the correct language pack, and apt transaport. 

*Note* if you are running this image on a Docker toolkit system or Docker for Mac, then there are problems mounting the volumes to your local
file system. 

## Building 

```
docker build . --tag mssql-server-linux-with-tools
```

## Running 

On a system running Docker Toolkit or Docker for Mac there are problems mounting the local file system so you will need to use a 
data container (as shown below). 

```
docker create -v /mssqlserver/data:/var/opt/mssql/data \
              -v /mssqlserver/autorestore:/var/autorestore \
              --name sqlstore \
              alpine /bin/true

docker run -e 'SA_PASSWORD=<Your Strong Password>' \
              -p 1433:1433 -d \
              --volumes-from sqlstore \
              mssql-server-linux-with-tools
```

Note if you are using virtualbox and are using shared folders you can't map the data volume or the image directly to a shared folder as it
will cause an error. Hopefully at some point Microsoft will fix this.

## To do

Enable a command to auto-restore backups found in the autorestore directory.