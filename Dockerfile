FROM bitnami/minideb:bullseye

RUN apt-get update
RUN apt-get -y install apt-transport-https ca-certificates apt-transport-https ca-certificates gnupg wget curl

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN "deb https://download.mono-project.com/repo/ubuntu stable-xenial main" | tee /etc/apt/sources.list.d/mono-official-stable.list

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install unzip sox zip python3-mysqldb git-core gdal-bin python3-gdal tshark redis-tools iputils-ping python-matplotlib-data imagemagick software-properties-common ffmpeg tesseract-ocr openjdk-11-jdk iproute2 google-cloud-sdk libev-dev libevdev2 libsqlite3-mod-spatialite docker.io mosquitto-clients libpq-dev ssh sqlite3 python3 python3-dev python-is-python3 python3-pip busybox socat

RUN wget https://dl.minio.io/client/mc/release/linux-amd64/mc -O /usr/bin/mc
RUN chmod +x /usr/bin/mc

RUN useradd report_worker -m
RUN usermod -s /bin/bash report_worker
USER report_worker
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY requirements.txt ./

RUN pip install -r requirements.txt
ENV PATH="${PATH}:/home/report_worker/.local/bin"
