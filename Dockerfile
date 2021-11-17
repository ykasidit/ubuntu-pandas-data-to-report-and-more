FROM ubuntu:20.04
RUN apt-get -y update

ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get -y install python3 python3-dev
RUN apt-get -y install python-is-python3
RUN apt-get -y install python3-pip
RUN python --version | grep 3.8
RUN pip --version | grep 'python 3.8'
RUN apt-get -y install libpq-dev
RUN apt-get -y install ssh
RUN apt-get -y install python-matplotlib-data
RUN apt-get -y install sqlite3
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt -y install apt-transport-https ca-certificates
RUN "deb https://download.mono-project.com/repo/ubuntu stable-xenial main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get -y update
RUN apt-get -y install mono-complete
RUN apt-get -y install unzip
RUN apt-get -y install zip
RUN apt-get -y install sox
RUN useradd report_worker -m
RUN apt-get -y install python3-mysqldb
RUN apt-get -y install git-core
RUN apt-get -y install gdal-bin
RUN apt-get -y install python3-gdal
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tshark
RUN apt-get -y install redis-tools
RUN apt-get -y install iputils-ping
RUN apt-get -y install curl
RUN apt-get -y install libreoffice
RUN apt-get -y install python-matplotlib-data
RUN wget https://dl.minio.io/client/mc/release/linux-amd64/mc -O /usr/bin/mc
RUN chmod +x /usr/bin/mc
RUN apt-get -y install imagemagick
RUN apt-get -y install software-properties-common
RUN apt-get -y install ffmpeg
RUN apt-get -y install tesseract-ocr
RUN python -m easy_install --upgrade pyOpenSSL
RUN apt-get -y install unixodbc-dev
RUN apt-get -y install alien
RUN curl http://package.mapr.com/tools/MapR-ODBC/MapR_Drill/MapRDrill_odbc_v1.3.22.1055/maprdrill-1.3.22.1055-1.x86_64.rpm --output /mapdrill_odbc.rpm
RUN alien -i /mapdrill_odbc.rpm
RUN rm /mapdrill_odbc.rpm
RUN apt-get -y install openjdk-11-jdk


RUN pip install gevent
RUN pip install bottle
RUN pip install psycopg2
RUN pip install bottle-pgsql
RUN pip install pandas
RUN pip install openpyxl==2.4.0
RUN pip install --upgrade pip
RUN pip install smopy==0.0.6
RUN pip install psutil==3.4.2
RUN pip install scipy
RUN pip install simplekml
RUN pip install sqlalchemy
RUN pip install numba
RUN pip install haversine
RUN pip install chaversine
RUN pip install humanize
RUN pip install redis
RUN pip install pytest
RUN pip install PyMySQL
RUN pip install psycogreen
RUN pip install nose2
RUN pip install nose
RUN pip install minio
RUN pip install pyjwt
RUN pip install requests
RUN pip install zipstream
RUN pip install opencv-python==4.1.2.30
RUN pip install imutils
RUN pip install celery
RUN pip install pyarrow fastparquet
RUN pip install pandas-gbq
RUN pip install --upgrade google-cloud-bigquery
RUN pip install --upgrade pyasn1-modules
RUN pip install --upgrade cryptography
RUN pip install pydrill
RUN pip install pyodbc
RUN pip install sqlparse==0.3.1
RUN pip install mailjet-rest
RUN pip install python-pptx
RUN pip install duckdb==0.2.7
RUN pip install pylint
RUN pip install pyflakes
RUN pip install flake8
RUN pip install pyjnius
RUN pip install joblib
RUN pip install sklearn
RUN pip install modestimage
RUN pip install --upgrade google-cloud-storage

RUN apt-get install -y iproute2
RUN usermod -s /bin/bash report_worker

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get -y install apt-transport-https ca-certificates gnupg
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get -y update
RUN apt-get -y install google-cloud-sdk

RUN pip install gunicorn
RUN apt -y install libev-dev libevdev2
RUN pip install bjoern
RUN apt -y install libsqlite3-mod-spatialite 
RUN pip install spatialite==0.0.3
RUN pip install mypy

USER report_worker