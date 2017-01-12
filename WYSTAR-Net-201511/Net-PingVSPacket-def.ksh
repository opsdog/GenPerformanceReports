##
##  functions for Net-PingVSPacket.ksh script
##

Make_Data_local()
{

  echo
  echo "Creating data files..."

  #############################################
  ##
  ##  source and destination ping times
  ##
  #############################################

  echo "  Ping Times   - ${SRCServerName} to $DESTServerName from $StartEpoch to $EndEpoch"

  ##  ${ProgPrefix}/NewQuery fsr "select esttime, ptmin from pingtime where serverid = ${ServerID} and ptintf = '${Interface}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/ping_timemin-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat
  ##  ${ProgPrefix}/NewQuery fsr "select esttime, ptavg from pingtime where serverid = ${ServerID} and ptintf = '${Interface}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/ping_timeavg-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat
  ##  ${ProgPrefix}/NewQuery fsr "select esttime, ptmax from pingtime where serverid = ${ServerID} and ptintf = '${Interface}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/ping_timemax-${ServerName}-${StartTime}_${EndTime}-${Interface}.dat

  ${ProgPrefix}/NewQuery fsr "select esttime, ptmin from pingtime where srcserverid = ${SRCServerID} and destserverid = ${DESTServerID} and srcserverintf = '${SRCServerIntf}' and destserverintf = '${DESTServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/ping_timemin-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat

  ${ProgPrefix}/NewQuery fsr "select esttime, ptavg from pingtime where srcserverid = ${SRCServerID} and destserverid = ${DESTServerID} and srcserverintf = '${SRCServerIntf}' and destserverintf = '${DESTServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat

  ${ProgPrefix}/NewQuery fsr "select esttime, ptmax from pingtime where srcserverid = ${SRCServerID} and destserverid = ${DESTServerID} and srcserverintf = '${SRCServerIntf}' and destserverintf = '${DESTServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/ping_timemax-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat


  #############################################
  ##
  ##  solaris netstat info for source interface
  ##
  #############################################

  if [ "${SRCServerOS}" = "SunOS" ]
  then
    echo "  NETstat Data - SRC  from $StartEpoch to $EndEpoch"

    ${ProgPrefix}/NewQuery fsr "select esttime, ipack, ierrs from netstat where serverid = ${SRCServerID} and intf = '${SRCServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/netstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, opack, oerrs, ocoll from netstat where serverid = ${SRCServerID} and intf = '${SRCServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/netstat_outputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, ( ipack + opack ) from netstat where serverid = ${SRCServerID} and intf = '${SRCServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/netstat_totalpac-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat


  fi  ##  if Solaris


  #############################################
  ##
  ##  solaris netstat info for destination interface
  ##
  #############################################

  if [ "${SRCServerOS}" = "SunOS" ]
  then
    echo "  NETstat Data - DEST from $StartEpoch to $EndEpoch"

    ${ProgPrefix}/NewQuery fsr "select esttime, ipack, ierrs from netstat where serverid = ${RealDESTServerID} and intf = '${DESTServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/netstat_inputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, opack, oerrs, ocoll from netstat where serverid = ${RealDESTServerID} and intf = '${DESTServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/netstat_outputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, ( ipack + opack ) from netstat where serverid = ${RealDESTServerID} and intf = '${DESTServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/netstat_totalpac-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat


  fi  ##  if Solaris


  #############################################
  ##
  ##  solaris nicstat info for source interface
  ##
  #############################################

  if [ "${SRCServerOS}" = "SunOS" ]
  then
    echo "  NICstat Data - SRC  from $StartEpoch to $EndEpoch"

    ${ProgPrefix}/NewQuery fsr "select esttime, nsrkb, ( nsrkb / 1024.0 ), nsutil  from nicstat where serverid = ${SRCServerID} and nsintf = '${SRCServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/nicstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, nswkb, ( nswkb / 1024.0 ) from nicstat where serverid = ${SRCServerID} and nsintf = '${SRCServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/nicstat_outputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, ( nsrkb / 1024.0 + nswkb / 1024.0 ) from nicstat where serverid = ${SRCServerID} and nsintf = '${SRCServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/nicstat_totalpac-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat


  fi  ##  if Solaris


  #############################################
  ##
  ##  solaris nicstat info for destination interface
  ##
  #############################################

  if [ "${SRCServerOS}" = "SunOS" ]
  then
    echo "  NICstat Data - DEST from $StartEpoch to $EndEpoch"

    ${ProgPrefix}/NewQuery fsr "select esttime, nsrkb, ( nsrkb / 1024.0 ), nsutil from nicstat where serverid = ${RealDESTServerID} and nsintf = '${DESTServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/nicstat_inputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, nswkb, ( nswkb / 1024.0 ) from nicstat where serverid = ${RealDESTServerID} and nsintf = '${DESTServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/nicstat_outputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat
    ${ProgPrefix}/NewQuery fsr "select esttime, ( nsrkb / 1024.0 + nswkb / 1024.0 ) from nicstat where serverid = ${RealDESTServerID} and nsintf = '${DESTServerIntf}' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/nicstat_totalpac-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat

  fi  ##  if Solaris

}  ##  end of Make_Data_local function


SetGraph2K()
{

  ##
  ##  set the parameters for a graph 2048 pixels on the long side
  ##

  resX=2048
  resY=1024

  sizeX=91
  sizeY=96

  LEGENDX=915
  LEGENDY=93
  LEGINCY=04

  legfontName="Georgia Bold"
  legfontSize=14

  TITLEX=507
  TITLEY=97

  titlefontName="Arial"
  titlefontSize=20

}  ##  end of SetGraph2K function

SetGraph4K()
{

  ##
  ##  set the parameters for a graph 4096 pixels on the long side
  ##

  resX=4096
  resY=2048

  sizeX=940
  sizeY=97

  LEGENDX=955
  LEGENDY=95
  LEGINCY=03

  legfontName="Georgia Bold"
  legfontSize=14

  TITLEX=511
  TITLEY=985

  titlefontName="Arial"
  titlefontSize=20

}  ##  end of SetGraph4K function

SetGraph8K()
{

  ##
  ##  set the parameters for a graph 8192 pixels on the long side
  ##

  resX=8192
  resY=4096

  sizeX=965
  sizeY=97

  LEGENDX=977
  LEGENDY=97
  LEGINCY=01

  legfontName="Georgia Bold"
  legfontSize=14

  TITLEX=51
  TITLEY=985

  titlefontName="Arial"
  titlefontSize=40

}  ##  end of SetGraph8K function

Mkplot_latency_all()
{

  echo "Creating latency plot scripts..."
  SetGraph2K

  ##  for Interface in `${ProgPrefix}/NewQuery fsr "select distinct ptintf from pingtime where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by ptintf"`
  ##  do

    GFileBase="${SRCServerName}-${DESTServerName}_${StartTime}-${EndTime}_0100_lat_${SRCServerIntf}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    PlotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    echo "set term jpeg size ${resX},${resY}" >> ${WorkDir}/${PlotScript}

    echo "set logscale y" >> ${WorkDir}/${PlotScript}

    ##  find the ranges

    minLATmin=`cat ${PlotDataDir}/ping_timemin-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxLATmin=`cat ${PlotDataDir}/ping_timemin-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minLATmax=`cat ${PlotDataDir}/ping_timemax-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxLATmax=`cat ${PlotDataDir}/ping_timemax-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "  from ${SRCServerName} (${SRCServerIntf}) to ${DESTServerName} (${DESTServerIntf})"
    ##  echo "    min min   : $minLATmin"
    ##  echo "    max min   : $maxLATmin"
    ##  echo "    min avg   : $minLATavg"
    ##  echo "    max avg   : $maxLATavg"
    ##  echo "    min max   : $minLATmax"
    ##  echo "    max max   : $maxLATmax"

    ##  check for 0 to 0 ranges and fix
    
    if [ $maxLATmin = 0 ]
    then
      maxLATmin=1
    fi

    if [ $maxLATavg = 0 ]
    then
      maxLATavg=1
    fi

    if [ $maxLATmax = 0 ]
    then
      maxLATmax=1
    fi

    ##  find the absolute min and max Y values

    if [ $maxLATmin -gt $maxLATavg ]
    then
      maxY=$maxLATmin
    else
      maxY=$maxLATavg
    fi

    if [ $maxLATmax -gt $maxY ]
    then
      maxY=$maxLATmax
    fi


    if [ $minLATmin -lt $minLATavg ]
    then
      minY=$minLATmin
    else
      minY=$minLATavg
    fi

    if [ $minLATmax -lt $minY ]
    then
      minY=$minLATmax
    fi

    ##  echo "    Y   from $minY to $maxY"

    ##
    ##  add the min latency to the graph
    ##

    DataFile=${PlotDataDir}/ping_timemin-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    LegendText="${SRCServerIntf} Min"
    LegendText="Min"

    echo "set label \"${LegendText} ms\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##
    ##  add the avg latency to the graph
    ##

    nextPlotIndex=`expr $PlotIndex + 1`
    PlotIndex=$nextPlotIndex

    DataFile=${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} Avg"
    LegendText="Avg"

    echo "set label \"${LegendText} ms\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##
    ##  add the max latency to the graph
    ##

    nextPlotIndex=`expr $PlotIndex + 1`
    PlotIndex=$nextPlotIndex

    DataFile=${PlotDataDir}/ping_timemax-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} Max"
    LegendText="Max"

    echo "set label '${LegendText} ms' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##
    ##  finish the plot file
    ##

    echo >> ${WorkDir}/${PlotScript}
    ##  echo "set multiplot title '${SRCServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - ${SRCServerIntf} to ${DESTServerIntf} Network Latency (ms) - Log Scale'" >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${SRCServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - Network Latency (ms) - Log Scale'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

    rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

    echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Latency</a>:" >> ${WebDir}/index.html
    echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    echo "Minimum latency from $minLATmin to $maxLATmin <br>" >> ${WebDir}/index.html
    echo "Average latency from $minLATavg to $maxLATavg <br>" >> ${WebDir}/index.html
    echo "Maximum latency from $minLATmax to $maxLATmax" >> ${WebDir}/index.html
    echo "</blockquote>" >> ${WebDir}/index.html

  ##  done  ##  for each Interface

  ##
  ##  now do avg latency for all interfaces
  ##

  GFileBase="${SRCServerName}-${DESTServerName}_${StartTime}-${EndTime}_0100_lat_ZZALL"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  PlotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  echo "set logscale y" >> ${WorkDir}/${PlotScript}

  ##  find the ranges

  minLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | head -1`
  maxLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-*.dat | awk '{ print $2 }' | sort -un | tail -1`

  ##  echo "  Interface : ALL"
  ##  echo "    min avg   : $minLATavg"
  ##  echo "    max avg   : $maxLATavg"

  ##  check for 0 to 0 ranges and fix
    
  if [ $maxLATavg = 0 ]
  then
    maxLATavg=1
  fi

  minY=$minLATavg
  maxY=$maxLATavg

  ##  echo "    Y   from $minY to $maxY"

  ##
  ##  add the avg latency to the graph
  ##

  PlotIndex=1
  for DataFile in ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-*.dat
  do
    echo `basename $DataFile` | awk -F\. '{ print $1 }' | awk -F\- '{ print $NF }' | read LegendText

    ##  echo "set label \"${LegendText} avg ms\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    echo "set label \"avg ms\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex}" >> ${WorkDir}/${PlotScript}.$$

    nextPlotIndex=`expr $PlotIndex + 1`
    PlotIndex=$nextPlotIndex

  done  ##  for each data file

  ##
  ##  finish the plot file
  ##

  echo >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${SRCServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - Average Network Latency (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Average Latency</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "Average latency from $minLATavg to $maxLATavg" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

}  ##  end of Mkplot_latency_all function


Mkplot_packetcount_all()
{

  echo "Creating packet count plot scripts..."
  SetGraph4K

  ##  for Interface in `${ProgPrefix}/NewQuery fsr "select distinct ptintf from pingtime where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by ptintf"`
  ##  do

    GFileBase="${SRCServerName}-${DESTServerName}_${StartTime}-${EndTime}_0200_pac_${SRCServerIntf}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    PlotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ##  find the ranges

    minPACipack=`cat ${PlotDataDir}/netstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxPACipack=`cat ${PlotDataDir}/netstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minPACopack=`cat ${PlotDataDir}/netstat_outputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxPACopack=`cat ${PlotDataDir}/netstat_outputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`


    ##  echo "  ${SRCServerName} (${SRCServerIntf}) to ${DESTServerName} (${DESTServerIntf})"
    ##  echo "    ipack min : $minPACipack"
    ##  echo "    ipack max : $maxPACipack"
    ##  echo "    opack min : $minPACopack"
    ##  echo "    opack max : $maxPACopack"


    ##  check for 0 to 0 ranges and fix
    
    if [ $maxPACipack = 0 ]
    then
      maxPACipack=1
    fi

    if [ $maxPACopack = 0 ]
    then
      maxPACopack=1
    fi

    ##  find the absolute min and max Y values

    if [ $maxPACipack -gt $maxPACopack ]
    then
      maxY=$maxPACipack
    else
      maxY=$maxPACopack
    fi


    if [ $minPACipack -lt $minPACopack ]
    then
      minY=$minPACipack
    else
      minY=$minPACopack
    fi

    ##  echo "    Y   from $minY to $maxY"

    ##
    ##  add the input packet count to the graph
    ##

    DataFile=${PlotDataDir}/netstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} IN packets"
    LegendText="IN packets"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex}" >> ${WorkDir}/${PlotScript}.$$

    ##
    ##  add the output packet count to the graph
    ##

    nextPlotIndex=`expr $PlotIndex + 1`
    PlotIndex=$nextPlotIndex

    DataFile=${PlotDataDir}/netstat_outputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} OUT packets"
    LegendText="OUT packets"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex}" >> ${WorkDir}/${PlotScript}.$$


    ##
    ##  finish the plot file
    ##

    echo >> ${WorkDir}/${PlotScript}
    ##  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ${Interface} Input and Output packets (count)'" >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${SRCServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - Input and Output packets (count)'" >> ${WorkDir}/${PlotScript}
    echo "set xtics format \"\"" >> ${WorkDir}/${PlotScript}
    cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

    rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

    echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Packet Counts</a>:" >> ${WebDir}/index.html
    echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    echo "Input packets from $minPACipack to $maxPACipack <br>" >> ${WebDir}/index.html
    echo "Output packets from $minPACopack to $maxPACopack" >> ${WebDir}/index.html
    echo "</blockquote>" >> ${WebDir}/index.html

  ##  done  ##  for each Interface


}  ##  end of Mkplot_packetcount_all function


Mkplot_packetVSlatency_src()
{

  echo "Creating SRC input and output packets vs latency plot scripts..."
  SetGraph4K

  ##  for Interface in `${ProgPrefix}/NewQuery fsr "select distinct ptintf from pingtime where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by ptintf"`
  ##  do

    GFileBase="${SRCServerName}-${DESTServerName}_${StartTime}-${EndTime}_0300_paclat_${SRCServerIntf}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    PlotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ##  find the ranges

    minPACLATipack=`cat ${PlotDataDir}/netstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxPACLATipack=`cat ${PlotDataDir}/netstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minPACLATopack=`cat ${PlotDataDir}/netstat_outputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxPACLATopack=`cat ${PlotDataDir}/netstat_outputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "  ${SRCServerName} (${SRCServerIntf}) to ${DESTServerName} (${DESTServerIntf})"
    ##  echo "    ipack min : $minPACLATipack"
    ##  echo "    ipack max : $maxPACLATipack"
    ##  echo "    opack min : $minPACLATopack"
    ##  echo "    opack max : $maxPACLATopack"
    ##  echo "    avg min   : $minPACLATavg"
    ##  echo "    avg max   : $maxPACLATavg"

    ##  check for 0 to 0 ranges and fix
    
    if [ $maxPACLATipack = 0 ]
    then
      maxPACLATipack=1
    fi

    if [ $maxPACLATopack = 0 ]
    then
      maxPACLATopack=1
    fi

    if [ $maxPACLATavg = 0 ]
    then
      maxPCALATavg=1
    fi

    ##  find the absolute min and max Y values

    if [ $maxPACLATipack -gt $maxPACLATopack ]
    then
      maxY=$maxPACLATipack
    else
      maxY=$maxPACLATopack
    fi


    if [ $minPACLATipack -lt $minPACLATopack ]
    then
      minY=$minPACLATipack
    else
      minY=$minPACLATopack
    fi

    ##  echo "    Y   from $minY to $maxY"

    ##
    ##  add the source server/interface input packet count to the graph
    ##

    DataFile=${PlotDataDir}/netstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} IN packets"
    LegendText="IN packets"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    echo "set y2tics" >> ${WorkDir}/${PlotScript}.$$
    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set y2range [${minPACLATavg}:${maxPACLATavg}]" >> ${WorkDir}/${PlotScript}.$$

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex}axes x1y1" >> ${WorkDir}/${PlotScript}.$$

    ##
    ##  add the source server/interface output packet count to the graph
    ##

    nextPlotIndex=`expr $PlotIndex + 1`
    PlotIndex=$nextPlotIndex

    DataFile=${PlotDataDir}/netstat_outputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} OUT packets"
    LegendText="OUT packets"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$

    ##
    ##  add the connection latency to y2
    ##

    nextPlotIndex=`expr $PlotIndex + 1`
    PlotIndex=$nextPlotIndex

    DataFile=${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} latency"
    LegendText="Latency"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex} axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    ##
    ##  finish the plot file
    ##

    echo >> ${WorkDir}/${PlotScript}
    ##  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ${Interface} Input and Output packets (count) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${SRCServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - Input and Output packets (count) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
    cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

    rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

    echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${SRCServerName}:${SRCServerIntf}  Input and Output Packet Counts vs Latency</a>:" >> ${WebDir}/index.html
    echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    echo "Input packets from $minPACLATipack to $maxPACLATipack <br>" >> ${WebDir}/index.html
    echo "Output packets from $minPACLATopack to $maxPACLATopack <br>" >> ${WebDir}/index.html
    echo "Latency from $minPACLATavg to $maxPACLATavg" >> ${WebDir}/index.html
    echo "</blockquote>" >> ${WebDir}/index.html

  ##  done  ##  for each Interface

  ##
  ##  now do total packets against latency
  ##

  echo "Creating SRC total packets vs latency plot scripts..."

  ##  for Interface in `${ProgPrefix}/NewQuery fsr "select distinct ptintf from pingtime where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by ptintf"`
  ##  do

    GFileBase="${SRCServerName}-${DESTServerName}_${StartTime}-${EndTime}_0400_paclat_tot${SRCServerIntf}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    PlotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ##  find the ranges

    minPACLATpack=`cat ${PlotDataDir}/netstat_totalpac-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxPACLATpack=`cat ${PlotDataDir}/netstat_totalpac-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "  ${SRCServerName} (${SRCServerIntf}) to ${DESTServerName} (${DESTServerIntf})"
    ##  echo "    pack min : $minPACLATpack"
    ##  echo "    pack max : $maxPACLATpack"
    ##  echo "    avg min  : $minPACLATavg"
    ##  echo "    avg max  : $maxPACLATavg"

    ##  check for 0 to 0 ranges and fix
    
    if [ $maxPACLATpack = 0 ]
    then
      maxPACLATpack=1
    fi

    if [ $maxPACLATavg = 0 ]
    then
      maxPCALATavg=1
    fi

    ##  find the absolute min and max Y values

    minY=$minPACLATpack
    maxY=$maxPACLATpack

    ##  echo "    Y   from $minY to $maxY"

    ##
    ##  add the source server/interface total packet count to the graph
    ##

    DataFile=${PlotDataDir}/netstat_totalpac-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} TOT packets"
    LegendText="TOT packets"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    echo "set y2tics" >> ${WorkDir}/${PlotScript}.$$
    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set y2range [${minPACLATavg}:${maxPACLATavg}]" >> ${WorkDir}/${PlotScript}.$$

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex}axes x1y1" >> ${WorkDir}/${PlotScript}.$$

    ##
    ##  add the connection latency to y2
    ##

    nextPlotIndex=`expr $PlotIndex + 1`
    PlotIndex=$nextPlotIndex

    DataFile=${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} latency"
    LegendText="Latency"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex} axes x1y2" >> ${WorkDir}/${PlotScript}.$$


    ##
    ##  finish the plot file
    ##

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${SRCServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - Source TOTAL packets (count) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
    cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

    rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

    echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${SRCServerName}:${SRCServerIntf}  Total Packet Counts vs Latency</a>:" >> ${WebDir}/index.html
    echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    echo "Total packets from $minPACLATpack to $maxPACLATpack <br>" >> ${WebDir}/index.html
    echo "Latency from $minPACLATavg to $maxPACLATavg" >> ${WebDir}/index.html
    echo "</blockquote>" >> ${WebDir}/index.html

  ##  done  ##  for each Interface

}  ## end of Mkplot_packetVSlatency_src function

Mkplot_packetVSlatency_dest()
{

  echo "Creating DEST input and output packets vs latency plot scripts..."
  SetGraph4K

  ##  for Interface in `${ProgPrefix}/NewQuery fsr "select distinct ptintf from pingtime where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by ptintf"`
  ##  do

    GFileBase="${DESTServerName}-${DESTServerName}_${StartTime}-${EndTime}_0300_paclat_${DESTServerIntf}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    PlotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ##  find the ranges

    minPACLATipack=`cat ${PlotDataDir}/netstat_inputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxPACLATipack=`cat ${PlotDataDir}/netstat_inputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minPACLATopack=`cat ${PlotDataDir}/netstat_outputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxPACLATopack=`cat ${PlotDataDir}/netstat_outputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "  ${DESTServerName} (${DESTServerIntf}) to ${DESTServerName} (${DESTServerIntf})"
    ##  echo "    ipack min : $minPACLATipack"
    ##  echo "    ipack max : $maxPACLATipack"
    ##  echo "    opack min : $minPACLATopack"
    ##  echo "    opack max : $maxPACLATopack"
    ##  echo "    avg min   : $minPACLATavg"
    ##  echo "    avg max   : $maxPACLATavg"

    ##  check for 0 to 0 ranges and fix
    
    if [ $maxPACLATipack = 0 ]
    then
      maxPACLATipack=1
    fi

    if [ $maxPACLATopack = 0 ]
    then
      maxPACLATopack=1
    fi

    if [ $maxPACLATavg = 0 ]
    then
      maxPCALATavg=1
    fi

    ##  find the absolute min and max Y values

    if [ $maxPACLATipack -gt $maxPACLATopack ]
    then
      maxY=$maxPACLATipack
    else
      maxY=$maxPACLATopack
    fi


    if [ $minPACLATipack -lt $minPACLATopack ]
    then
      minY=$minPACLATipack
    else
      minY=$minPACLATopack
    fi

    ##  echo "    Y   from $minY to $maxY"

    ##
    ##  add the source server/interface input packet count to the graph
    ##

    DataFile=${PlotDataDir}/netstat_inputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} IN packets"
    LegendText="IN packets"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    echo "set y2tics" >> ${WorkDir}/${PlotScript}.$$
    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set y2range [${minPACLATavg}:${maxPACLATavg}]" >> ${WorkDir}/${PlotScript}.$$

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex}axes x1y1" >> ${WorkDir}/${PlotScript}.$$

    ##
    ##  add the source server/interface output packet count to the graph
    ##

    nextPlotIndex=`expr $PlotIndex + 1`
    PlotIndex=$nextPlotIndex

    DataFile=${PlotDataDir}/netstat_outputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} OUT packets"
    LegendText="OUT packets"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex} axes x1y1" >> ${WorkDir}/${PlotScript}.$$

    ##
    ##  add the connection latency to y2
    ##

    nextPlotIndex=`expr $PlotIndex + 1`
    PlotIndex=$nextPlotIndex

    DataFile=${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} latency"
    LegendText="Latency"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex} axes x1y2" >> ${WorkDir}/${PlotScript}.$$

    ##
    ##  finish the plot file
    ##

    echo >> ${WorkDir}/${PlotScript}
    ##  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ${Interface} Input and Output packets (count) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${DESTServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - Input and Output packets (count) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
    cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

    rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

    echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${DESTServerName}:${DESTServerIntf}  Input and Output Packet Counts vs Latency</a>:" >> ${WebDir}/index.html
    echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    echo "Input packets from $minPACLATipack to $maxPACLATipack <br>" >> ${WebDir}/index.html
    echo "Output packets from $minPACLATopack to $maxPACLATopack <br>" >> ${WebDir}/index.html
    echo "Latency from $minPACLATavg to $maxPACLATavg" >> ${WebDir}/index.html
    echo "</blockquote>" >> ${WebDir}/index.html

  ##  done  ##  for each Interface

  ##
  ##  now do total packets against latency
  ##

  echo "Creating DEST total packets vs latency plot scripts..."

  ##  for Interface in `${ProgPrefix}/NewQuery fsr "select distinct ptintf from pingtime where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by ptintf"`
  ##  do

    GFileBase="${DESTServerName}-${DESTServerName}_${StartTime}-${EndTime}_0400_paclat_tot${DESTServerIntf}"
    PlotScript="${GFileBase}.gplot"
    rm -f ${WorkDir}/${PlotScript} 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    PlotIndex=1

    ##  create the gnuplot script header

    Echo_Header > ${WorkDir}/${PlotScript}

    ##  find the ranges

    minPACLATpack=`cat ${PlotDataDir}/netstat_totalpac-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxPACLATpack=`cat ${PlotDataDir}/netstat_totalpac-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    minPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
    maxPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "  ${DESTServerName} (${DESTServerIntf}) to ${DESTServerName} (${DESTServerIntf})"
    ##  echo "    pack min : $minPACLATpack"
    ##  echo "    pack max : $maxPACLATpack"
    ##  echo "    avg min  : $minPACLATavg"
    ##  echo "    avg max  : $maxPACLATavg"

    ##  check for 0 to 0 ranges and fix
    
    if [ $maxPACLATpack = 0 ]
    then
      maxPACLATpack=1
    fi

    if [ $maxPACLATavg = 0 ]
    then
      maxPCALATavg=1
    fi

    ##  find the absolute min and max Y values

    minY=$minPACLATpack
    maxY=$maxPACLATpack

    ##  echo "    Y   from $minY to $maxY"

    ##
    ##  add the source server/interface total packet count to the graph
    ##

    DataFile=${PlotDataDir}/netstat_totalpac-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} TOT packets"
    LegendText="TOT packets"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "unset xtics" >> ${WorkDir}/${PlotScript}
    echo "unset x2tics" >> ${WorkDir}/${PlotScript}
    echo "set y2tics" >> ${WorkDir}/${PlotScript}.$$
    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
    echo "set y2range [${minPACLATavg}:${maxPACLATavg}]" >> ${WorkDir}/${PlotScript}.$$

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex}axes x1y1" >> ${WorkDir}/${PlotScript}.$$

    ##
    ##  add the connection latency to y2
    ##

    nextPlotIndex=`expr $PlotIndex + 1`
    PlotIndex=$nextPlotIndex

    DataFile=${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
    LegendText="${Interface} latency"
    LegendText="Latency"

    echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
    nextLegend=`expr $legendY - $legincY`
    legendY=$nextLegend

    echo >> ${WorkDir}/${PlotScript}.$$
    echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
    echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
    echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex} axes x1y2" >> ${WorkDir}/${PlotScript}.$$


    ##
    ##  finish the plot file
    ##

    echo >> ${WorkDir}/${PlotScript}
    echo "set multiplot title '${SRCServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - Destination TOTAL packets (count) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
    cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

    rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

    echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${DESTServerName}:${DESTServerIntf}  Total Packet Counts vs Latency</a>:" >> ${WebDir}/index.html
    echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    echo "Total packets from $minPACLATpack to $maxPACLATpack <br>" >> ${WebDir}/index.html
    echo "Latency from $minPACLATavg to $maxPACLATavg" >> ${WebDir}/index.html
    echo "</blockquote>" >> ${WebDir}/index.html

  ##  done  ##  for each Interface

}  ## end of Mkplot_packetVSlatency_dest function

Mkplot_nicutilVSlatency_src()
(
  echo "Creating SRC NIC utilization vs latency plot scripts..."
  SetGraph4K

  ##
  ##  total utilization plot vs latency
  ##

  GFileBase="${SRCServerName}-${DESTServerName}_${StartTime}-${EndTime}_0300_utillat_${SRCServerIntf}"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  PlotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  minPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minUTIL=`cat ${PlotDataDir}/nicstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $4 }' | sort -un | head -1`
  maxUTIL=`cat ${PlotDataDir}/nicstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $4 }' | sort -un | tail -1`


  ##  echo "  ${SRCServerName} (${SRCServerIntf}) to ${DESTServerName} (${DESTServerIntf})"
  ##  echo "    avg min   : $minPACLATavg"
  ##  echo "    avg max   : $maxPACLATavg"
  ##  echo "    util min  : $minUTIL"
  ##  echo "    util max  : $maxUTIL"

  if [ $maxPACLATavg = 0 ]
  then
    maxPCALATavg=1
  fi

  if [ $maxUTIL = 0 ]
  then
    maxUTIL=1
  fi

  ##  add the NIC utiliization to the graph (y1)

  DataFile=${PlotDataDir}/nicstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
  LegendText="NIC Utilization"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "set y2tics" >> ${WorkDir}/${PlotScript}.$$
  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minUTIL}:${maxUTIL}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set y2range [${minPACLATavg}:${maxPACLATavg}]" >> ${WorkDir}/${PlotScript}.$$

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:4 title '${LegendText}' with linespoints linestyle ${PlotIndex}axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  nextPlotIndex=`expr $PlotIndex + 1`
  PlotIndex=$nextPlotIndex

  ##  add the latency to the plot (y2)

  DataFile=${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
  LegendText="${Interface} latency"
  LegendText="Latency"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex} axes x1y2" >> ${WorkDir}/${PlotScript}.$$

  ##  finish the plot file

  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ${Interface} Input and Output packets (count) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${SRCServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - Source NIC utilization (percent) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${SRCServerName}:${SRCServerIntf} NIC Utilization vs Latency</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "NIC utilization from $minUTIL to $maxUTIL <br>" >> ${WebDir}/index.html
  echo "Latency from $minPACLATavg to $maxPACLATavg" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  input and output Mb/sec vs latency
  ##

  GFileBase="${SRCServerName}-${DESTServerName}_${StartTime}-${EndTime}_0300_iomblat_${SRCServerIntf}"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  PlotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  minPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minRMB=`cat ${PlotDataDir}/nicstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $3 }' | sort -un | head -1`
  maxRMB=`cat ${PlotDataDir}/nicstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $3 }' | sort -un | tail -1`

  minWMB=`cat ${PlotDataDir}/nicstat_outputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $3 }' | sort -un | head -1`
  maxWMB=`cat ${PlotDataDir}/nicstat_outputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $3 }' | sort -un | tail -1`

  if [ $maxPACLATavg = 0 ]
  then
    maxPCALATavg=1
  fi

  if [ $maxRMB = 0 ]
  then
    maxRMB=1
  fi

  if [ $maxWMB = 0 ]
  then
    maxWMB=1
  fi

  if [ $maxRMB -gt $maxWMB ]
  then
    maxY=$maxRMB
  else
    maxY=$maxWMB
  fi

  if [ $minRMB -lt $minWMB ]
  then
    minY=$minRMB
  else
    minY=$minWMB
  fi

  ##  echo "  ${SRCServerName} (${SRCServerIntf}) to ${DESTServerName} (${DESTServerIntf})"
  ##  echo "    avg min   : $minPACLATavg"
  ##  echo "    avg max   : $maxPACLATavg"
  ##  echo "    Rmb min   : $minRMB"
  ##  echo "    Rmb max   : $maxRMB"
  ##  echo "    Wmb min   : $minWMB"
  ##  echo "    Wmb max   : $maxWMB"
  ##  echo "    Y min     : $minY"
  ##  echo "    Y max     : $maxY"


  ##  add the input mb/sec to the graph (y1)

  DataFile=${PlotDataDir}/nicstat_inputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
  LegendText="Read MB/sec"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "set y2tics" >> ${WorkDir}/${PlotScript}.$$
  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set y2range [${minPACLATavg}:${maxPACLATavg}]" >> ${WorkDir}/${PlotScript}.$$

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:3 title '${LegendText}' with linespoints linestyle ${PlotIndex}axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  nextPlotIndex=`expr $PlotIndex + 1`
  PlotIndex=$nextPlotIndex

  ##  add the output mb/sec to the graph (y1)

  DataFile=${PlotDataDir}/nicstat_outputstats-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
  LegendText="Write MB/sec"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "set y2tics" >> ${WorkDir}/${PlotScript}.$$
  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set y2range [${minPACLATavg}:${maxPACLATavg}]" >> ${WorkDir}/${PlotScript}.$$

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:3 title '${LegendText}' with linespoints linestyle ${PlotIndex}axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  nextPlotIndex=`expr $PlotIndex + 1`
  PlotIndex=$nextPlotIndex

  ##  add the latency to the plot (y2)

  DataFile=${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
  LegendText="${Interface} latency"
  LegendText="Latency"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex} axes x1y2" >> ${WorkDir}/${PlotScript}.$$

  ##  finish the plot file

  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ${Interface} Input and Output packets (count) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${SRCServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - Source NIC Input and Output Througput (MB/sec) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${SRCServerName}:${SRCServerIntf} NIC Input and Output MB/sec vs Latency</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "NIC utilization from $minUTIL to $maxUTIL <br>" >> ${WebDir}/index.html
  echo "Latency from $minPACLATavg to $maxPACLATavg" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  total MB/sec vs latency
  ##

  GFileBase="${SRCServerName}-${DESTServerName}_${StartTime}-${EndTime}_0300_totmblat_${SRCServerIntf}"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  PlotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  minPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minTOTMB=`cat ${PlotDataDir}/nicstat_totalpac-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxTOTMB=`cat ${PlotDataDir}/nicstat_totalpac-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxPACLATavg = 0 ]
  then
    maxPCALATavg=1
  fi

  ##  echo "  ${SRCServerName} (${SRCServerIntf}) to ${DESTServerName} (${DESTServerIntf})"
  ##  echo "    avg min   : $minPACLATavg"
  ##  echo "    avg max   : $maxPACLATavg"
  ##  echo "    TOTmb min : $minTOTMB"
  ##  echo "    TOTmb max : $maxTOTMB"

  ##  add the total mb/sec to the graph (y1)

  DataFile=${PlotDataDir}/nicstat_totalpac-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
  LegendText="Total MB/sec"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "set y2tics" >> ${WorkDir}/${PlotScript}.$$
  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minTOTMB}:${maxTOTMB}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set y2range [${minPACLATavg}:${maxPACLATavg}]" >> ${WorkDir}/${PlotScript}.$$

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex}axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  nextPlotIndex=`expr $PlotIndex + 1`
  PlotIndex=$nextPlotIndex

  ##  add the latency to the plot (y2)

  DataFile=${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
  LegendText="${Interface} latency"
  LegendText="Latency"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex} axes x1y2" >> ${WorkDir}/${PlotScript}.$$

  ##  finish the plot file

  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ${Interface} Input and Output packets (count) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${SRCServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - Source NIC Total Througput (MB/sec) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${SRCServerName}:${SRCServerIntf} NIC Total MB/sec vs Latency</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "NIC utilization from $minUTIL to $maxUTIL <br>" >> ${WebDir}/index.html
  echo "Latency from $minPACLATavg to $maxPACLATavg" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

)  ##  end of function Mkplot_nicutilVSlatency_src

Mkplot_nicutilVSlatency_dest()
(
  echo "Creating DEST NIC utilization vs latency plot scripts..."
  SetGraph4K

  ##
  ##  total utilization plot vs latency
  ##

  GFileBase="${DESTServerName}-${DESTServerName}_${StartTime}-${EndTime}_0300_utillat_${SRCServerIntf}"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  PlotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  minPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minUTIL=`cat ${PlotDataDir}/nicstat_inputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $4 }' | sort -un | head -1`
  maxUTIL=`cat ${PlotDataDir}/nicstat_inputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $4 }' | sort -un | tail -1`


  ##  echo "  ${DESTServerName} (${SRCServerIntf}) to ${DESTServerName} (${DESTServerIntf})"
  ##  echo "    avg min   : $minPACLATavg"
  ##  echo "    avg max   : $maxPACLATavg"
  ##  echo "    util min  : $minUTIL"
  ##  echo "    util max  : $maxUTIL"

  if [ $maxPACLATavg = 0 ]
  then
    maxPCALATavg=1
  fi

  if [ $maxUTIL = 0 ]
  then
    maxUTIL=1
  fi

  ##  add the NIC utiliization to the graph (y1)

  DataFile=${PlotDataDir}/nicstat_inputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat
  LegendText="NIC Utilization"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "set y2tics" >> ${WorkDir}/${PlotScript}.$$
  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minUTIL}:${maxUTIL}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set y2range [${minPACLATavg}:${maxPACLATavg}]" >> ${WorkDir}/${PlotScript}.$$

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:4 title '${LegendText}' with linespoints linestyle ${PlotIndex}axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  nextPlotIndex=`expr $PlotIndex + 1`
  PlotIndex=$nextPlotIndex

  ##  add the latency to the plot (y2)

  DataFile=${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
  LegendText="${Interface} latency"
  LegendText="Latency"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex} axes x1y2" >> ${WorkDir}/${PlotScript}.$$

  ##  finish the plot file

  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ${Interface} Input and Output packets (count) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${SRCServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - Destination NIC utilization (percent) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${DESTServerName}:${DESTServerIntf} NIC Utilization vs Latency</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "NIC utilization from $minUTIL to $maxUTIL <br>" >> ${WebDir}/index.html
  echo "Latency from $minPACLATavg to $maxPACLATavg" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  input and output Mb/sec vs latency
  ##

  GFileBase="${DESTServerName}-${DESTServerName}_${StartTime}-${EndTime}_0300_iomblat_${SRCServerIntf}"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  PlotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  minPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minRMB=`cat ${PlotDataDir}/nicstat_inputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $3 }' | sort -un | head -1`
  maxRMB=`cat ${PlotDataDir}/nicstat_inputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $3 }' | sort -un | tail -1`

  minWMB=`cat ${PlotDataDir}/nicstat_outputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $3 }' | sort -un | head -1`
  maxWMB=`cat ${PlotDataDir}/nicstat_outputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $3 }' | sort -un | tail -1`

  if [ $maxPACLATavg = 0 ]
  then
    maxPCALATavg=1
  fi

  if [ $maxRMB = 0 ]
  then
    maxRMB=1
  fi

  if [ $maxWMB = 0 ]
  then
    maxWMB=1
  fi

  if [ $maxRMB -gt $maxWMB ]
  then
    maxY=$maxRMB
  else
    maxY=$maxWMB
  fi

  if [ $minRMB -lt $minWMB ]
  then
    minY=$minRMB
  else
    minY=$minWMB
  fi

  ##  echo "  ${DESTServerName} (${SRCServerIntf}) to ${DESTServerName} (${DESTServerIntf})"
  ##  echo "    avg min   : $minPACLATavg"
  ##  echo "    avg max   : $maxPACLATavg"
  ##  echo "    Rmb min   : $minRMB"
  ##  echo "    Rmb max   : $maxRMB"
  ##  echo "    Wmb min   : $minWMB"
  ##  echo "    Wmb max   : $maxWMB"
  ##  echo "    Y min     : $minY"
  ##  echo "    Y max     : $maxY"


  ##  add the input mb/sec to the graph (y1)

  DataFile=${PlotDataDir}/nicstat_inputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat
  LegendText="Read MB/sec"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "set y2tics" >> ${WorkDir}/${PlotScript}.$$
  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set y2range [${minPACLATavg}:${maxPACLATavg}]" >> ${WorkDir}/${PlotScript}.$$

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:3 title '${LegendText}' with linespoints linestyle ${PlotIndex}axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  nextPlotIndex=`expr $PlotIndex + 1`
  PlotIndex=$nextPlotIndex

  ##  add the output mb/sec to the graph (y1)

  DataFile=${PlotDataDir}/nicstat_outputstats-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat
  LegendText="Write MB/sec"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "set y2tics" >> ${WorkDir}/${PlotScript}.$$
  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minY}:${maxY}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set y2range [${minPACLATavg}:${maxPACLATavg}]" >> ${WorkDir}/${PlotScript}.$$

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:3 title '${LegendText}' with linespoints linestyle ${PlotIndex}axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  nextPlotIndex=`expr $PlotIndex + 1`
  PlotIndex=$nextPlotIndex

  ##  add the latency to the plot (y2)

  DataFile=${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
  LegendText="${Interface} latency"
  LegendText="Latency"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex} axes x1y2" >> ${WorkDir}/${PlotScript}.$$

  ##  finish the plot file

  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ${Interface} Input and Output packets (count) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${SRCServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - Destination NIC Input and Output Througput (MB/sec) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${DESTServerName}:${DESTServerIntf} NIC Input and Output MB/sec vs Latency</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "NIC utilization from $minUTIL to $maxUTIL <br>" >> ${WebDir}/index.html
  echo "Latency from $minPACLATavg to $maxPACLATavg" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

  ##
  ##  total MB/sec vs latency
  ##

  GFileBase="${DESTServerName}-${DESTServerName}_${StartTime}-${EndTime}_0300_totmblat_${SRCServerIntf}"
  PlotScript="${GFileBase}.gplot"
  rm -f ${WorkDir}/${PlotScript} 2>/dev/null
  legendX=$LEGENDX
  legendY=$LEGENDY
  legincY=$LEGINCY
  PlotIndex=1

  ##  create the gnuplot script header

  Echo_Header > ${WorkDir}/${PlotScript}

  minPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxPACLATavg=`cat ${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

  minTOTMB=`cat ${PlotDataDir}/nicstat_totalpac-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | head -1`
  maxTOTMB=`cat ${PlotDataDir}/nicstat_totalpac-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat | awk '{ print $2 }' | sort -un | tail -1`

  if [ $maxPACLATavg = 0 ]
  then
    maxPCALATavg=1
  fi

  ##  echo "  ${DESTServerName} (${SRCServerIntf}) to ${DESTServerName} (${DESTServerIntf})"
  ##  echo "    avg min   : $minPACLATavg"
  ##  echo "    avg max   : $maxPACLATavg"
  ##  echo "    TOTmb min : $minTOTMB"
  ##  echo "    TOTmb max : $maxTOTMB"

  ##  add the total mb/sec to the graph (y1)

  DataFile=${PlotDataDir}/nicstat_totalpac-${DESTServerName}_${DESTServerName}-${StartTime}_${EndTime}-${DESTServerIntf}_${DESTServerIntf}.dat
  LegendText="Total MB/sec"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "unset xtics" >> ${WorkDir}/${PlotScript}
  echo "unset x2tics" >> ${WorkDir}/${PlotScript}
  echo "set y2tics" >> ${WorkDir}/${PlotScript}.$$
  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set xrange [${StartEpoch}:${EndEpoch}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set yrange [${minTOTMB}:${maxTOTMB}]" >> ${WorkDir}/${PlotScript}.$$
  echo "set y2range [${minPACLATavg}:${maxPACLATavg}]" >> ${WorkDir}/${PlotScript}.$$

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex}axes x1y1" >> ${WorkDir}/${PlotScript}.$$

  nextPlotIndex=`expr $PlotIndex + 1`
  PlotIndex=$nextPlotIndex

  ##  add the latency to the plot (y2)

  DataFile=${PlotDataDir}/ping_timeavg-${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}-${SRCServerIntf}_${DESTServerIntf}.dat
  LegendText="${Interface} latency"
  LegendText="Latency"

  echo "set label '${LegendText}' at screen 0.${legendX},0.${legendY} front textcolor linestyle ${PlotIndex} font \"${legfontName},$legfontSize\"" >> ${WorkDir}/${PlotScript}
  nextLegend=`expr $legendY - $legincY`
  legendY=$nextLegend

  echo >> ${WorkDir}/${PlotScript}.$$
  echo "set origin 0.${originX},0.${originY}" >> ${WorkDir}/${PlotScript}.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> ${WorkDir}/${PlotScript}.$$
  echo "plot \"${DataFile}\" using 1:2 title '${LegendText}' with linespoints linestyle ${PlotIndex} axes x1y2" >> ${WorkDir}/${PlotScript}.$$

  ##  finish the plot file

  echo >> ${WorkDir}/${PlotScript}
  ##  echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - ${Interface} Input and Output packets (count) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
  echo "set multiplot title '${SRCServerName} to ${DESTServerName} - ${StartTime} to ${EndTime} - Destination NIC Total Througput (MB/sec) vs Latency (ms)'" >> ${WorkDir}/${PlotScript}
  cat ${WorkDir}/${PlotScript}.$$ >> ${WorkDir}/${PlotScript}

  rm -f ${WorkDir}/${PlotScript}.$$ 2>/dev/null

  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">${DESTServerName}:${DESTServerIntf} NIC Total MB/sec vs Latency</a>:" >> ${WebDir}/index.html
  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
  echo "NIC utilization from $minUTIL to $maxUTIL <br>" >> ${WebDir}/index.html
  echo "Latency from $minPACLATavg to $maxPACLATavg" >> ${WebDir}/index.html
  echo "</blockquote>" >> ${WebDir}/index.html

)  ##  end of function Mkplot_nicutilVSlatency_dest

