#!/bin/sh

RTL_DEVICE="0"
RTL_MODE="fm"
RTL_FREQ="461.4M"
RTL_PPM="69"
RTL_LEVEL="25"
RTL_GAIN="50"
RTL_DELAY="2"

EZSTREAM_CONFIG="/etc/ezstream_bcfy.xml"

/usr/local/bin/rtl_fm -d $RTL_DEVICE -M $RTL_MODE -f $RTL_FREQ -p $RTL_PPM -l $RTL_LEVEL -g $RTL_GAIN -t $RTL_DELAY -E pad -s 12k | \
/usr/bin/lame -r -s 12 --resample 22.05 -m m -b 16 --cbr --lowpass 4 - - | \
/usr/bin/ezstream -c $EZSTREAM_CONFIG

