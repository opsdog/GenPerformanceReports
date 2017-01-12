
##
##  functions for producing statistics with GNU Plot
##

GNUStats_MakeLinearTrend() {

  ##  echo "    $GFileBase"
  ##  echo "    ${WorkDir}/${PlotScript}"
  ##  echo "    $DataFileTwoColPath"
  ##  echo "    $DataFileOneColPath"
  ##  echo "    $GNUPlotLinearTrendTitle"

  ##  these plots do not get the common header - these are for reference

  ##  echo "set term png size ${resX},${resY}" > ${WorkDir}/${PlotScript}
  ##  echo "set output \"${GFileBase}-${resX}x${resY}.png\"" >> ${WorkDir}/${PlotScript}
  ##  echo "set autoscale" >> ${WorkDir}/${PlotScript}
  ##  echo "unset log" >> ${WorkDir}/${PlotScript}
  ##  echo "unset label" >> ${WorkDir}/${PlotScript}
  ##  echo "unset object" >> ${WorkDir}/${PlotScript}
  ##  echo "set xtic auto" >> ${WorkDir}/${PlotScript}
  ##  echo "set ytic auto" >> ${WorkDir}/${PlotScript}
  ##  echo "set key off" >> ${WorkDir}/${PlotScript}
  ##  echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> ${WorkDir}/${PlotScript}
  ##  echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> ${WorkDir}/${PlotScript}
  ##  echo "set style line 3 lc rgb \"#22ff44\" lw 2 pt 1" >> ${WorkDir}/${PlotScript}
  ##  echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> ${WorkDir}/${PlotScript}
  ##  echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> ${WorkDir}/${PlotScript}
  ##  echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> ${WorkDir}/${PlotScript}
  ##  echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> ${WorkDir}/${PlotScript}
  ##  echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> ${WorkDir}/${PlotScript}
  ##  echo >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}
  echo "stats '${DataFileTwoColPath}'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "min_data_y = STATS_min_y" >> ${WorkDir}/${PlotScript}
  echo "max_data_y = STATS_max_y" >> ${WorkDir}/${PlotScript}
  echo "mean_data_y = STATS_mean_y" >> ${WorkDir}/${PlotScript}
  echo "median_data_y = STATS_median_y" >> ${WorkDir}/${PlotScript}
  echo "stddev_data_y = STATS_stddev_y" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "flin(x) = alin*x+blin" >> ${WorkDir}/${PlotScript}
  echo "fmean(x) = mean_y" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "fit flin(x) '${DataFileOneColPath}' via alin,blin" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "plot flin(x) with lines linestyle 2 notitle" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "min_flin_y = GPVAL_DATA_Y_MIN" >> ${WorkDir}/${PlotScript}
  echo "max_flin_y = GPVAL_DATA_Y_MAX" >> ${WorkDir}/${PlotScript}
  echo "min_flin_x = GPVAL_DATA_X_MIN" >> ${WorkDir}/${PlotScript}
  echo "max_flin_x = GPVAL_DATA_X_MAX" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "show variable all"  >> ${WorkDir}/${PlotScript}

  rm -f tmp_gplotlin_fit 2>/dev/null
  gnuplot < ${WorkDir}/${PlotScript} 2>tmp_gplotlin_fit

  GNUPlotLinearTrend_Slope=`cat tmp_gplotlin_fit | awk ' $1 == "alin" { print }' | tail -1 | awk '{ print $NF }'`
  GNUPlotLinearTrend_Mean=`grep STATS_mean_y tmp_gplotlin_fit | awk '{ print $NF }'`
  GNUPlotLinearTrend_Median=`grep STATS_median_y tmp_gplotlin_fit | awk '{ print $NF }'`
  GNUPlotLinearTrend_MIN=`grep STATS_min_y tmp_gplotlin_fit | awk '{ print $NF }'`
  GNUPlotLinearTrend_MAX=`grep STATS_max_y tmp_gplotlin_fit | awk '{ print $NF }'`

  ##  echo "    $GNUPlotLinearTrend_Slope"
  ##  echo "    $GNUPlotLinearTrend_Mean"
  ##  echo "    $GNUPlotLinearTrend_Median"
  ##  echo "    $GNUPlotLinearTrend_MIN"
  ##  echo "    $GNUPlotLinearTrend_MAX"

  echo >> ${WorkDir}/${PlotScript}
  echo "reset" >> ${WorkDir}/${PlotScript}
  echo "set term png size ${resX},${resY}" >> ${WorkDir}/${PlotScript}
  echo "set output '${GFileBase}-${resX}x${resY}.png'" >> ${WorkDir}/${PlotScript}
  echo "set autoscale" >> ${WorkDir}/${PlotScript}
  echo "set style line 1 lc rgb 'red' lw 2 pt 1" >> ${WorkDir}/${PlotScript}
  echo "set style line 2 lc rgb 'blue' lw 2 pt 1" >> ${WorkDir}/${PlotScript}
  echo "set label sprintf('Average: %f', mean_data_y) at screen 0.4,0.985 front textcolor linestyle 2 font 'Georgia Bold,14'" >> ${WorkDir}/${PlotScript}
  echo "set label sprintf('Median: %f', median_data_y) at screen 0.5,0.985 front textcolor linestyle 2 font 'Georgia Bold,14'" >> ${WorkDir}/${PlotScript}
  echo "set label sprintf('Linear Trend from %f to %f', min_flin_y, max_flin_y)  at screen 0.6,0.988 front textcolor linestyle 1 font 'Georgia Bold,14'" >> ${WorkDir}/${PlotScript}
  echo "set label            sprintf('Rate of Change is %.2e', alin)             at screen 0.6,0.981 front textcolor linestyle 1 font 'Georgia Bold,14'" >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${GNUPlotLinearTrendTitle}'" >> ${WorkDir}/${PlotScript}

  echo "set xtics format ''" >> ${WorkDir}/${PlotScript}
  echo "set origin 0.01,0.01" >> ${WorkDir}/${PlotScript}
  echo "set size 0.98,0.97" >> ${WorkDir}/${PlotScript}
  echo "plot flin(x) with lines linestyle 1 notitle" >> ${WorkDir}/${PlotScript}
  echo "show variable all" >> ${WorkDir}/${PlotScript}



}  ##  end of function GNUStats-MakeLinearTrend