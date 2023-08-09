FROM ykasidit/ubuntu-pandas-data-to-report-and-more-python3:latest

USER root

RUN apt-get update
RUN apt-get -y install docker.io mosquitto-clients
RUN pip install pdoc jupyterlab
RUN apt-get -y install xvfb
RUN apt-get -y install python3-pyqt5
COPY azenqos_qgis_plugin/Azenqos/requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
RUN git clone --depth 1 --branch v3.7.1 https://github.com/OSGeo/gdal.git
RUN apt -y install cmake libproj-dev libkml-dev
RUN cd gdal && mkdir build && cd build && cmake -DGDAL_ENABLE_DRIVER_LIBKML=ON .. && cmake --build . -j`nproc`
RUN cd gdal/build && cmake --build . --target install

USER report_worker
