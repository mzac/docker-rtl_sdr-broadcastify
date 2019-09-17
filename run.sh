#!/bin/sh

FREQUENCY="461.4M"

/usr/local/bin/rtl_fm -d 0 -M fm -f $FREQUENCY -p 69 -l 65 -g 50 -t 2 -E pad -s 12k |
/usr/bin/lame -r -s 12 --resample 22.05 -m m -b 16 --cbr --lowpass 4 - - |
/usr/bin/ezstream -c /etc/ezstream_bcfy.xml
