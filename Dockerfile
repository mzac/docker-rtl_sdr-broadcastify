FROM ubuntu:latest

MAINTAINER Zachary McGibbon https://github.com/mzac

# Update package cache, install packages, clean cache
RUN apt update \
    && apt -y upgrade \
    && apt install -y bash git cmake libusb-1.0-0-dev build-essential lame libmp3lame-dev libvorbis-dev libshout3-dev ezstream \
    && apt clean

# Create directory for rtl-sdr code
RUN mkdir -p /opt/rtl-sdr
RUN git clone https://github.com/keenerd/rtl-sdr /opt/rtl-sdr
RUN mkdir -p /opt/rtl-sdr/build

WORKDIR /opt/rtl-sdr/build

# Build rtl-sdr code
RUN cmake ../
RUN make
RUN make install
RUN ldconfig

# Copy ezstream_bcfy.xml config
ADD ezstream_bcfy.xml /etc/ezstream_bcfy.xml

# Create run scrip tir and copy run.sh
RUN mkdir /opt/broadcastify
ADD run.sh /opt/broadcastify
RUN chmod +x /opt/broadcastify/run.sh

WORKDIR /opt/broadcastify

CMD ["/opt/broadcastify/run.sh"]
