FROM ykasidit/ubuntu-pandas-data-to-report-and-more-python3-ext:latest

USER report_worker
RUN mkdir -p ~/azenqos-qgis-plugin
RUN mkdir -p ~/.local/share/QGIS/QGIS3/profiles
ADD --chown=report_worker azenqos_qgis_plugin /home/report_worker/azenqos-qgis-plugin
ADD --chown=report_worker profiles /home/report_worker/.local/share/QGIS/QGIS3/profiles
WORKDIR /home/report_worker/azenqos-qgis-plugin

USER root
RUN apt -y install sudo
RUN HOME=/home/report_worker ./install_azenqos_plugin_ubuntu.sh

USER report_worker
