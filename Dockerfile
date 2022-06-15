FROM ykasidit/ubuntu-pandas-data-to-report-and-more-python3:latest

USER root

RUN apt-get update
RUN apt-get -y install docker.io
RUN apt-get -y install mosquitto-clients

USER report_worker