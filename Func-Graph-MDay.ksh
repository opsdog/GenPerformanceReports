
##
##  functions for the Graph-SingServ-MDayStacks.ksh script
##

##
##  in theory there are 5760 sample periods in a 24 hour day at 15 seconds
##

Make_Data_local_md() {

  echo
  echo "Creating data files for $NumRanges ranges..."

  exec 4<tmp_mday_ranges
  while read -u4 MakeDataEpochBegin MakeDataEpochEnd
  do
    ##  echo "  $ServerName ($ServerID) $MakeDataEpochBegin $MakeDataEpochEnd"
    printf "  %s (%s) %s %s" $ServerName $ServerID $MakeDataEpochBegin $MakeDataEpochEnd

    StartEpoch=$MakeDataEpochBegin
    EndEpoch=$MakeDataEpochEnd
    StartTime=`${ProgPrefix}/FromEpoch $StartEpoch -s`
    EndTime=`${ProgPrefix}/FromEpoch $EndEpoch -s `

    ${ProgPrefix}/NewQuery fsr "select esttime, swap from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_swap-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, free from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_free-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, sr from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_sr-${ServerName}-${StartTime}_${EndTime}.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, us from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_cpuUser-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, sys from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_cpuSys-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, (us + sys) from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_cpuTOT-${ServerName}-${StartTime}_${EndTime}.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, rq from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_qR-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, bq from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_qB-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wq from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_qW-${ServerName}-${StartTime}_${EndTime}.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, iin from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_intr-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, sy from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_syscall-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cs from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_cswitch-${ServerName}-${StartTime}_${EndTime}.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, sum(ipack) from netstat where serverid = ${ServerID} and esttime in (select esttime from netstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}) group by esttime order by esttime" > ${PlotDataDir}/netstat_ipackSUM-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, sum(opack) from netstat where serverid = ${ServerID} and esttime in (select esttime from netstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}) group by esttime order by esttime" > ${PlotDataDir}/netstat_opackSUM-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, sum(ierrs) from netstat where serverid = ${ServerID} and esttime in (select esttime from netstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}) group by esttime order by esttime" > ${PlotDataDir}/netstat_ierrsSUM-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, sum(oerrs) from netstat where serverid = ${ServerID} and esttime in (select esttime from netstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}) group by esttime order by esttime" > ${PlotDataDir}/netstat_oerrsSUM-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, sum(ocoll) from netstat where serverid = ${ServerID} and esttime in (select esttime from netstat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch}) group by esttime order by esttime" > ${PlotDataDir}/netstat_ocollSUM-${ServerName}-${StartTime}_${EndTime}.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, readops_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcalc_rops-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writops_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcalc_wops-${ServerName}-${StartTime}_${EndTime}.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, readblk_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcalc_rblocks-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writblk_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcalc_wblocks-${ServerName}-${StartTime}_${EndTime}.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, servtime from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcalc_servtime-${ServerName}-${StartTime}_${EndTime}.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, (readms + writms) from vxstat where vxtype = 'dm' and serverid = $ServerID and ( readms != 0.0 or writms != 0.0 ) and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, readms" > ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat
    touch ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-${StartTime}_${EndTime}_dm.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, readms_avg from vxcalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcalc_readmsavg-${ServerName}-${StartTime}_${EndTime}_dm.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, readms_max from vxcalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcalc_readmsmax-${ServerName}-${StartTime}_${EndTime}_dm.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, writms_avg from vxcalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcalc_writmsavg-${ServerName}-${StartTime}_${EndTime}_dm.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, writms_max from vxcalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxcalc_writmsmax-${ServerName}-${StartTime}_${EndTime}_dm.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, rs_sum from iocalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_rops-${ServerName}-${StartTime}_${EndTime}_dm.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, ws_sum from iocalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_wops-${ServerName}-${StartTime}_${EndTime}_dm.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, krs_sum from iocalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_kread-${ServerName}-${StartTime}_${EndTime}_dm.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, kws_sum from iocalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_kwrite-${ServerName}-${StartTime}_${EndTime}_dm.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, (wait_sum + actv_sum) from iocalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_transtot-${ServerName}-${StartTime}_${EndTime}_dm.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, actv_sum from iocalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_transact-${ServerName}-${StartTime}_${EndTime}_dm.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wait_sum from iocalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_transwait-${ServerName}-${StartTime}_${EndTime}_dm.dat

    ${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg_a from iocalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_servweighted-${ServerName}-${StartTime}_${EndTime}_dm.dat
  ##${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg_a from iocalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_waitweighted-${ServerName}-${StartTime}_${EndTime}_dm.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg_a from iocalc where serverid = $ServerID and esttime between ${StartEpoch} and ${EndEpoch} and wsvct_avg_a > 0 order by esttime" > ${PlotDataDir}/iocalc_waitweighted-${ServerName}-${StartTime}_${EndTime}_dm.dat

    printf " - RAW LUN data"

    ${ProgPrefix}/NewQuery fsr "select esttime, asvct from iostat where serverid = $ServerID and ( devtype = 1 or devtype = 2 ) and esttime between ${StartEpoch} and ${EndEpoch} and asvct > 0.0 order by esttime" > ${PlotDataDir}/iostat_rawserv-${ServerName}-${StartTime}_${EndTime}_dm.dat
    wc -l ${PlotDataDir}/iostat_rawserv-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $1 }' | read NumPoints
    printf " - %s" $NumPoints
    ${ProgPrefix}/NewQuery fsr "select esttime, wsvct from iostat where serverid = $ServerID and ( devtype = 1 or devtype = 2 ) and esttime between ${StartEpoch} and ${EndEpoch} and wsvct > 0.0 order by esttime" > ${PlotDataDir}/iostat_rawwait-${ServerName}-${StartTime}_${EndTime}_dm.dat
    wc -l ${PlotDataDir}/iostat_rawwait-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $1 }' | read NumPoints
    printf " - %s" $NumPoints
    ${ProgPrefix}/NewQuery fsr "select esttime, (actv + wait) from iostat where serverid = $ServerID and ( devtype = 1 or devtype = 2 ) and esttime between ${StartEpoch} and ${EndEpoch} and ( actv > 0.0 or wait > 0.0 ) order by esttime" > ${PlotDataDir}/iostat_rawtrans-${ServerName}-${StartTime}_${EndTime}_dm.dat
    wc -l ${PlotDataDir}/iostat_rawtrans-${ServerName}-${StartTime}_${EndTime}_dm.dat | awk '{ print $1 }' | read NumPoints
    printf " - %s" $NumPoints


    printf "\n"
  done  ##  for each range
  exec 4<&-

  echo "Combining ranges into trend data files..."

  for StatFamily in vmstat netstat vxcalc vxstat iocalc iostat
  do
    ##  echo "  $StatFamily"
    for StatType in `ls Graph-MDayStacks/GPlotData/${StatFamily}*${ServerName}* | awk -F \- '{ print $2 }' | sort -u | awk -F \/ '{ print $3 }' | awk -F \_ '{ print $2 }'`
    do
      ##  echo "    $StatType"
      BaseName=`ls -l ${PlotDataDir}/${StatFamily}_${StatType}*${ServerName}* 2>/dev/null | tail -1 | awk '{ print $NF }' | awk -F\- '{ print $1"-"$2 }'`
      BaseFile=`basename $BaseName`
      ##  echo "      $BaseName --> $BaseFile"
      cat ${BaseName}-${ServerName}* > ${PlotDataDir}/${BaseFile}-ALL-${ServerName}.dat
      cat ${PlotDataDir}/${BaseFile}-ALL-${ServerName}.dat | awk '{ print $2 }' > ${PlotDataDir}/${BaseFile}stats-ALL-${ServerName}.dat
    done  ## for each stat type
  done  ##  for each stat family

  echo
}  ##  end of function Make_Data_local_md

##
##

Mkplot_swap() {

  echo "Creating swap plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vmstatSwap"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vmstat_swap-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_swap-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_swap-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Free Swap (KBytes)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Free Swap (kBytes)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  ##
  ##  create the trend plot
  ##

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/vmstat_swap-ALL-${ServerName}.dat
  DataFileOneColPath=${PlotDataDir}/vmstat_swapstats-ALL-${ServerName}.dat

  echo "  Creating all data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1200_vmstatswapall"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  touch $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  echo "set term png size $resX,$resY" > ${PlotScript}
  echo "set output '${GFileBase}-${resX}x${resY}.png'" >> ${PlotScript}
  echo "set autoscale" >> ${PlotScript}
  echo "set style line 1 lc rgb 'red' lw 2 pt 1" >> ${PlotScript}
  echo "set style line 2 lc rgb 'blue' lw 2 pt 1" >> ${PlotScript}
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} - Free Swap (kBytes)'" >> ${PlotScript}
  echo "set xtics format ''"  >> ${PlotScript}
  echo "set origin 0.${originX},0.${originY}" >> ${PlotScript}
  echo "set size 0.${sizeX},0.${sizeY}" >> ${PlotScript}
  echo "plot '${DataFileTwoColPath}' using 1:2 notitle with linespoints linestyle 1" >> ${PlotScript}

  ##  add all data plot to index.html

  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">All Data</a> - " >> ${WebDir}/index.html

  ##
  ##

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1210_vmstatswaptrend"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  touch $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Free Swap Trend (kBytes)"

  origX=$resX
  origY=$resY
  resX=8192
  resY=4096

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  echo "<a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>&nbsp;&nbsp;Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html

  resX=$origX
  resY=$origY

  ##
  ##  end trend code
  ##

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of function Mkplot_swap

##
##

Mkplot_free() {

  echo "Creating free plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vmstatFree"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vmstat_free-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_free-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_free-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Free Memory (KBytes)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Free Memory (kBytes)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  ##
  ##  create the trend plot
  ##

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/vmstat_free-ALL-${ServerName}.dat
  DataFileOneColPath=${PlotDataDir}/vmstat_freestats-ALL-${ServerName}.dat

  echo "  Creating all data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1200_vmstatfreeall"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  touch $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  echo "set term png size $resX,$resY" > ${PlotScript}
  echo "set output '${GFileBase}-${resX}x${resY}.png'" >> ${PlotScript}
  echo "set autoscale" >> ${PlotScript}
  echo "set style line 1 lc rgb 'red' lw 2 pt 1" >> ${PlotScript}
  echo "set style line 2 lc rgb 'blue' lw 2 pt 1" >> ${PlotScript}
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} - Free Memory (kBytes)'" >> ${PlotScript}
  echo "set xtics format ''"  >> ${PlotScript}
  echo "set origin 0.${originX},0.${originY}" >> ${PlotScript}
  echo "set size 0.${sizeX},0.${sizeY}" >> ${PlotScript}
  echo "plot '${DataFileTwoColPath}' using 1:2 notitle with linespoints linestyle 1" >> ${PlotScript}

  ##  add all data plot to index.html

  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">All Data</a> - " >> ${WebDir}/index.html

  ##
  ##

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1210_vmstatfreetrend"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  touch $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Free Memory Trend (kBytes)"

  origX=$resX
  origY=$resY
  resX=8192
  resY=4096

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  echo "<a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>&nbsp;&nbsp;Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html

  resX=$origX
  resY=$origY

  ##
  ##  end trend code
  ##

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of function Mkplot_free

##
##

Mkplot_sr() {

  echo "Creating scan rate plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vmstatSR"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vmstat_sr-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_sr-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  RealSRMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_sr-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Scan Rate (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Scan Rate (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealSRMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of function Mkplot_sr

##
##

Mkplot_cpuTOT() {

  echo "Creating total CPU plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vmstatcpuTOT"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vmstat_cpuTOT-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_cpuTOT-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_cpuTOT-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Total CPU Use (Percent)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Total CPU Use (Percent)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of function Mkplot_cpuTOT

##
##

Mkplot_kqueuesR() {

  echo "Creating run queue plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vmstatqueueR"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vmstat_qR-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_qR-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_qR-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Run Queue (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Run Queue (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of function Mkplot_kqueuesR

##
##

Mkplot_kqueuesB() {

  echo "Creating blocked queue plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vmstatqueueB"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vmstat_qB-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_qB-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_qB-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Blocked Queue (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Blocked Queue (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of function Mkplot_kqueuesB


##
##

Mkplot_kqueuesW() {

  echo "Creating wait queue plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vmstatqueueW"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vmstat_qW-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_qW-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_qW-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Wait Queue (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Wait Queue (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of function Mkplot_kqueuesW

##
##

Mkplot_server_syscalls() {

  ##
  ##  interrupts
  ##

  echo "Creating system-wide interrupts plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vmstatsysINT"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vmstat_intr-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_intr-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_intr-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - System Wide Interrupts (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">System Wide Interrupts (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  system calls
  ##

  echo "Creating system-wide system calls plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vmstatsysSYSCALL"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vmstat_syscall-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_syscall-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_syscall-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - System Wide System Calls (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">System Wide System Calls (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  context switches
  ##

  echo "Creating system-wide context switches plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vmstatsysCSWITCH"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vmstat_cswitch-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vmstat_cswitch-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vmstat_cswitch-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - System Wide Context Switches (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">System Wide Context Switches (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of function Mkplot_server_syscalls


##
##

Mkplot_netsum() {

  ##
  ##  input packets
  ##

  echo "Creating network input packets plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_netstatsumIPACK"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/netstat_ipackSUM-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/netstat_ipackSUM-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/netstat_ipackSUM-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Network Input Packets (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Network Input Packets (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  ##
  ##  input errors
  ##

  echo "Creating network input errors plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_netstatsumIERRS"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/netstat_ierrsSUM-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/netstat_ierrsSUM-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/netstat_ierrsSUM-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Network Input Errors (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Network Input Errors (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  ##
  ##  output packets
  ##

  echo "Creating network output packets plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_netstatsumOPACK"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/netstat_opackSUM-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/netstat_opackSUM-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/netstat_opackSUM-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Network Output Packets (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Network Output Packets (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  ##
  ##  output errors
  ##

  echo "Creating network output errors plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_netstatsumOERRS"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/netstat_oerrsSUM-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/netstat_oerrsSUM-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/netstat_oerrsSUM-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Network Output Errors (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Network Output Errors (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  ##
  ##  output collisions
  ##

  echo "Creating network output collisions plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_netstatsumOCOLL"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/netstat_ocollSUM-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/netstat_ocollSUM-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/netstat_ocollSUM-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Network Output Collisions (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Network Output Collisions (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

}  ##  end of function Mkplot_netsum


##
##

Mkplot_vxops() {

  ##
  ##  read operations
  ##

  echo "Creating Veritas read ops plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vxcalcopsREAD"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vxcalc_rops-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxcalc_rops-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vxcalc_rops-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Veritas Read Operations (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas Read Operations (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  ##
  ##  write operations
  ##

  echo "Creating Veritas write ops plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vxcalcopsWRITE"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vxcalc_wops-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxcalc_wops-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vxcalc_wops-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Veritas Write Operations (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas Write Operations (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

}  ##  end of function Mkplot_vxops

##
##

Mkplot_vxblocks() {

  ##
  ##  read blocks
  ##

  echo "Creating Veritas read blocks plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vxcalcblocksREAD"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vxcalc_rblocks-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxcalc_rblocks-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vxcalc_rblocks-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Veritas Read Blocks (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas Read Blocks (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  ##
  ##  write blocks
  ##

  echo "Creating Veritas write blocks plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vxcalcblocksWRITE"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vxcalc_wblocks-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxcalc_wblocks-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vxcalc_wblocks-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Veritas Write Blocks (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas Write Blocks (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

}  ##  end of function Mkplot_vxblocks


##
##

Mkplot_vxservice() {

  ##
  ##  service time
  ##

  echo "Creating Veritas service time plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vxcalcservice"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vxcalc_servtime-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxcalc_servtime-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/vxcalc_servtime-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Veritas Average Service Times (ms)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas Average Service Times (ms)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of function Mkplot_vxservice

##
##

Mkplot_vxrawdata() {

  echo "Creating Veritas RAW DM service time plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vxstatRAWservice"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/vxstat_disk_asvct-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Veritas RAW Disk Service Times (ms)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas RAW Disk Service Times (ms)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html

  ##
  ##  begin trend code
  ##

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/vxstat_disk_asvct-ALL-${ServerName}.dat
  DataFileOneColPath=${PlotDataDir}/vxstat_disk_asvctstats-ALL-${ServerName}.dat

  echo "  Creating all data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1200_vxstatRAWservall"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  touch $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  echo "set term png size $resX,$resY" > ${PlotScript}
  echo "set output '${GFileBase}-${resX}x${resY}.png'" >> ${PlotScript}
  echo "set autoscale" >> ${PlotScript}
  echo "set style line 1 lc rgb 'red' lw 2 pt 1" >> ${PlotScript}
  echo "set style line 2 lc rgb 'blue' lw 2 pt 1" >> ${PlotScript}
  echo "set logscale y" >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} - RAW Veritas Service Times (ms)'" >> ${PlotScript}
  echo "set xtics format ''"  >> ${PlotScript}
  echo "set origin 0.${originX},0.${originY}" >> ${PlotScript}
  echo "set size 0.${sizeX},0.${sizeY}" >> ${PlotScript}
  echo "plot '${DataFileTwoColPath}' using 1:2 notitle with linespoints linestyle 1" >> ${PlotScript}

  ##  add all data plot to index.html

  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">All Data</a> - " >> ${WebDir}/index.html

  ##
  ##

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1210_vxstatRAWservtrend"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  touch $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - RAW Veritas Disk Service Time Trend (ms)"

  origX=$resX
  origY=$resY
  resX=8192
  resY=4096

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  echo "<a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>&nbsp;&nbsp;Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html

  resX=$origX
  resY=$origY

  ##
  ##  end trend code
  ##

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of function Mkplot_rawdata

##
##

Mkplot_vxreadstats() {

  ##
  ##  average read time
  ##

  echo "Creating Veritas average read service time plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vxcalcreadAVG"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vxcalc_readmsavg-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxcalc_readmsavg-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/vxcalc_readmsavg-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Veritas Average Disk Read Service Times (ms)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas Average Disk Read Service Times (ms)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  ##
  ##  max read time
  ##

  echo "Creating Veritas average read service time plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vxcalcreadMAX"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vxcalc_readmsmax-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxcalc_readmsmax-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/vxcalc_readmsmax-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Veritas Maximum Disk Read Service Times (ms)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas Maximum Disk Read Service Times (ms)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

}  ##  end of function Mkplot_vxreadstats

##
##


Mkplot_vxwritestats() {

  ##
  ##  average write time
  ##

  echo "Creating Veritas average write service time plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vxcalcwriteAVG"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vxcalc_writmsavg-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxcalc_writmsavg-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/vxcalc_writmsavg-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Veritas Average Disk Write Service Times (ms)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas Average Disk Write Service Times (ms)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  ##
  ##  max write time
  ##

  echo "Creating Veritas maximum write service time plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_vxcalcwriteMAX"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/vxcalc_writmsmax-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/vxcalc_writmsmax-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/vxcalc_writmsmax-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Veritas Maximum Disk Write Service Times (ms)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas Maximum Disk Write Service Times (ms)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

}  ##  end of function Mkplot_vxwritestats

##
##

Mkplot_ioops() {

  ##
  ##  read operations
  ##

  echo "Creating Solaris read ops plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_iocalcROPS"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iocalc_rops-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_rops-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/iocalc_rops-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Solaris Read Operations (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris Read Operations (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  write operations
  ##

  echo "Creating Solaris write ops plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_iocalcWOPS"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iocalc_wops-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_wops-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/iocalc_wops-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Solaris Write Operations (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris Write Operations (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

}  ##  end of function Mkplot_ioops

##
##

Mkplot_iokbytes() {

  ##
  ##  read kBytes
  ##

  echo "Creating Solaris read kBytes plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_iocalcREADk"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iocalc_kread-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_kread-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/iocalc_kread-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Solaris Read (kBytes)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris Read (kBytes)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  write kBytes
  ##

  echo "Creating Solaris write kbytes plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_iocalcWRITEk"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iocalc_kwrite-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_kwrite-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/iocalc_kwrite-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Solaris Write (kBytes)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris Write (kBytes)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

}  ##  end of function Mkplot_iokbytes

##
##

Mkplot_iotrans() {

  ##
  ##  total transactions
  ##

  echo "Creating Solaris average total i/o transactions plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_iocalctransTOT"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iocalc_transtot-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_transtot-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/iocalc_transtot-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Solaris Total I/O Transactions (Average - Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris Total I/O Transactions (Average - Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "<ul class=\"summary\">" >> ${WebDir}/index.html

  ##
  ##  active transactions
  ##

  echo "Creating Solaris average active i/o transactions plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_iocalctransACT"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iocalc_transact-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_transact-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/iocalc_transact-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Solaris Active I/O Transactions (Average - Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris Active I/O Transactions (Average - Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  ##
  ##  wait transactions
  ##

  echo "Creating Solaris average wait i/o transactions plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_iocalctransWAIT"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  ## echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iocalc_transwait-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_transwait-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/iocalc_transwait-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Solaris Wait I/O Transactions (Average - Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris Wait I/O Transactions (Average - Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "</ul>" >> ${WebDir}/index.html
  ##  echo "</blockquote>" >> ${WebDir}/index.html


}  ##  end of function Mkplot_iotrans

##
##

Mkplot_ioservavg() {

  ##
  ##  weighted service time
  ##

  echo "Creating Solaris service time weighted plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_iocalcservWEIGHTED"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iocalc_servweighted-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_servweighted-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  ##  add the y scale type and linestyles by number of plots

  if [ $minY != 0 ]
  then
    echo "set logscale y" >> $PlotScript
  fi

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/iocalc_servweighted-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Solaris Average Service Time, Weighted (ms)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris Average Service Time, Weighted (ms)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  weighted wait time
  ##

  echo "Creating Solaris wait time weighted plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_iocalcwaitWEIGHTED"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iocalc_waitweighted-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_waitweighted-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/iocalc_waitweighted-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - Solaris Average Wait Time, Weighted (ms)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris Average Wait Time, Weighted (ms)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

}  ##  end of function Mkplot_ioservavg

##
##

Mkplot_iolunservice() {

  ##
  ##  RAW service time
  ##

  echo "Creating RAW LUN service time plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_iostatRAWservice"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iostat_rawserv-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_rawserv-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/iostat_rawserv-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - RAW LUN Service Time (ms)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">RAW LUN Service Time (ms)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html

  ##
  ##  begin trend code
  ##

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostat_rawserv-ALL-${ServerName}.dat
  DataFileOneColPath=${PlotDataDir}/iostat_rawservstats-ALL-${ServerName}.dat

  echo "  Creating all data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1200_iostatRAWservall"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  touch $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  echo "set term png size $resX,$resY" > ${PlotScript}
  echo "set output '${GFileBase}-${resX}x${resY}.png'" >> ${PlotScript}
  echo "set autoscale" >> ${PlotScript}
  echo "set style line 1 lc rgb 'red' lw 2 pt 1" >> ${PlotScript}
  echo "set style line 2 lc rgb 'blue' lw 2 pt 1" >> ${PlotScript}
  echo "set logscale y" >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} - RAW LUN Service Time (ms)'" >> ${PlotScript}
  echo "set xtics format ''"  >> ${PlotScript}
  echo "set origin 0.${originX},0.${originY}" >> ${PlotScript}
  echo "set size 0.${sizeX},0.${sizeY}" >> ${PlotScript}
  echo "plot '${DataFileTwoColPath}' using 1:2 notitle with linespoints linestyle 1" >> ${PlotScript}

  ##  add all data plot to index.html

  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">All Data</a> - " >> ${WebDir}/index.html

  ##
  ##

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1210_iostatRAWservtrend"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  touch $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - RAW LUN Service Time Trend (ms)"

  origX=$resX
  origY=$resY
  resX=8192
  resY=4096

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  echo "<a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>&nbsp;&nbsp;Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html

  resX=$origX
  resY=$origY

  ##
  ##  end trend code
  ##

  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  ##
  ##  RAW LUN wait time
  ##

  echo "Creating RAW LUN wait time weighted plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_iostatRAWwait"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iostat_rawwait-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_rawwait-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/iostat_rawwait-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - RAW LUN Wait Time (ms)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">RAW LUN Wait Time (ms)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html

  ##
  ##  begin trend code
  ##

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostat_rawwait-ALL-${ServerName}.dat
  DataFileOneColPath=${PlotDataDir}/iostat_rawwaitstats-ALL-${ServerName}.dat

  echo "  Creating all data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1200_iostatRAWwaitall"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  touch $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  echo "set term png size $resX,$resY" > ${PlotScript}
  echo "set output '${GFileBase}-${resX}x${resY}.png'" >> ${PlotScript}
  echo "set autoscale" >> ${PlotScript}
  echo "set style line 1 lc rgb 'red' lw 2 pt 1" >> ${PlotScript}
  echo "set style line 2 lc rgb 'blue' lw 2 pt 1" >> ${PlotScript}
  echo "set logscale y" >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} - RAW LUN Wait Time (ms)'" >> ${PlotScript}
  echo "set xtics format ''"  >> ${PlotScript}
  echo "set origin 0.${originX},0.${originY}" >> ${PlotScript}
  echo "set size 0.${sizeX},0.${sizeY}" >> ${PlotScript}
  echo "plot '${DataFileTwoColPath}' using 1:2 notitle with linespoints linestyle 1" >> ${PlotScript}

  ##  add all data plot to index.html

  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">All Data</a> - " >> ${WebDir}/index.html

  ##
  ##

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1210_iostatRAWwaittrend"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  touch $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - RAW LUN Wait Time Trend (ms)"

  origX=$resX
  origY=$resY
  resX=8192
  resY=4096

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  echo "<a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>&nbsp;&nbsp;Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html

  resX=$origX
  resY=$origY

  ##
  ##  end trend code
  ##

  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  ##
  ##  RAW LUN transactions
  ##

  echo "Creating RAW LUN transactions plots script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1100_iostatRAWtrans"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header_MD > $PlotScript

  ##  add the linestyles by number of plots

  ./MDay-ColorMap $NumRanges >> $PlotScript 2>/dev/null
  echo  >> $PlotScript

  echo "set logscale y" >> $PlotScript

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iostat_rawtrans-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_rawtrans-${ServerName}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  $minY to $maxY"

  RealWQMax=$maxY

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  for DataFilePath in ${PlotDataDir}/iostat_rawtrans-${ServerName}-*.dat
  do
    ##  echo "  `basename $DataFilePath`"
    DataFile=`basename $DataFilePath`

    ##  create the plot entry to a temp file

    echo >> $PlotScript.$$
    echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
    echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
    echo "plot '${DataFilePath}' using 1:2 notitle with linespoints linestyle ${plotIndex}" >> $PlotScript.$$

    ##  increment stuff and loop again
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} Stacked Blue to Red - RAW LUN Transactions (Count)'" >> $PlotScript
  echo "set xtics format ''" >> $PlotScript
  cat $PlotScript.$$ >> $PlotScript

  rm -f $PlotScript.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">RAW LUN Transactions (Count)</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $RealWQMax" >> ${WebDir}/index.html

  ##
  ##  begin trend code
  ##

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostat_rawtrans-ALL-${ServerName}.dat
  DataFileOneColPath=${PlotDataDir}/iostat_rawtransstats-ALL-${ServerName}.dat

  echo "  Creating all data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1200_iostatRAWtransall"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  touch $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  echo "set term png size $resX,$resY" > ${PlotScript}
  echo "set output '${GFileBase}-${resX}x${resY}.png'" >> ${PlotScript}
  echo "set autoscale" >> ${PlotScript}
  echo "set style line 1 lc rgb 'red' lw 2 pt 1" >> ${PlotScript}
  echo "set style line 2 lc rgb 'blue' lw 2 pt 1" >> ${PlotScript}
  echo "set logscale y" >> $PlotScript
  echo "set multiplot title '${ServerName} - ${FullRangeBeginTime} to ${FullRangeEndTime} - RAW LUN Transactions (Count)'" >> ${PlotScript}
  echo "set xtics format ''"  >> ${PlotScript}
  echo "set origin 0.${originX},0.${originY}" >> ${PlotScript}
  echo "set size 0.${sizeX},0.${sizeY}" >> ${PlotScript}
  echo "plot '${DataFileTwoColPath}' using 1:2 notitle with linespoints linestyle 1" >> ${PlotScript}

  ##  add all data plot to index.html

  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">All Data</a> - " >> ${WebDir}/index.html

  ##
  ##

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1210_iostatRAWtranstrend"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  touch $PlotScript 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - RAW LUN Transactions Trend (Count)"

  origX=$resX
  origY=$resY
  resX=8192
  resY=4096

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  echo "<a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>&nbsp;&nbsp;Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html

  resX=$origX
  resY=$origY

  ##
  ##  end trend code
  ##

  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

}  ##  end of function Mkplot_iolunservice

##
##

Echo_Header_MD()
{

echo "set term png size ${resX},${resY}"
echo "set output '${GFileBase}-${resX}x${resY}.png'"
echo "set autoscale"
echo "unset log"
echo "unset label"
echo "unset object"
echo "set xtic auto"
echo "set ytic auto"
echo "set key off"
echo

}  ##  end of function Echo_Header_MD
