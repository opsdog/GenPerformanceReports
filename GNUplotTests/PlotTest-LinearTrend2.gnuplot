
##
##  uses raw LUN wait time as example
##

##
##  first runs gnuplot's stats function over the 2 column data
##

stats '/Volumes/External300/DBProgs/FSRServers/DougPerfData/Graph-LongLine/GPlotData/iostat_timewsvct-cppsd09a0100-201505161717_201505221124.dat'

##  capture some values

min_data_y = STATS_min_y
max_data_y = STATS_max_y

mean_data_y = STATS_mean_y
median_data_y = STATS_median_y
stddev_data_y = STATS_stddev_y

##  set logscale y

##
##  set fit functions
##

fpow(x) = apow*x**bpow    ##  takes too long for iostat_wsvct (raw service times)
flin(x) = alin*x+blin     ##  works for iostat_wsvct (raw service times)
fmean(x) = mean_y         ##  finds the mean, very slowly

##
##  curve fit and grab some values
##

fit flin(x) '/Volumes/External300/DBProgs/FSRServers/DougPerfData/Graph-LongLine/GPlotData/iostat_wsvct-cppsd09a0100-201505161717_201505221124.dat' via alin,blin

##  throw-away plots to get min and max X and Y - not working
plot flin(x) with lines linestyle 2 notitle

min_flin_y = GPVAL_DATA_Y_MIN
max_flin_y = GPVAL_DATA_Y_MAX
min_flin_x = GPVAL_DATA_X_MIN
max_flin_x = GPVAL_DATA_X_MAX

##  reset
##  plot mean_data_y with lines linestyle 1 notitle

##  min_mean_x = GPVAL_DATA_X_MIN
##  max_mean_x = GPVAL_DATA_X_MAX

##  this determines the mean by curve fitting - much slower than stats
##  fit fmean(x) '/Volumes/External300/DBProgs/FSRServers/DougPerfData/Graph-LongLine/GPlotData/iostat_wsvct-cppsd09a0100-201505161717_201505221124.dat' via mean_y


##
##  start the real plotting
##

reset

set term png size 8192,4096
##  set term png size 1024,780
set output "PlotTest-LinearTrend2.png"
set autoscale
##  unset log
##  unset label
##  unset object
##  set xtic auto
##  set ytic auto
##  set key off
set style line 1 lc rgb "red" lw 2 pt 1
set style line 2 lc rgb "blue" lw 2 pt 1
set style line 3 lc rgb "#22ff44" lw 2 pt 1
set style line 4 lc rgb "magenta" lw 2 pt 1
set style line 5 lc rgb "plum" lw 2 pt 1
set style line 6 lc rgb "orange" lw 2 pt 1
set style line 7 lc rgb "purple" lw 2 pt 1
set style line 8 lc rgb "brown" lw 2 pt 1

##  figure out the true X and Y ranges

##  max_range_y = ( max_flin_y > mean_data_y ? max_flin_y : mean_data_y)
##  min_range_y = ( min_flin_y < mean_data_y ? max_flin_y : mean_data_y)

##  max_range_x = ( max_flin_x > max_mean_x ? max_flin_x : max_mean_x)
##  min_range_x = ( min_flin_x < min_mean_x ? min_flin_x : min_mean_x)

##  show variable min_range_x
##  show variable max_range_x

##  show variable min_range_y
##  show variable max_range_y


##  set the labels...
##  placement is based on an 8192x4096 image

##  these come from stats:
set label sprintf('Average: %f', mean_data_y) at screen 0.4,0.985 front textcolor linestyle 2 font "Georgia Bold,14"

set label sprintf('Median: %f', median_data_y) at screen 0.5,0.985 front textcolor linestyle 2 font "Georgia Bold,14"

##  these come from flin(x)
set label sprintf('Linear Trend from %f to %f', min_flin_y, max_flin_y)  at screen 0.6,0.988 front textcolor linestyle 1 font "Georgia Bold,14"
set label            sprintf('Rate of Change is %.2e', alin)             at screen 0.6,0.981 front textcolor linestyle 1 font "Georgia Bold,14"


set multiplot title 'cppsd09a0100 - 201505161717 to 201505221124 - Solaris Weighted Average Service Times (ms)'

set xtics format ""
set origin 0.01,0.01
set size 0.98,0.97
##  set xrange [min_range_x:max_range_x]
##  set yrange [min_range_y:max_range_y]
##  set y2range [min_fit_y:max_fit_y]



##  plot '/Volumes/External300/DBProgs/FSRServers/DougPerfData/Graph-LongLine/GPlotData/iostat_timewsvct-cppsd09a0100-201505161717_201505221124.dat' using 1:2 with linespoints linestyle 1 title 'data points' axes x1y1

##  plot the exponential fit curve
##  plot fpow(x) using 1:2 with lines linestyle 2 title sprintf('power fit curve f(x) = %.2e·x^{%.2e}', apow, bpow) axes x1y2

##  plot the mean value from the fit function
##  plot fmean(x) with lines linestyle 1 title sprintf('fit curve f(x) = mean_y') 

##  plot the direct mean value from stats...
##  plot mean_data_y with lines linestyle 1 notitle

##  plot the linear fit function
plot flin(x) with lines linestyle 1 notitle




show variable all

##
##  keep for reference...
##

##  plot mean_data_y with lines linestyle 1 title sprintf('Mean:  %.2e', mean_data_y)
##  plot flin(x) with lines linestyle 2 title sprintf('fit curve f(x) = %.2e · x + %.2e', a, b) 
