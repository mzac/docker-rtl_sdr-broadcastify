# docker-rtl_sdr-broadcastify
Docker container for streaming RTL SDR to Broadcastify

# Introduction
This docker container will help you run a Broadcastify stream.  I did this to make my life easier when my Raspberry Pi died on me and I
I wanted a quick way to recover.  Note this Dockerfile should work on both Intel and ARM archs however you will have to build the container
yourself since it includes the built in config files.  Optionally, you could mount the two files in a volume.

# Reference
This container was based on the instructions from Broadcastify/Radioreference:
- https://wiki.radioreference.com/index.php/Raspberry_Pi_RTL-SDR_Broadcastify

# Todo
- [ ] Create docker-compose.yml
- [ ] Update run.sh with more variables (instead of hard coded)
- [ ] Allow passing more arguments from the CLI

# Requirements
- A Linux computer (Intel/x64/AMD or Raspberry Pi or any other SBC)
- A RTL SDR dongle of some sorts and an antenna
- A good knowledge of Linux
- A good or beginner knowledge of Docker
- An account on Broadcastify
- A frequency you are allowed to re-broadcast on Broadcastify

# Installation
You should have first installed a Linux OS on a dedicated computer or SBC (Raspberry Pi)

Once your OS is up and running, we need to make some changes for the RTL SDR to work properly.

```
sudo echo "blacklist r820t" >> /etc/modprobe.d/dvb-blacklist.conf
sudo echo "blacklist rtl2832" >> /etc/modprobe.d/dvb-blacklist.conf
sudo echo "blacklist rtl2830" >> /etc/modprobe.d/dvb-blacklist.conf
sudo echo "blacklist dvb_usb_rtl28xxu" >> /etc/modprobe.d/dvb-blacklist.conf
```

Once that is done we can proceed with the container.

```
cd /opt
git clone https://github.com/mzac/docker-rtl_sdr-broadcastify.git
cd /opt/docker-rtl_sdr-broadcastify
```
