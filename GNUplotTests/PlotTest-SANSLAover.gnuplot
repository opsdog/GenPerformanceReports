set term png size 2048,1024
set output 'PlotTest-SANSLAover.png'
set autoscale
set xtic auto
set ytic auto
unset xtic

set style line 1 lc rgb 'red' lw 2 pt 1
set style line 2 lc rgb 'blue' lw 2 pt 1
set style line 3 lc rgb '#202080' lw 2 pt 1

##  set logscale y

set title 'dougee1'

plot '/Volumes/External300/DBProgs/FSRServers/DougPerfData/Graph-SLA-SANserv/GPlotData/overview-cppsd01a0100-1427860800_1431835200.dat' using 2 title 'SAN Requests' with linespoint linestyle 2, \
     '/Volumes/External300/DBProgs/FSRServers/DougPerfData/Graph-SLA-SANserv/GPlotData/overview-cppsd01a0100-1427860800_1431835200.dat' using 3 title 'Under 25' with linespoint linestyle 3, \
     '/Volumes/External300/DBProgs/FSRServers/DougPerfData/Graph-SLA-SANserv/GPlotData/overview-cppsd01a0100-1427860800_1431835200.dat' using 4 title 'Over 25' with linespoint linestyle 1

reset
set term png size 2048,1024
set output 'PlotTest-SANSLAperc.png'
set autoscale
set xtic auto
set ytic auto
unset xtic

set style line 1 lc rgb '#a02020' lw 2 pt 1
set style line 2 lc rgb '#d02020' lw 2 pt 1

set yrange [0:105]

set title 'dougee2'

plot '/Volumes/External300/DBProgs/FSRServers/DougPerfData/Graph-SLA-SANserv/GPlotData/overview-cppsd01a0100-1427860800_1431835200.dat' using 5 title 'SLA Percent' with linespoint linestyle 1, \
     99 title '99%' with lines linestyle 2
