FROM ykasidit/ubuntu-pandas-data-to-report-and-more-python3:latest

USER root

RUN apt-get update
RUN apt-get -y install docker.io mosquitto-clients
RUN pip install pdoc jupyterlab
RUN apt-get -y install xvfb
RUN apt-get -y install python3-pyqt5
RUN git clone --depth 1 --branch v3.7.1 https://github.com/OSGeo/gdal.git
RUN apt -y install cmake libproj-dev libkml-dev
RUN cd gdal && mkdir build && cd build && cmake -DGDAL_ENABLE_DRIVER_LIBKML=ON .. && cmake --build . -j`nproc`
RUN cd gdal/build && cmake --build . --target install
RUN apt-get update
RUN apt-get -y install poppler-utils

##### below credit to https://github.com/Kotaimen/docker-mapnik/blob/master/Dockerfile
#
# Install packages
#
RUN         set -x \
            &&  apt-get -q update \
            &&  apt-get -yq --no-install-recommends install \
                    locales \
                    ca-certificates \
                    curl \
                    build-essential \
                    gcc \
                    imagemagick \
                    libmapnik3.0 \
                    mapnik-utils \
                    \
                    python3 \
                    cython3 \
                    python3-pip \
                    python3-wheel \
                    python3-setuptools \
                    python3-dev \
                    python3-pil \
                    python3-numpy \
                    python3-scipy \
                    python3-pylibmc \
                    python3-skimage \
                    python3-gdal \
                    python3-mapnik \
                    python3-lxml \
                    \
                    npm

#
# Install carto
#
#RUN         npm install -g carto millstone

#
# Patch missing gdal data file
#
#RUN         curl -sSL https://github.com/OSGeo/gdal/raw/2.2/gdal/data/esri_extra.wkt > \
#                /usr/share/gdal/2.2/esri_extra.wkt


RUN python3 -m pip install --upgrade pip
COPY ./requirements_generated.txt /requirements.txt
RUN pip install -r /requirements.txt
RUN pip install requests==2.31.0
RUN pip install boto3==1.33.13 botocore==1.33.13
RUN wget https://dl.minio.io/client/mc/release/linux-amd64/mc -O /usr/bin/mc
RUN chmod +x /usr/bin/mc

USER report_worker
