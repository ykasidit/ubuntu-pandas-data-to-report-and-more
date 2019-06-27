FROM ubuntu:16.04
RUN apt-get -y update
RUN apt-get -y install python2.7 python2.7-dev
RUN apt-get -y install libpq-dev
RUN apt-get -y install python-pip
RUN apt-get -y install ssh
RUN apt-get -y install python-matplotlib
RUN apt-get -y install sqlite3

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list

RUN apt-get -y install mono-complete

RUN apt-get -y install unzip

RUN pip install gevent==1.2.1
RUN pip install bottle==0.12.13
RUN pip install psycopg2==2.6.1
RUN pip install bottle-pgsql==0.2
RUN pip install pandas==0.20.3
RUN pip install openpyxl==2.4.0
RUN pip install --upgrade pip
RUN pip install smopy==0.0.6
RUN pip install psutil==3.4.2
RUN pip install scipy==1.0.0
RUN pip install simplekml
RUN apt-get -y install zip
RUN pip install sqlalchemy

RUN apt-get -y install sox

RUN useradd report_worker -m

RUN apt-get -y install python-mysqldb

RUN apt-get -y install git-core
RUN apt-get -y install gdal-bin
RUN apt-get -y install python-gdal

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tshark
RUN pip install numba
RUN pip install haversine
RUN pip install chaversine
RUN pip install humanize
RUN pip install redis
RUN apt-get -y install redis-tools
RUN apt-get -y install iputils-ping
RUN apt-get -y install curl
RUN pip install pytest
RUN pip install PyMySQL
RUN pip install psycogreen
RUN pip install nose2

RUN apt-get -y install libreoffice
RUN pip install nose
RUN pip install minio
RUN pip install pyjwt
RUN pip install requests
RUN pip install matplotlib==2.2.0
