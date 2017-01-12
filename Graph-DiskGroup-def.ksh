
##
##  functions for Graph-DiskGroup.ksh
##


Mkplot_iorwops_local()
{

  echo "Creating iocalc read + write ops plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1210_iocalcrwops"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges


  ## minY=`cat ${PlotDataDir}/iocalc_rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wops-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  ## maxY=`cat ${PlotDataDir}/iocalc_rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wops-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  minX=`cat ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_TOTops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadOps=`cat ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadOps=`cat ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxReadOps=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where rs_sum = ( select max(rs_sum) from tmp_gdg_iocalc_$$ )"`

  minWriteOps=`cat ${PlotDataDir}/iocalc_Wops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteOps=`cat ${PlotDataDir}/iocalc_Wops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWriteOps=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where ws_sum = ( select max(ws_sum) from tmp_gdg_iocalc_$$ )"`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_TOTops-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Averaged Read and Write Operations (stacked)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Averaged R/W Ops</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  ##  echo "Read ops from $minReadOps to $maxReadOps at `FromEpoch ${EPOCHmaxReadOps} 2>/dev/null`" >> ${WebDir}/index.html
  echo "Read ops from $minReadOps to $maxReadOps" >> ${WebDir}/index.html
  ##  echo "<br>Write ops from $minWriteOps to $maxWriteOps at `FromEpoch ${EPOCHmaxWriteOps} 2>/dev/null`" >> ${WebDir}/index.html
  echo "<br>Write ops from $minWriteOps to $maxWriteOps" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iorwops_local

##
##

Mkplot_iorwk_local()
{

  echo "Creating iocalc read + write K plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1220_iocalcrwk"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadK=`cat ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadK=`cat ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxReadK=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where krs_sum = ( select max(krs_sum) from tmp_gdg_iocalc_$$ )"`

  minWriteK=`cat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteK=`cat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWriteK=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where kws_sum = ( select max(kws_sum) from tmp_gdg_iocalc_$$ )"`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Averaged Read and Write KBytes'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Averaged R/W KBytes</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read Kbytes from $minReadK to $maxReadK at `FromEpoch ${EPOCHmaxReadK} 2>/dev/null`" >> ${WebDir}/index.html
  echo "<br>Write Kbytes rom $minWriteK to $maxWriteK at `FromEpoch ${EPOCHmaxWriteK} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "Creating iocalc read + write K per op plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1225_iocalckperop"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minReadK=`cat ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxReadK=`cat ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxReadK=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where rkperop = ( select max(rkperop) from tmp_gdg_iocalc_$$ )"`

  minWriteK=`cat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWriteK=`cat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWriteK=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where wkperop = ( select max(wkperop) from tmp_gdg_iocalc_$$ )"`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Averaged Read and Write KBytes per operation'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Averaged R/W KBytes per Operation</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read Kbytes from $minReadK to $maxReadK at `FromEpoch ${EPOCHmaxReadK} 2>/dev/null`" >> ${WebDir}/index.html
  echo "<br>Write Kbytes rom $minWriteK to $maxWriteK at `FromEpoch ${EPOCHmaxWriteK} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iorwk_local

##
##

Mkplot_ioawtrans_local()
{

  echo "Creating iocalc active + wait transactions plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1230_iocalcawtrans"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWsvct=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWsvct=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWsvct=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where wsvct_avg = ( select max(wsvct_avg) from tmp_gdg_iocalc_$$ )"`

  minAsvct=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxAsvct=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxAsvct=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where asvct_avg = ( select max(asvct_avg) from tmp_gdg_iocalc_$$ )"`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Averaged Active and Wait Transaction Count'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Averaged Disk Transactions</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Wait transactions from $minWsvct to $maxWsvct at `FromEpoch ${EPOCHmaxWsvct} 2>/dev/null`" >> ${WebDir}/index.html
  echo "<br>Active transactions from $minAsvct to $maxAsvct at `FromEpoch ${EPOCHmaxAsvct} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_ioawtrans_local

##
##

Mkplot_iodevcount_local()
{

  echo "Creating iocalc devcount plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1250_iocalcdevcount"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minY=`cat ${PlotDataDir}/iocalc_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_numdev-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxY=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where adevices = ( select max(adevices) from tmp_gdg_iocalc_$$ )" | head -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_numdev-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Device Count'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Path Count</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $minY to $maxY at `FromEpoch ${EPOCHmaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iodevcount_local

##
##

Mkplot_ioaasvct_local()
{

  echo "Creating iocalc service time weighted average plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1240_iocalcaasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minAsvct=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxAsvct=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxAsvct=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where asvct_avg = ( select max(asvct_avg) from tmp_gdg_iocalc_$$ )"`

  minWAsvct=`cat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWAsvct=`cat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWAsvct=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where asvct_avg_a = ( select max(asvct_avg_a) from tmp_gdg_iocalc_$$ )"`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minAsvct -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Weighted Average Service Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  ##
  ##  create the index.html entry
  ##

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Average Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Average service time from $minAsvct to $maxAsvct at `FromEpoch ${EPOCHmaxAsvct} 2>/dev/null`" >> ${WebDir}/index.html
  echo "<br>Weighted average service time from $minWAsvct to $maxWAsvct at `FromEpoch ${EPOCHmaxWAsvct} 2>/dev/null`" >> ${WebDir}/index.html

  ##
  ##  create the trend plot - use weighted service times
  ##

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1242_iocalctrendasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iocalc_statsweighted-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris Weighted Average Service Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ## echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average Weighted Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ## echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_ioaasvct_local

##
##

Mkplot_iowasvct_local()
{

  echo "Creating iocalc wait time weighted average plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1240_iocalcwasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  maxX=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWsvct=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWsvct=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWsvct=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where wsvct_avg = ( select max(wsvct_avg) from tmp_gdg_iocalc_$$ )`

  minWWsvct=`cat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWWsvct=`cat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWWsvct=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where wsvct_avg_a = ( select max(wsvct_avg_a) from tmp_gdg_iocalc_$$ )`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minWsvct -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minX to $maxX"
  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    ## maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Weighted Average Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Average Wait Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Average wait time from $minWsvct to $maxWsvct at `FromEpoch ${EPOCHmaxWsvct} 2>/dev/null`" >> ${WebDir}/index.html
  echo "<br>Weighted average wait time from $minWWsvct to $maxWWsvct at `FromEpoch ${EPOCHmaxWWsvct} 2>/dev/null`" >> ${WebDir}/index.html

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1242_iocalctrendwasvct"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iocalc_statswsvct_a-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris Weighted Average Wait Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iowasvct_local

##
##

Mkplot_servXwait_local()
{

  echo "Creating iocalc combined average service and wait time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1250_iocalcwaitXserv"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  ## minX=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | head -1`
  ## maxX=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minWsvct=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWsvct=`cat ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWsvct=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where wsvct_avg = ( select max(wsvct_avg) from tmp_gdg_iocalc_$$ )`

  minAsvct=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxAsvct=`cat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxAsvct=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iocalc_$$ where asvct_avg = ( select max(asvct_avg) from tmp_gdg_iocalc_$$ )"`

  ## minWWsvct=`cat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  ## maxWWsvct=`cat ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ## echo "  asvct from $minAsvct to $maxAsvct"
  ## echo "  wsvct from $minWsvct to $maxWsvct"
  ## echo "  Y from $minY to $maxY"

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minWsvct -ne 0  -a  $minAsvct -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  for DataFilePath in ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  ##
  ##  find throttle events
  ##

  unset NumThrottleEvents
  ## ${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'" | read NumThrottleEvents
  NumThrottleEvents=`${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'"`

  ThrottlesExist=0
  if [ $NumThrottleEvents -ne 0 ]
  then
    echo "  Creating throttle event data..."
    ThrottlesExist=1
    
    ${ProgPrefix}/NewQuery fsr "select esttime, '1' from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, currthrottle from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsxport from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsdriver from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat

    minCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minThrottle=0.0
    maxThrottle=2.0

    echo "    Curr Thrott from $minCthrott to $maxCthrott"
    echo "    Transport   from $minXport to $maxXport"
    echo "    Driver      from $minDriver to $maxDriver"

    for DataFilePath in ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat 
    do

      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`

      echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 4 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entry to a temp file

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle 4 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    done  ##  for each file

  fi  ##  if there are throttle events

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Average Service and Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minThrottle}:${maxThrottle}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Average Wait Times and Service times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Average wait time from $minWsvct to $maxWsvct at `FromEpoch ${EPOCHmaxWsvct} 2>/dev/null`" >> ${WebDir}/index.html
  echo "<br>Average service time from $minAsvct to $maxAsvct at `FromEpoch ${EPOCHmaxAsvct} 2>/dev/null`" >> ${WebDir}/index.html
  if [ $ThrottlesExist -eq 1 ]
  then
    echo "<br>Throttling occured" >> ${WebDir}/index.html
  fi
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_servXwait_local

##
##

Mkplot_iolundata_local()
{

  echo "Creating iostat individual LUN data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatlundata"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minY=`cat ${PlotDataDir}/iostat_asvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_asvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`
  EPOCHmaxY=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iostat_$$ where asvct = ( select max(asvct) from tmp_gdg_iostat_$$ )"`

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iostat_asvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Service Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw LUN Service Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  ##  echo "From $minY to $maxY at `FromEpoch ${EPOCHmaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  ##  create the frequencey distribution plot script
  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatlunhist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1
  ##  create the gnuplot script header
  Echo_Header > ${WorkDir}/${PlotScript}

  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Service Time Histogram (ms)'" >> ${WorkDir}/${PlotScript}

  echo "n=20 #number of intervals" >> ${WorkDir}/${PlotScript}
  echo "max=$maxY #max value" >> ${WorkDir}/${PlotScript}
  echo "min=$minY #min value" >> ${WorkDir}/${PlotScript}
  echo "width=(max-min)/n #interval width" >> ${WorkDir}/${PlotScript}
  echo "#function used to map a value to the intervals" >> ${WorkDir}/${PlotScript}
  echo "hist(x,width)=width*floor(x/width)+width/2.0" >> ${WorkDir}/${PlotScript}
  ## echo "set xrange [min:max]" >> ${WorkDir}/${PlotScript}
  echo "set xrange [min:]" >> ${WorkDir}/${PlotScript}
  if [ $maxY -gt 1000 ]
  then
    echo "set yrange [0:1000]" >> ${WorkDir}/${PlotScript}
  else
    echo "set yrange [0:$maxY]" >> ${WorkDir}/${PlotScript}
  fi
  echo "#to put an empty boundary around the" >> ${WorkDir}/${PlotScript}
  echo "#data inside an autoscaled graph." >> ${WorkDir}/${PlotScript}
  echo "set size 0.99,0.97"  >> ${WorkDir}/${PlotScript}
  echo "set xtics min,(max-min)/5,max" >> ${WorkDir}/${PlotScript}
  echo "set boxwidth width*0.9" >> ${WorkDir}/${PlotScript}
  echo "set style fill solid 0.75 #fillstyle" >> ${WorkDir}/${PlotScript}
  echo "set tics out nomirror" >> ${WorkDir}/${PlotScript}
  echo "set xlabel \"x\"" >> ${WorkDir}/${PlotScript}
  echo "set ylabel \"Frequency\"" >> ${WorkDir}/${PlotScript}
  echo "#count and plot" >> ${WorkDir}/${PlotScript}
  echo "plot \"${DataFilePath}\" u (hist(\$1,width)):(1.0) smooth freq w boxes lc rgb \"red\" notitle" >> ${WorkDir}/${PlotScript}
  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Service Time Histogram</a>" >> ${WebDir}/index.html

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1262_iostattrendlunhist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iostat_asvct-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Service Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html

  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iolundata_local

##
##

Mkplot_iolunactv_local()
{

  echo "Creating iostat individual LUN trans count data plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1265_iostatlunactv"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  ## minY=`cat ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_tottrans-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  ## maxY=`cat ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_tottrans-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`

  minY=`cat ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`
  EPOCHmaxY=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iostat_$$ where actv = ( select max(actv) from tmp_gdg_iostat_$$ )" | head -1`

  echo
  echo "  minX      : $minX"
  echo "  minY      : $minY"
  echo "  maxY      : $maxY"
  echo "  EPOCHmaxY : $EPOCHmaxY"
  echo

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat # ${PlotDataDir}/iostat_tottrans-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    ## echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Active Transaction Count'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris:  Raw LUN Active Transactions</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  ##  echo "From $minY to $maxY at `FromEpoch ${EPOCHmaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1265_iostattrendlunactv"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostat_timeactv-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris Raw LUN Transaction Count"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html


  echo "</blockquote>" >> ${WebDir}/index.html


}  ##  end of Mkplot_iolunactv_local

##
##

Mkplot_iolunwait_local()
{

  echo "Creating iostat individual LUN wait plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatlunwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minY=`cat ${PlotDataDir}/iostat_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_wsvct-${ServerName}-${StartTime}_${EndTime}.dat | sort -un | tail -1`
  EPOCHmaxY=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iostat_$$ where wsvct = ( select max(wsvct) from tmp_gdg_iostat_$$ )" | head -1`

  echo
  echo "  minX      : $minX"
  echo "  minY      : $minY"
  echo "  maxY      : $maxY"
  echo "  EPOCHmaxY : $EPOCHmaxY"
  echo

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ## echo "  $minY to $maxY"

  for DataFilePath in ${PlotDataDir}/iostat_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  find the x range max

    maxX=`wc -l $DataFilePath | awk '{ print $1 }'`
    echo "    $minX to $maxX"

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${minX}:${maxX}]" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw LUN Wait Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  ##  echo "From $minY to $maxY at `FromEpoch ${EPOCHmaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "From $minY to $maxY" >> ${WebDir}/index.html

  ##  create the frequencey distribution plot script
  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatwaithist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1
  ##  create the gnuplot script header
  Echo_Header > ${WorkDir}/${PlotScript}

  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Wait Time Histogram (ms)'" >> ${WorkDir}/${PlotScript}

  echo "n=20 #number of intervals" >> ${WorkDir}/${PlotScript}
  echo "max=$maxY #max value" >> ${WorkDir}/${PlotScript}
  echo "min=$minY #min value" >> ${WorkDir}/${PlotScript}
  echo "width=(max-min)/n #interval width" >> ${WorkDir}/${PlotScript}
  echo "#function used to map a value to the intervals" >> ${WorkDir}/${PlotScript}
  echo "hist(x,width)=width*floor(x/width)+width/2.0" >> ${WorkDir}/${PlotScript}
  ## echo "set xrange [min:max]" >> ${WorkDir}/${PlotScript}
  echo "set xrange [min:]" >> ${WorkDir}/${PlotScript}
  if [ $maxY -gt 1000 ]
  then
    echo "set yrange [0:1000]" >> ${WorkDir}/${PlotScript}
  else
    echo "set yrange [0:$maxY]" >> ${WorkDir}/${PlotScript}
  fi
  echo "#to put an empty boundary around the" >> ${WorkDir}/${PlotScript}
  echo "#data inside an autoscaled graph." >> ${WorkDir}/${PlotScript}
  echo "set size 0.99,0.97"  >> ${WorkDir}/${PlotScript}
  echo "set xtics min,(max-min)/5,max" >> ${WorkDir}/${PlotScript}
  echo "set boxwidth width*0.9" >> ${WorkDir}/${PlotScript}
  echo "set style fill solid 0.75 #fillstyle" >> ${WorkDir}/${PlotScript}
  echo "set tics out nomirror" >> ${WorkDir}/${PlotScript}
  echo "set xlabel \"x\"" >> ${WorkDir}/${PlotScript}
  echo "set ylabel \"Frequency\"" >> ${WorkDir}/${PlotScript}
  echo "#count and plot" >> ${WorkDir}/${PlotScript}
  echo "plot \"${DataFilePath}\" u (hist(\$1,width)):(1.0) smooth freq w boxes lc rgb \"red\" notitle" >> ${WorkDir}/${PlotScript}
  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Wait Time Histogram</a>" >> ${WebDir}/index.html

  echo "  Creating trend plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1262_iostattrendwaithist"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  touch ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  we need both a 2 column file with time and values
  ##  and a single column file of just values.

  DataFileTwoColPath=${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
  DataFileOneColPath=${PlotDataDir}/iostat_wsvct-${ServerName}-${StartTime}_${EndTime}.dat

  ##  set the graph title

  GNUPlotLinearTrendTitle="${ServerName} - ${StartTime} to ${EndTime} - Solaris Raw LUN Wait Times Trend (ms)"

  GNUStats_MakeLinearTrend

  ##
  ##  finish the index.html entry
  ##

  ##  echo "<br><a href=\"${GFileBase}-${resX}x${resY}.png\">Trend</a>" >> ${WebDir}/index.html
  echo "<br>Average is $GNUPlotLinearTrend_Mean with median value $GNUPlotLinearTrend_Median" >> ${WebDir}/index.html
  ##  echo "<br>&nbsp;&nbsp;Trend rate is $GNUPlotLinearTrend_Slope" >> ${WebDir}/index.html


  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iolunwait_local

##
##

Mkplot_iolunservXwait_local()
{

  echo "Creating iostat individual LUN service X wait plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1260_iostatservXwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minServ=`cat ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxServ=`cat ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxServ=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iostat_$$ where asvct = ( select max(asvct) from tmp_gdg_iostat_$$ )"`

  minWait=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWait=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWait=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iostat_$$ where wsvct = ( select max(wsvct) from tmp_gdg_iostat_$$ )"`

  minY=`cat ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  Service from $minServ to $maxServ"
  ##  echo "  Wait    from $minWait to $maxWait"
  ##  echo "  Y       from $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  for DataFilePath in ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  ##
  ##  find throttle events
  ##

  unset NumThrottleEvents
  ${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'" | read NumThrottleEvents

  ThrottlesExist=0
  if [ $NumThrottleEvents -ne 0 ]
  then
    echo "  Creating throttle event data..."
    ThrottlesExist=1
    
    ${ProgPrefix}/NewQuery fsr "select esttime, '1' from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, currthrottle from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsxport from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsdriver from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat

    minCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minThrottle=0.0
    maxThrottle=2.0

    echo "    Curr Thrott from $minCthrott to $maxCthrott"
    echo "    Transport   from $minXport to $maxXport"
    echo "    Driver      from $minDriver to $maxDriver"

    for DataFilePath in ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat 
    do

      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`

      echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 4 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entry to a temp file

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle 4 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    done  ##  for each file

  fi  ##  if there are throttle events

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Service versus Wait Times (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minThrottle}:${maxThrottle}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw LUN Service versus Wait Times</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Service times from $minServ to $maxServ at `FromEpoch ${EPOCHmaxServ} 2>/dev/null`" >> ${WebDir}/index.html
  ##  echo "Service times from $minServ to $maxServ" >> ${WebDir}/index.html
  echo "<br>Wait times from $minWait to $maxWait at `FromEpoch ${EPOCHmaxWait} 2>/dev/null`" >> ${WebDir}/index.html
  ##  echo "<br>Wait times from $minWait to $maxWait" >> ${WebDir}/index.html
  if [ $ThrottlesExist -eq 1 ]
  then
    echo "<br>Throttling occured" >> ${WebDir}/index.html
  fi
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_iolunservXwait_local

##
##

Mkplot_iolunperops_local()
{

  echo "Creating iostat individual LUN read/write K per op plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1265_iostatrwperop"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minRperop=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxRperop=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxRperop=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk ' $2 == maxRperop { print $1 }' maxRperop=$maxRperop | head -1`

  minWperop=`cat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWperop=`cat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWperop=`cat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk ' $2 == maxWperop { print $1 }' maxWperop=$maxWperop | head -1`

  minY=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxY=`grep ${maxY} ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | head -1 | awk -F\: '{ print $2 }'`

  echo
  echo "  Read K per op from $minRperop to $maxRperop"
  echo "    EPOCHmaxRperop : $EPOCHmaxRperop"
  echo "  Writ K per op from $minWperop to $maxWperop"
  echo "    EPOCHmaxWperop : $EPOCHmaxWperop"
  echo "  Y             from $minY to $maxY"
  echo

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "##  set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  for DataFilePath in ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat
  do
    ## echo "  $DataFilePath"
    DataFile=`basename $DataFilePath`
    LegendText=`echo $DataFile | awk -F\- '{ print $1 }' | awk -F\_ '{ print $2 }'`
    ## echo "    $DataFile - $LegendText"

    ##  set the legend text

    echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$

    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$

    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$


    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done  ##  for each DataFilePath

  ##
  ##  find throttle events
  ##

  unset NumThrottleEvents
  ${ProgPrefix}/NewQuery fsr "select count(*) from throttle where serverid = '${ServerID}' and esttime between '${StartEpoch}' and '${EndEpoch}'" | read NumThrottleEvents

  ThrottlesExist=0
  if [ $NumThrottleEvents -ne 0 ]
  then
    echo "  Creating throttle event data..."
    ThrottlesExist=1
    
    ${ProgPrefix}/NewQuery fsr "select esttime, '1' from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, currthrottle from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsxport from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, cmdsdriver from throttle where serverid = ${ServerID} and esttime between '${StartEpoch}' and '${EndEpoch}' and function = 'ssd_reduce_throttle'" > ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat

    minCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxCthrott=`cat ${PlotDataDir}/throttle_redcthrott-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxXport=`cat ${PlotDataDir}/throttle_redxport-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxDriver=`cat ${PlotDataDir}/throttle_reddriver-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minThrottle=0.0
    maxThrottle=2.0

    echo "    Curr Thrott from $minCthrott to $maxCthrott"
    echo "    Transport   from $minXport to $maxXport"
    echo "    Driver      from $minDriver to $maxDriver"

    for DataFilePath in ${PlotDataDir}/throttle_redthrottle-${ServerName}-${StartTime}_${EndTime}.dat 
    do

      DataFile=`basename $DataFilePath`
      LegendText=`echo $DataFile | awk -F\- '{ print $1 }'`

      echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 4 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

      ##  create the plot entry to a temp file

      echo >> ${WorkDir}/${PlotScript}.$$
      echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
      echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle 4 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    done  ##  for each file

  fi  ##  if there are throttle events

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Read and Write K per Operation'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minThrottle}:${maxThrottle}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw LUN Read and Write K per Operation</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read K per Op from $minRperop to $maxRperop at `FromEpoch ${EPOCHmaxRperop} 2>/dev/null`" >> ${WebDir}/index.html
  echo "<br>Write K per Op from $minWperop to $maxWperop at `FromEpoch ${EPOCHmaxWperop} 2>/dev/null`" >> ${WebDir}/index.html
  if [ $ThrottlesExist -eq 1 ]
  then
    echo "<br>Throttling occured" >> ${WebDir}/index.html
  fi
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  plot raw wait time vs raw write size
  ##

  echo "Creating iostat individual LUN write K per op vs. wait time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1267_iostatwkXwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minWperop=`cat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWperop=`cat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWperop=`cat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk ' $2 == maxWperop { print $1 }' maxWperop=$maxWperop | head -1`

  minWait=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWait=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWait=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iostat_$$ where wsvct = ( select max(wsvct) from tmp_gdg_iostat_$$ )" | head -1`


  minY=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxY=`grep ${maxY} ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | head -1 | awk -F\: '{ print $2 }'`

  ##  echo "  Writ K per op from $minWperop to $maxWperop"
  ##  echo "  Wait time from $minWait to $maxWait"
  ##  echo "  Y             from $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "##  set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ##  setup the individual plots

  echo "set label 'WriteK/op' at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot '${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat' using 1:2 title 'Wait Time' with linespoints linestyle 1 axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  legendY=`expr $legendY - $legincY`

  echo "set label 'Wait Time' at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot '${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat' using 1:2 title 'Wait Time' with linespoints linestyle 2 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

  ##  combine into a single plot

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Write K per Operation versus Wait Time (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  ##  echo "set ytics" >> ${WorkDir}/${PlotScript}
  ##  echo "set y2tics" >> ${WorkDir}/${PlotScript}
  echo "unset ytics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minWperop}:${maxWperop}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minWait}:${maxWait}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw LUN Write K per Operation versus Wait Time</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Write K per Op from $minWperop to $maxWperop at `FromEpoch ${EPOCHmaxWperop} 2>/dev/null`" >> ${WebDir}/index.html
  echo "<br>Wait time from $minWait to $maxWait ms at `FromEpoch ${EPOCHmaxWait} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  plot raw wait time vs raw read size
  ##

  echo "Creating iostat individual LUN read K per op vs. wait time plot script..."

  GFileBase="${ServerName}_${StartTime}-${EndTime}_1267_iostatrkXwait"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  find the ranges

  minX=0

  minWperop=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWperop=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWperop=`cat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk ' $2 == maxWperop { print $1 }' maxWperop=$maxWperop | head -1`

  minWait=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxWait=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxWait=`${ProgPrefix}/NewQuery fsr "select esttime from tmp_gdg_iostat_$$ where wsvct = ( select max(wsvct) from tmp_gdg_iostat_$$ )"`


  minY=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxY=`cat ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $2 }' | sort -un | tail -1`
  EPOCHmaxY=`grep ${maxY} ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }' | head -1 | awk -F\: '{ print $2 }'`

  ##  echo "  Read K per op from $minWperop to $maxWperop"
  ##  echo "  Wait time from $minWait to $maxWait"
  ##  echo "  Y             from $minY to $maxY"

  if [ $maxY = 0 ]
  then
    maxY=1
  fi

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  if [ $minY -ne 0 ]
  then
    echo "##  set logscale y" >> ${WorkDir}/${PlotScript}
  fi

  ##  setup the individual plots

  echo "set label 'ReadK/op' at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot '${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat' using 1:2 title 'Wait Time' with linespoints linestyle 1 axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  legendY=`expr $legendY - $legincY`

  echo "set label 'Wait Time' at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot '${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat' using 1:2 title 'Wait Time' with linespoints linestyle 2 axes x1y2" >> ${WorkDir}/${PlotScript}.$$

  ##  combine into a single plot

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Solaris Individual LUN Read K per Operation versus Wait Time (ms)'" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  ##  echo "set ytics" >> ${WorkDir}/${PlotScript}
  ##  echo "set y2tics" >> ${WorkDir}/${PlotScript}
  echo "unset ytics" >> ${WorkDir}/${PlotScript}
  echo "unset y2tics" >> ${WorkDir}/${PlotScript}
  echo >> ${WorkDir}/${PlotScript}
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}
  echo "set yrange [${minWperop}:${maxWperop}]" >> ${WorkDir}/${PlotScript}
  echo "set y2range [${minWait}:${maxWait}]" >> ${WorkDir}/${PlotScript}

  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Solaris: Raw LUN Read K per Operation versus Wait Time</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Read K per Op from $minWperop to $maxWperop at `FromEpoch ${EPOCHmaxWperop} 2>/dev/null`" >> ${WebDir}/index.html
  echo "<br>Wait time from $minWait to $maxWait ms at `FromEpoch ${EPOCHmaxWait} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html


}  ##  end of Mkplot_iolunperops_local

##
##

Mkplot_byLUN_local() {

  echo "Creating combined path plot scripts..."

  echo "  Read Ops"

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`

  MinY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | head -1`
  MaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -n | tail -1`
  ##  EPOCHMaxY=`grep ${MaxY} ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | tail -1 | awk -F\: '{ print $2 }'`
  EPOCHMaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk ' $2 == MaxY { print $1 }' MaxY=$MaxY | head -1`

  echo "    Read Ops limits:"
  echo "      MinX:    $MinX"
  echo "      MaxX:    $MaxX"
  echo "      MinY:    $MinY"
  echo "      MaxY:    $MaxY"
  echo "      EPOCHMaxY: $EPOCHMaxY"

  ##
  ##  generate a single plot of read ops of all paths
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2500_readops"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  exec 4<${WorkDir}/tmp_gdg_iostatpaths
  while read -u4 IOPath
  do
    ##  echo "  Path ${IOPath}"
    DataFilePath=${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-${IOPath}.dat
    DataFile=`basename $DataFilePath`
    LegendText=${IOPath}

    ##  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinY}:${MaxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done
  exec 4<&-

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Read Ops for all Paths'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Read Ops for all Paths</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinY to $MaxY at `FromEpoch ${EPOCHMaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "  Write Ops"

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`

  MinY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -n | head -1`
  MaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $3 }' | sort -n | tail -1`
  ##  EPOCHMaxY=`grep ${MaxY} ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | tail -1 | awk -F\: '{ print $2 }'`
  EPOCHMaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk ' $3 == MaxY { print $1 }' MaxY=$MaxY | head -1`

  echo "    Write Ops limits:"
  echo "      MinX:    $MinX"
  echo "      MaxX:    $MaxX"
  echo "      MinY:    $MinY"
  echo "      MaxY:    $MaxY"
  echo "      EPOCHMaxY: $EPOCHMaxY"


  ##
  ##  generate a single plot of write ops of all paths
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2500_writops"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  exec 4<${WorkDir}/tmp_gdg_iostatpaths
  while read -u4 IOPath
  do
    ##  echo "  Path ${IOPath}"
    DataFilePath=${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-${IOPath}.dat
    DataFile=`basename $DataFilePath`
    LegendText=${IOPath}

    ##  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinY}:${MaxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:3 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done
  exec 4<&-

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Write Ops for all Paths'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Write Ops for all Paths</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinY to $MaxY at `FromEpoch ${EPOCHMaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "  Read K"

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`

  MinY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $4 }' | sort -n | head -1`
  MaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $4 }' | sort -n | tail -1`
  ##  EPOCHMaxY=`grep ${MaxY} ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | tail -1 | awk -F\: '{ print $2 }'`
  EPOCHMaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk ' $4 == MaxY { print $1 }' MaxY=$MaxY | head -1`

  echo "    Read K limits:"
  echo "      MinX:    $MinX"
  echo "      MaxX:    $MaxX"
  echo "      MinY:    $MinY"
  echo "      MaxY:    $MaxY"
  echo "      EPOCHMaxY: $EPOCHMaxY"


  ##
  ##  generate a single plot of Read K of all paths
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2500_readK"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  exec 4<${WorkDir}/tmp_gdg_iostatpaths
  while read -u4 IOPath
  do
    ##  echo "  Path ${IOPath}"
    DataFilePath=${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-${IOPath}.dat
    DataFile=`basename $DataFilePath`
    LegendText=${IOPath}

    ##  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinY}:${MaxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:4 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done
  exec 4<&-

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Read K for all Paths'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Read K for all Paths</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinY to $MaxY at `FromEpoch ${EPOCHMaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "  Write K"

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`

  MinY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $5 }' | sort -n | head -1`
  MaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $5 }' | sort -n | tail -1`
  ##  EPOCHMaxY=`grep ${MaxY} ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | tail -1 | awk -F\: '{ print $2 }'`
  EPOCHMaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk ' $5 == MaxY { print $1 }' MaxY=$MaxY | head -1`

  echo "    Write K limits:"
  echo "      MinX:    $MinX"
  echo "      MaxX:    $MaxX"
  echo "      MinY:    $MinY"
  echo "      MaxY:    $MaxY"
  echo "      EPOCHMaxY: $EPOCHMaxY"


  ##
  ##  generate a single plot of Write K of all paths
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2500_writK"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  exec 4<${WorkDir}/tmp_gdg_iostatpaths
  while read -u4 IOPath
  do
    ##  echo "  Path ${IOPath}"
    DataFilePath=${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-${IOPath}.dat
    DataFile=`basename $DataFilePath`
    LegendText=${IOPath}

    ##  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinY}:${MaxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:5 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done
  exec 4<&-

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Write K for all Paths'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Write K for all Paths</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinY to $MaxY at `FromEpoch ${EPOCHMaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "  Wait transactions"

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`

  MinY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $6 }' | sort -n | head -1`
  MaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $6 }' | sort -n | tail -1`
  ##  EPOCHMaxY=`grep ${MaxY} ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | tail -1 | awk -F\: '{ print $2 }'`
  EPOCHMaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk ' $6 == MaxY { print $1 }' MaxY=$MaxY | head -1`

  echo "    Wait transactions limits:"
  echo "      MinX:    $MinX"
  echo "      MaxX:    $MaxX"
  echo "      MinY:    $MinY"
  echo "      MaxY:    $MaxY"
  echo "      EPOCHMaxY: $EPOCHMaxY"


  ##
  ##  generate a single plot of Wait Trans of all paths
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2500_waittrans"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  exec 4<${WorkDir}/tmp_gdg_iostatpaths
  while read -u4 IOPath
  do
    ##  echo "  Path ${IOPath}"
    DataFilePath=${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-${IOPath}.dat
    DataFile=`basename $DataFilePath`
    LegendText=${IOPath}

    ##  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinY}:${MaxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:6 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done
  exec 4<&-

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Wait Transactions for all Paths'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Wait Transactions for all Paths</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinY to $MaxY at `FromEpoch ${EPOCHMaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "  Active transactions"

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`

  MinY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $7 }' | sort -n | head -1`
  MaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $7 }' | sort -n | tail -1`
  ##  EPOCHMaxY=`grep ${MaxY} ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | tail -1 | awk -F\: '{ print $2 }'`
  EPOCHMaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk ' $7 == MaxY { print $1 }' MaxY=$MaxY | head -1`

  echo "    Active transactions limits:"
  echo "      MinX:    $MinX"
  echo "      MaxX:    $MaxX"
  echo "      MinY:    $MinY"
  echo "      MaxY:    $MaxY"
  echo "      EPOCHMaxY: $EPOCHMaxY"


  ##
  ##  generate a single plot of Active Trans of all paths
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2500_activetrans"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  exec 4<${WorkDir}/tmp_gdg_iostatpaths
  while read -u4 IOPath
  do
    ##  echo "  Path ${IOPath}"
    DataFilePath=${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-${IOPath}.dat
    DataFile=`basename $DataFilePath`
    LegendText=${IOPath}

    ##  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinY}:${MaxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:7 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done
  exec 4<&-

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Active Transactions for all Paths'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Active Transactions for all Paths</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinY to $MaxY at `FromEpoch ${EPOCHMaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "  Wait time"

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`

  MinY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $8 }' | sort -n | head -1`
  MaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $8 }' | sort -n | tail -1`
  ##  EPOCHMaxY=`grep ${MaxY} ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | tail -1 | awk -F\: '{ print $2 }'`
  EPOCHMaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk ' $8 == MaxY { print $1 }' MaxY=$MaxY | head -1`

  echo "    Wait time limits:"
  echo "      MinX:    $MinX"
  echo "      MaxX:    $MaxX"
  echo "      MinY:    $MinY"
  echo "      MaxY:    $MaxY"
  echo "      EPOCHMaxY: $EPOCHMaxY"


  ##
  ##  generate a single plot of Wait Time of all paths
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2500_waitMS"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  exec 4<${WorkDir}/tmp_gdg_iostatpaths
  while read -u4 IOPath
  do
    ##  echo "  Path ${IOPath}"
    DataFilePath=${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-${IOPath}.dat
    DataFile=`basename $DataFilePath`
    LegendText=${IOPath}

    ##  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinY}:${MaxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:8 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done
  exec 4<&-

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Wait Time for all Paths'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Wait Time for all Paths</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinY to $MaxY at `FromEpoch ${EPOCHMaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "  Service time"

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`

  MinY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $9 }' | sort -n | head -1`
  MaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $9 }' | sort -n | tail -1`
  ##  EPOCHMaxY=`grep ${MaxY} ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | tail -1 | awk -F\: '{ print $2 }'`
  EPOCHMaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk ' $9 == MaxY { print $1 }' MaxY=$MaxY | head -1`

  echo "    Service time limits:"
  echo "      MinX:    $MinX"
  echo "      MaxX:    $MaxX"
  echo "      MinY:    $MinY"
  echo "      MaxY:    $MaxY"
  echo "      EPOCHMaxY: $EPOCHMaxY"


  ##
  ##  generate a single plot of Service Time of all paths
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2500_serviceMS"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  exec 4<${WorkDir}/tmp_gdg_iostatpaths
  while read -u4 IOPath
  do
    ##  echo "  Path ${IOPath}"
    DataFilePath=${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-${IOPath}.dat
    DataFile=`basename $DataFilePath`
    LegendText=${IOPath}

    ##  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinY}:${MaxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:9 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done
  exec 4<&-

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Service Time for all Paths'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Service Time for all Paths</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinY to $MaxY at `FromEpoch ${EPOCHMaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "  Read K per Op"

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`

  MinY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $12 }' | egrep -v null | sort -n | head -1`
  MaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $12 }' | egrep -v null | sort -n | tail -1`
  ##  EPOCHMaxY=`grep ${MaxY} ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | egrep -v null | tail -1 | awk -F\: '{ print $2 }'`
  EPOCHMaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk ' $12 == MaxY { print $1 }' MaxY=$MaxY | head -1`

  echo "    Read K per Op limits:"
  echo "      MinX:    $MinX"
  echo "      MaxX:    $MaxX"
  echo "      MinY:    $MinY"
  echo "      MaxY:    $MaxY"
  echo "      EPOCHMaxY: $EPOCHMaxY"


  ##
  ##  generate a single plot of Read K per Op of all paths
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2500_ReadKperOP"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  exec 4<${WorkDir}/tmp_gdg_iostatpaths
  while read -u4 IOPath
  do
    ##  echo "  Path ${IOPath}"
    DataFilePath=${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-${IOPath}.dat
    DataFile=`basename $DataFilePath`
    LegendText=${IOPath}

    ##  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    ##  echo "set yrange [${MinY}:${MaxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [0:1500]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:12 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done
  exec 4<&-

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Read K per Operation for all Paths'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Read K per Operation for all Paths</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinY to $MaxY at `FromEpoch ${EPOCHMaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "  Write K per Op"

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`

  MinY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $13 }' | egrep -v null | sort -n | head -1`
  MaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $13 }' | egrep -v null | sort -n | tail -1`
  ##  EPOCHMaxY=`grep ${MaxY} ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | egrep -v null | tail -1 | awk -F\: '{ print $2 }'`
  EPOCHMaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk ' $13 == MaxY { print $1 }' MaxY=$MaxY | head -1`

  echo "    Write K per Op limits:"
  echo "      MinX:    $MinX"
  echo "      MaxX:    $MaxX"
  echo "      MinY:    $MinY"
  echo "      MaxY:    $MaxY"
  echo "      EPOCHMaxY: $EPOCHMaxY"


  ##
  ##  generate a single plot of Write K per Op of all paths
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2500_WritKperOP"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  exec 4<${WorkDir}/tmp_gdg_iostatpaths
  while read -u4 IOPath
  do
    ##  echo "  Path ${IOPath}"
    DataFilePath=${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-${IOPath}.dat
    DataFile=`basename $DataFilePath`
    LegendText=${IOPath}

    ##  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    ##  echo "set yrange [${MinY}:${MaxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [0:1500]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:13 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done
  exec 4<&-

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Write K per Operation for all Paths'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Write K per Operation for all Paths</a>" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "From $MinY to $MaxY at `FromEpoch ${EPOCHMaxY} 2>/dev/null`" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "  Average Read per Op"

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`

  MinY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $10 }' | sort -n | head -1`
  MaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $10 }' | sort -n | tail -1`
  ##  EPOCHMaxY=`grep ${MaxY} ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | tail -1 | awk -F\: '{ print $2 }'`
  EPOCHMaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk ' $10 == MaxY { print $1 }' MaxY=$MaxY | head -1`

  echo "    Average Read limits:"
  echo "      MinX:    $MinX"
  echo "      MaxX:    $MaxX"
  echo "      MinY:    $MinY"
  echo "      MaxY:    $MaxY"
  echo "      EPOCHMaxY: $EPOCHMaxY"


  ##
  ##  generate a single plot of Average Read of all paths
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2500_avgRead"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  exec 4<${WorkDir}/tmp_gdg_iostatpaths
  while read -u4 IOPath
  do
    ##  echo "  Path ${IOPath}"
    DataFilePath=${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-${IOPath}.dat
    DataFile=`basename $DataFilePath`
    LegendText=${IOPath}

    ##  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinY}:${MaxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:10 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done
  exec 4<&-

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Average Read for all Paths'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Average Read for all Paths</a>" >> ${WebDir}/index.html
  ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  ##  echo "From $MinY to $MaxY at `FromEpoch ${EPOCHMaxY} 2>/dev/null`" >> ${WebDir}/index.html
  ##  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##

  echo "  Average Write per Op"

  ##  find the ranges

  MinX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | head -1`
  MaxX=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | sort -n | tail -1`

  MinY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $11 }' | sort -n | head -1`
  MaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $11 }' | sort -n | tail -1`
  ##  EPOCHMaxY=`grep ${MaxY} ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $1 }' | tail -1 | awk -F\: '{ print $2 }'`
  EPOCHMaxY=`cat ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-*.dat | awk ' $11 == MaxY { print $1 }' MaxY=$MaxY | head -1`

  echo "    Average Write limits:"
  echo "      MinX:    $MinX"
  echo "      MaxX:    $MaxX"
  echo "      MinY:    $MinY"
  echo "      MaxY:    $MaxY"
  echo "      EPOCHMaxY: $EPOCHMaxY"


  ##
  ##  generate a single plot of Average Write of all paths
  ##

  GFileBase="${ServerName}_${StartTime}-${EndTime}_2500_avgWrit"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  plotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  ## echo "set logscale y" >> ${WorkDir}/${PlotScript}

  exec 4<${WorkDir}/tmp_gdg_iostatpaths
  while read -u4 IOPath
  do
    ##  echo "  Path ${IOPath}"
    DataFilePath=${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-${IOPath}.dat
    DataFile=`basename $DataFilePath`
    LegendText=${IOPath}

    ##  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}

    ##  create the plot entry to a temp file

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    ## echo "set xrange [${MinX}:${MaxX}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${MinY}:${MaxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFilePath}\" using 1:11 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##  increment stuff and loop again
    legendY=`expr $legendY - $legincY`
    plotIndex=`expr $plotIndex + 1`
  done
  exec 4<&-

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Average Write for all Paths'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null
  ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Average Write for all Paths</a>" >> ${WebDir}/index.html
  ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  ##  echo "From $MinY to $MaxY at `FromEpoch ${EPOCHMaxY} 2>/dev/null`" >> ${WebDir}/index.html
  ##  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##



}  ##  end of Mkplot_byLUN_local

##
##


