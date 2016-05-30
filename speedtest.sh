#!/bin/bash

# Internet Speed Long Term record
# -med-2016-05-26

#- Variables ------------------------------------------------------------------#
TMPFILE=$(mktemp)

SPEEDTEST_WEBDIR="/var/www/html/speedtest"
SPEEDTEST_DIR="/opt/speedtest"
SPEEDTEST="${SPEEDTEST_DIR}/speedtest-cli"
SPEEDTEST_PARAMETER="--simple --secure"

updown_rrd="speedtest_updown.rrd"
ping_rrd="speedtest_ping.rrd"

index=0
value=""

#- Environment Check ----------------------------------------------------------#

if [ ! -d "${SPEEDTEST_WEBDIR}" ]; then
   echo "Target directory (${SPEEDTEST_WEBDIR}) for Graph PNG dosn't exist."
   exit 1
fi

if [ ! -d "${SPEEDTEST_DIR}" ]; then
   echo "Directory (${SPEEDTEST_DIR}) for RRD Files dosn't exist."
   exit 1
fi

if [ ! -f "${SPEEDTEST}" ]; then
   echo "Speedtest-CLI dosn't exist."
   exit 1
fi

if [ ! -f "${SPEEDTEST_DIR}/${updown_rrd}" ]; then
   echo "Speedtest Up-/Download RRD dosn't exist."
   exit 1
fi

if [ ! -f "${SPEEDTEST_DIR}/${ping_rrd}" ]; then
   echo "Speedtest Ping RRD dosn't exist."
   exit 1
fi


#- Run Speedtest --------------------------------------------------------------#

${SPEEDTEST} ${SPEEDTEST_PARAMETER} > ${TMPFILE}

while read i; do
  index=$(( ${index} +1 ))
  value[${index}]=`echo ${i} | awk '{print $2}'`
done < ${TMPFILE}

rm -rf ${TMPFILE}

rrdtool update ${SPEEDTEST_DIR}/${updown_rrd} N:${value[3]}:${value[2]}
rrdtool update ${SPEEDTEST_DIR}/${ping_rrd} N:${value[1]}

#- Create Download Graph ------------------------------------------------------#

rrdtool graph ${SPEEDTEST_WEBDIR}/download_8h.png -a PNG \
--title="Speedtest Download - last 8 hours" \
--start -28800 \
--vertical-label "Mbit/s" \
'DEF:probe1=${SPEEDTEST_DIR}/${updown_rrd}:download:AVERAGE' \
'AREA:probe1#009bc2:Download Speed' \
'GPRINT:probe1:LAST:last metering\: %2.1lf'" Mbit/s"

rrdtool graph ${SPEEDTEST_WEBDIR}/download_36h.png -a PNG \
--title="Speedtest Download - last 36 hours" \
--start -129600 \
--vertical-label "Mbit/s" \
'DEF:probe1=${SPEEDTEST_DIR}/${updown_rrd}:download:AVERAGE' \
'AREA:probe1#009bc2:Download Speed' \
'GPRINT:probe1:LAST:last metering\: %2.1lf'" Mbit/s"

rrdtool graph ${SPEEDTEST_WEBDIR}/download_1w.png -a PNG \
--title="Speedtest Download - last week" \
--start -1w \
--vertical-label "Mbit/s" \
'DEF:probe1=${SPEEDTEST_DIR}/${updown_rrd}:download:AVERAGE' \
'AREA:probe1#009bc2:Download Speed' \
'GPRINT:probe1:LAST:last metering\: %2.1lf'" Mbit/s"

rrdtool graph ${SPEEDTEST_WEBDIR}/download_4w.png -a PNG \
--title="Speedtest Download - last 4 weeks" \
--start -4w \
--vertical-label "Mbit/s" \
'DEF:probe1=${SPEEDTEST_DIR}/${updown_rrd}:download:AVERAGE' \
'AREA:probe1#009bc2:Download Speed' \
'GPRINT:probe1:LAST:last metering\: %2.1lf'" Mbit/s"

#- Create Upload Graph --------------------------------------------------------#

rrdtool graph ${SPEEDTEST_WEBDIR}/upload_8h.png -a PNG \
--title="Speedtest Upload - last 8 hours" \
--start -28800 \
--vertical-label "Mbit/s" \
'DEF:probe1=${SPEEDTEST_DIR}/${updown_rrd}:upload:AVERAGE' \
'AREA:probe1#009bc2:Upload Speed' \
'GPRINT:probe1:LAST:last metering\: %2.1lf'" Mbit/s"

rrdtool graph ${SPEEDTEST_WEBDIR}upload_36h.png -a PNG \
--title="Speedtest Upload - last 36 hours" \
--start -129600 \
--vertical-label "Mbit/s" \
'DEF:probe1=${SPEEDTEST_DIR}/${updown_rrd}:upload:AVERAGE' \
'AREA:probe1#009bc2:Upload Speed' \
'GPRINT:probe1:LAST:last metering\: %2.1lf'" Mbit/s"

rrdtool graph ${SPEEDTEST_WEBDIR}/upload_1w.png -a PNG \
--title="Speedtest Upload - last week" \
--start -1w \
--vertical-label "Mbit/s" \
'DEF:probe1=${SPEEDTEST_DIR}/${updown_rrd}:upload:AVERAGE' \
'AREA:probe1#009bc2:Upload Speed' \
'GPRINT:probe1:LAST:last metering\: %2.1lf'" Mbit/s"

rrdtool graph ${SPEEDTEST_WEBDIR}/upload_4w.png -a PNG \
--title="Speedtest Upload - last 4 weeks" \
--start -4w \
--vertical-label "Mbit/s" \
'DEF:probe1=${SPEEDTEST_DIR}/${updown_rrd}:upload:AVERAGE' \
'AREA:probe1#009bc2:Upload Speed' \
'GPRINT:probe1:LAST:last metering\: %2.1lf'" Mbit/s"

#- Create Ping Graph ----------------------------------------------------------#

rrdtool graph ${SPEEDTEST_WEBDIR}/ping_8h.png -a PNG \
--title="Speedtest Ping - last 8 hours" \
--start -28800 \
--vertical-label "ms" \
'DEF:probe1=${SPEEDTEST_DIR}/${ping_rrd}:ping:AVERAGE' \
'AREA:probe1#009bc2:Ping in ms' \
'GPRINT:probe1:LAST:last metering\: %2.1lf'" ms"

rrdtool graph ${SPEEDTEST_WEBDIR}/ping_36h.png -a PNG \
--title="Speedtest Ping - last 36 hours" \
--start -129600 \
--vertical-label "ms" \
'DEF:probe1=${SPEEDTEST_DIR}/${ping_rrd}:ping:AVERAGE' \
'AREA:probe1#009bc2:Ping in ms' \
'GPRINT:probe1:LAST:last metering\: %2.1lf'" ms"

rrdtool graph ${SPEEDTEST_WEBDIR}/ping_1w.png -a PNG \
--title="Speedtest Ping - last week" \
--start -1w \
--vertical-label "ms" \
'DEF:probe1=${SPEEDTEST_DIR}/${ping_rrd}:ping:AVERAGE' \
'AREA:probe1#009bc2:Ping in ms' \
'GPRINT:probe1:LAST:last metering\: %2.1lf'" ms"

rrdtool graph ${SPEEDTEST_WEBDIR}/ping_4w.png -a PNG \
--title="Speedtest Ping - last 4 weeks" \
--start -4w \
--vertical-label "ms" \
'DEF:probe1=${SPEEDTEST_DIR}/${ping_rrd}:ping:AVERAGE' \
'AREA:probe1#009bc2:Ping in ms' \
'GPRINT:probe1:LAST:last metering\: %2.1lf'" ms"

#------------------------------------------------------------------------------#

exit 0

#------------------------------------------------------------------------------#

