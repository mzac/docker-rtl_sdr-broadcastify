# docker-rtl_sdr-broadcastify
Docker container for streaming RTL SDR to Broadcastify

# Introduction
This docker container will help you run a Broadcastify stream.  I did this to make my life easier when my Raspberry Pi died on me and I
I wanted a quick way to recover.  Note this Dockerfile should work on both Intel and ARM archs however you will have to build the container
yourself since it includes the built in config files.  Optionally, you could mount the two files in a volume.

# Reference
This container was based on the instructions from Broadcastify/Radioreference:
- https://wiki.radioreference.com/index.php/Raspberry_Pi_RTL-SDR_Broadcastify
