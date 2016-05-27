#!/bin/bash

# Create RRD for Internet Speed
# -med-2016-05-26

# Trace every 15 Minutes (900)
# Graph for:
#   -  8h (32)
#   - 36h (144)
#   -  1W (672)
#   -  4W (2688)

#- Program --------------------------------------------------------------------#

rrdtool create speedtest_updown.rrd \
        --step 900 \
        DS:upload:GAUGE:1800:0:30 \
        DS:download:GAUGE:1800:0:300 \
        RRA:AVERAGE:0.5:1:32 \
        RRA:AVERAGE:0.5:1:144 \
        RRA:MIN:0.5:1:144 \
        RRA:MAX:0.5:1:144 \
        RRA:AVERAGE:0.5:4:672 \
        RRA:AVERAGE:0.5:4:2688

rrdtool create speedtest_ping.rrd \
        --step 900 \
        DS:ping:GAUGE:1800:0:1000 \
        RRA:AVERAGE:0.5:1:32 \
        RRA:AVERAGE:0.5:1:144 \
        RRA:MIN:0.5:1:144 \
        RRA:MAX:0.5:1:144 \
        RRA:AVERAGE:0.5:4:672 \
        RRA:AVERAGE:0.5:4:2688

exit 0

#------------------------------------------------------------------------------#
