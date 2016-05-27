Speedtest Logterm outline
=========================

This small script make a long term trace the Internet speed (Ping, Up- and Downlink), based on the [speedtest-cli] (https://github.com/sivel/speedtest-cli).

 * **create_rrd.sh**: creates the necessary RRD Files.
 * **speedtest.html**: to display the graph
 * **speedtest.sh**:
   * make the speedtest
   * update the rrd files
   * creates the graph
