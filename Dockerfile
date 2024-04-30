FROM ubuntu:22.04
RUN apt-get -y update

ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd report_worker -m
RUN usermod -s /bin/bash report_worker

RUN apt-get -y install python3 python3-dev
RUN apt-get -y install python-is-python3
RUN apt-get -y install python3-pip
RUN python --version | grep 3.10
RUN pip --version | grep 'python 3.10'

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tshark
RUN apt-get -y install libpq-dev ssh python-matplotlib-data sqlite3 unzip zip sox python3-mysqldb git-core gdal-bin python3-gdal redis-tools iputils-ping curl libreoffice python-matplotlib-data imagemagick software-properties-common ffmpeg tesseract-ocr unixodbc-dev openjdk-11-jdk iproute2 libev-dev libevdev2 libsqlite3-mod-spatialite docker.io mosquitto-clients curl wget busybox

RUN wget https://dl.minio.io/client/mc/release/linux-amd64/mc -O /usr/bin/mc
RUN chmod +x /usr/bin/mc

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

COPY requirements.txt /requirements_ext0.txt
RUN pip install -r /requirements_ext0.txt

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get -y install apt-transport-https ca-certificates gnupg
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get -y update
RUN apt-get -y install google-cloud-sdk

USER report_worker