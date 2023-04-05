FROM ykasidit/ubuntu-pandas-data-to-report-and-more-python3:latest

USER root

RUN apt-get update
RUN apt-get -y install docker.io
RUN apt-get -y install mosquitto-clients

RUN wget https://www.openssl.org/source/openssl-1.1.1p.tar.gz -O openssl-1.1.1p.tar.gz && \
tar -zxvf openssl-1.1.1p.tar.gz && \
cd openssl-1.1.1p && \
./config && \
make -j`npropc` && \
make install && \
ldconfig
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql18

USER report_worker