FROM microsoft/mssql-server-linux

ENV ACCEPT_EULA=Y

RUN apt-get -y install curl apt-transport-https language-pack-en && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list  && \
    apt-get update  && \
    apt-get -y install mssql-tools unixodbc-dev && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

VOLUME /var/autorestore
VOLUME /var/opt/mssql/data