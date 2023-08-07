FROM ykasidit/ubuntu-pandas-data-to-report-and-more-python3:latest

USER root

RUN apt-get update
RUN apt-get -y install docker.io mosquitto-clients
RUN pip install pdoc jupyterlab
RUN apt-get -y install xvfb

USER report_worker
