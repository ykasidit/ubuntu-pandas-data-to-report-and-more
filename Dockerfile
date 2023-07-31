FROM ykasidit/ubuntu-pandas-data-to-report-and-more-python3:latest

USER root

RUN apt-get update
RUN apt-get -y install docker.io mosquitto-clients
RUN pip install pdoc jupyterlab

RUN apt-get -y install xvfb ghostscript
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install qgis
COPY requirements.txt /azq_qgis_requirements.txt
RUN pip install -r /azq_qgis_requirements.txt

USER report_worker
