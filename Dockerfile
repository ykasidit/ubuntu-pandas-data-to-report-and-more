FROM ubuntu:16.04
RUN apt-get -y update
RUN apt-get -y install python2.7 python2.7-dev
RUN apt-get -y install libpq-dev
RUN apt-get -y install python-pip
RUN apt-get -y install ssh
RUN apt-get -y install python-matplotlib
RUN apt-get -y install sqlite3
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt -y install apt-transport-https ca-certificates
RUN "deb https://download.mono-project.com/repo/ubuntu stable-xenial main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get -y update
RUN apt-get -y install mono-complete
RUN apt-get -y install unzip
RUN pip install gevent==1.2.1
RUN pip install bottle==0.12.13
RUN pip install psycopg2==2.6.1
RUN pip install bottle-pgsql==0.2
RUN pip install pandas==0.23.4
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

RUN wget https://dl.minio.io/client/mc/release/linux-amd64/mc -O /usr/bin/mc
RUN chmod +x /usr/bin/mc

RUN apt-get -y install imagemagick
RUN pip install zipstream
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:jonathonf/ffmpeg-4
RUN apt-get update
RUN apt-get -y install ffmpeg
RUN pip install opencv-python==4.1.2.30
RUN pip install imutils
RUN apt-get -y install tesseract-ocr
RUN pip install celery
RUN pip install pyarrow fastparquet
RUN pip install pandas-gbq
RUN pip install --upgrade google-cloud-bigquery
RUN pip install --upgrade pyasn1-modules
RUN pip install --upgrade cryptography
RUN python -m easy_install --upgrade pyOpenSSL
RUN pip install pydrill
RUN apt-get -y install unixodbc-dev
RUN apt-get -y install alien
RUN curl http://package.mapr.com/tools/MapR-ODBC/MapR_Drill/MapRDrill_odbc_v1.3.22.1055/maprdrill-1.3.22.1055-1.x86_64.rpm --output /mapdrill_odbc.rpm
RUN alien -i /mapdrill_odbc.rpm
RUN rm /mapdrill_odbc.rpm
RUN pip install pyodbc
RUN pip install sqlparse==0.3.1
RUN pip install mailjet-rest
RUN pip install python-pptx