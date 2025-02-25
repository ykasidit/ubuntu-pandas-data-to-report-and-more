FROM ubuntu:24.04
RUN apt-get -y update

ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd report_worker -m
RUN usermod -s /bin/bash report_worker

#### apt
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y iputils-ping emacs-nox python3 python3-dev python-is-python3 python3-pip emacs-nox nano tshark libpq-dev ssh python-matplotlib-data sqlite3 unzip zip sox python3-mysqldb git-core gdal-bin python3-gdal redis-tools iputils-ping curl libreoffice python-matplotlib-data imagemagick software-properties-common ffmpeg tesseract-ocr unixodbc-dev openjdk-11-jdk iproute2 libev-dev libevdev2 libsqlite3-mod-spatialite docker.io mosquitto-clients curl wget busybox apt-transport-https ca-certificates gnupg docker.io mosquitto-clients xvfb python3-pyqt5 cmake libproj-dev libkml-dev poppler-utils swig

### mapnik
##### below credit to https://github.com/Kotaimen/docker-mapnik/blob/master/Dockerfile
#
# Install packages
#
RUN apt-get -yq --no-install-recommends install \
                    locales \
                    ca-certificates \
                    curl \
                    build-essential \
                    gcc \
                    imagemagick \
                    libmapnik3.1 \
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
                    python3-venv \
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

### minio client
RUN wget https://dl.minio.io/client/mc/release/linux-amd64/mc -O /usr/bin/mc
RUN chmod +x /usr/bin/mc

### gcloud sdk and other freq changed apt pkgs
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get -y update
RUN apt-get -y install google-cloud-sdk

### tshark specific ver
RUN mkdir -p /host_shared_dir/tmp_gen && chmod 777 /host_shared_dir/tmp_gen && mkdir /tshark && \
    cd /tshark && \
    wget https://github.com/vuttichai2/tshark_for_linux_x86-64/releases/download/4.2.5/tshark_4.2.tar.gz && \
    tar -xzvf tshark_4.2.tar.gz && \
    rm tshark_4.2.tar.gz && \
    chmod 777 *

### create the virtual environment in a location accessible by all users
RUN python -m venv /venv

### prepend the venv bin directory to the PATH
ENV PATH="/venv/bin:$PATH"

### gdal lib and py pkg into current /venv in path
# Clone GDAL repository at the desired version
RUN git clone --depth 1 --branch v3.10.2 https://github.com/OSGeo/gdal.git && pip install --upgrade pip setuptools wheel numpy

RUN cd gdal && mkdir build && cd build && \
    cmake -DGDAL_ENABLE_DRIVER_LIBKML=ON \
          -DBUILD_PYTHON_BINDINGS=ON \
          -DPYTHON_EXECUTABLE=/venv/bin/python \
          -DPYTHON_SITE_PKG_DIR=/venv/lib/python3.11/site-packages \
          -DCMAKE_INSTALL_PREFIX=/venv \
          .. && \
    cmake --build . -j$(nproc) && \
    cmake --build . --target install && \
    cd ../.. && rm -rf gdal

# Ensure the dynamic linker can find libgdal.so.36 in /venv/lib
ENV LD_LIBRARY_PATH=/venv/lib:$LD_LIBRARY_PATH

# test it
RUN python -c "from osgeo import ogr"
RUN ogr2ogr --version && ogrinfo --formats | grep -i libkml

### pip less frequnetly changed
COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt


### apt smaller changes (so can use cache)
RUN apt -y install libmysqlclient-dev pkg-config default-libmysqlclient-dev

### pip smaller changes (so can use cache)
COPY requirements_ext0.txt /requirements_ext0.txt
RUN pip install --upgrade -r /requirements_ext0.txt

### tests
RUN python -c "from osgeo import ogr"

### set default worker  
USER report_worker
CMD ["/usr/bin/sleep", "infinity"]