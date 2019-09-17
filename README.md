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

First, install docker:
```
curl -sSL https://get.docker.com | sh
```

Once docker is installed, verify that it is working:
```
docker info
```

Once your OS and docker is up and running, we need to make some changes for the RTL SDR to work properly.

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
**IMPORTANT:** Now you'll want to edit the two files:
- ezstream_bcfy.xml / Edit the URL, mount and password, without this you will not be able to connect to Broadcastify
- run.sh / Edit the frequency and any other settings you'd like

Now we are ready to build the container.  This may take a while:
```
docker build -t "docker-rtl_sdr-broadcastify:latest" .
```

If the container builds with no errors, you can now test to make sure it works:
```
docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb docker-rtl_sdr-broadcastify:latest /opt/broadcastify/run.sh
```

You should get an output like this:
```
Found 1 device(s):
  0:  Realtek, RTL2838UHIDIR, SN: 00000001

Using device 0: Generic RTL2832U OEM
Found Rafael Micro R820T tuner
ezstream: Connected to http://audio#.broadcastify.com:80/your_mount
ezstream: Streaming from standard input
Tuner gain set to 49.60 dB.
Tuner error set to 69 ppm.
Tuned to 412000000 Hz.
Oversampling input by: 84x.
Oversampling output by: 1x.
Buffer size: 8.13ms
Exact sample rate is: 1008000.009613 Hz
Sampling at 1008000 S/s.
Output at 12000 Hz.

```

If all looks good, do a CTRL-C and start up the real container and check the logs:
```
docker run -d --privileged -v /dev/bus/usb:/dev/bus/usb --restart always --name broadcastify docker-rtl_sdr-broadcastify:latest
docker logs -f broadcastify
```
