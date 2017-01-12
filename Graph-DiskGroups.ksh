#!/bin/ksh
##
##  script to create performance plots by "disk groups" 
##
##  command line arguments specify server and time frame
##

Echo_Header()
{

echo "set term png size ${resX},${resY}"
echo "set output \"${GFileBase}-${resX}x${resY}.png\""
echo "set autoscale"
echo "unset log"
echo "unset label"
echo "unset object"
echo "set xtic auto"
echo "set ytic auto"
echo "set key off"
echo "set style line 1 lc rgb \"red\" lw 2 pt 1"
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1"
echo "set style line 3 lc rgb \"#22ff44\" lw 2 pt 1"
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1"
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1"
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1"
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1"
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1"
echo

}  ##  end of function Echo_Header

Create_Data_Files()
{

##
##  create the data files
##

echo
echo "Creating data files..."

echo "  $ServerName ($ServerID) $StartEpoch $EndEpoch"

##  ZFS pool disk data

for ZFSpool in $ZFSpools
do
  echo "    ZFS $ZFSpool"
  for ZFSctdS in `${ProgPrefix}/NewQuery fsr "select name from zfsmap where server = ${ServerID} and pool = '$ZFSpool'"`
  do
    ZFSctd=`echo $ZFSctdS | sed s/s[0-7]$//`
    echo "      $ZFSctdS --> $ZFSctd"
  done  ##  for each disk in a pool
done  ##  for each ZFS pool

##  Veritas disk group data

for VXgroup in $VXgroups
do
  echo "    Veritas $VXgroup"

  ##
  ##  get volume stats - these are not path dependent
  ##

  ## echo "      VXSTAT volume stats"
  printf "      vol   "

  for VXvolume in `${ProgPrefix}/SVSQuery fsr "select distinct volume from plex where server = ${ServerID} and diskgroup = '${VXgroup}' order by volume"`
  ## for VXvolume in `${ProgPrefix}/NewQuery fsr "select distinct volume from plex where server = ${ServerID} and diskgroup = '${VXgroup}' order by volume" | head -2`
  do
    ##  echo "        VX volume $VXvolume"


    ${ProgPrefix}/NewQuery fsr "select esttime, readops from vxstat where vxtype = 'vol' and serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and dgroup = '${VXgroup}' and objname = '${VXvolume}' order by esttime" > ${PlotDataDir}/vxstat_vol_Rops-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXvolume}.dat
    printf "."
    ${ProgPrefix}/NewQuery fsr "select esttime, writops from vxstat where vxtype = 'vol' and serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and dgroup = '${VXgroup}' and objname = '${VXvolume}' order by esttime" > ${PlotDataDir}/vxstat_vol_Wops-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXvolume}.dat
    ##  printf "."
    ${ProgPrefix}/NewQuery fsr "select esttime, readblk from vxstat where vxtype = 'vol' and serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and dgroup = '${VXgroup}' and objname = '${VXvolume}' order by esttime" > ${PlotDataDir}/vxstat_vol_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXvolume}.dat
    ##  printf "."
    ${ProgPrefix}/NewQuery fsr "select esttime, writblk from vxstat where vxtype = 'vol' and serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and dgroup = '${VXgroup}' and objname = '${VXvolume}' order by esttime" > ${PlotDataDir}/vxstat_vol_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXvolume}.dat
    ##  printf "."
    ${ProgPrefix}/NewQuery fsr "select esttime, readms from vxstat where vxtype = 'vol' and serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and dgroup = '${VXgroup}' and objname = '${VXvolume}' order by esttime" > ${PlotDataDir}/vxstat_vol_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXvolume}.dat
    ##  printf "."
    ${ProgPrefix}/NewQuery fsr "select esttime, writms from vxstat where vxtype = 'vol' and serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and dgroup = '${VXgroup}' and objname = '${VXvolume}' order by esttime" > ${PlotDataDir}/vxstat_vol_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXvolume}.dat
    ##  printf "."

  done  ##  for each volume in the disk group
  printf "\n"

  ##
  ##  get dm stats - these are not path dependent
  ##

  ##  echo "      VXSTAT dm stats"
  printf "      dm    "

  for VXdm in `${ProgPrefix}/SVSQuery fsr "select distinct name from vdisk where server = ${ServerID} and diskgroup = '${VXgroup}' order by name"`
  ## for VXdm in `${ProgPrefix}/NewQuery fsr "select distinct name from vdisk where server = ${ServerID} and diskgroup = '${VXgroup}' order by name" | head -2`
  do
    ## echo "        VX dm $VXdm"

    ${ProgPrefix}/NewQuery fsr "select esttime, readops from vxstat where vxtype = 'dm' and serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and dgroup = '${VXgroup}' and objname = '${VXdm}' order by esttime" > ${PlotDataDir}/vxstat_dm_Rops-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXdm}.dat
    printf "."
    ${ProgPrefix}/NewQuery fsr "select esttime, writops from vxstat where vxtype = 'dm' and serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and dgroup = '${VXgroup}' and objname = '${VXdm}' order by esttime" > ${PlotDataDir}/vxstat_dm_Wops-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXdm}.dat
    ##  printf "."
    ${ProgPrefix}/NewQuery fsr "select esttime, readblk from vxstat where vxtype = 'dm' and serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and dgroup = '${VXgroup}' and objname = '${VXdm}' order by esttime" > ${PlotDataDir}/vxstat_dm_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXdm}.dat
    ##  printf "."
    ${ProgPrefix}/NewQuery fsr "select esttime, writblk from vxstat where vxtype = 'dm' and serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and dgroup = '${VXgroup}' and objname = '${VXdm}' order by esttime" > ${PlotDataDir}/vxstat_dm_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXdm}.dat
    ##  printf "."
    ${ProgPrefix}/NewQuery fsr "select esttime, readms from vxstat where vxtype = 'dm' and serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and dgroup = '${VXgroup}' and objname = '${VXdm}' order by esttime" > ${PlotDataDir}/vxstat_dm_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXdm}.dat
    ##  printf "."
    ${ProgPrefix}/NewQuery fsr "select esttime, writms from vxstat where vxtype = 'dm' and serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and dgroup = '${VXgroup}' and objname = '${VXdm}' order by esttime" > ${PlotDataDir}/vxstat_dm_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXdm}.dat
    ##  printf "."

  done  ##  for each dm in the disk group
  printf "\n"

  ##
  ##  now the long haul...
  ##
  ##  find each CTD in the disk group.  find each path for the CTD.
  ##  generate iostat data for each path.
  ##

  ## echo "      IOSTAT individual path stats"

  printf "      paths "

  for VXctdS in `${ProgPrefix}/SVSQuery fsr "select device from vdisk where server = ${ServerID} and diskgroup = '${VXgroup}'"`
  ## for VXctdS in `${ProgPrefix}/NewQuery fsr "select device from vdisk where server = ${ServerID} and diskgroup = '${VXgroup}'" | tail -1`
  do
    VXctd=`echo $VXctdS | sed s/s[0-7]$//`
    ## echo "      VXdm $VXctdS --> $VXctd"

    ##  and now we have the "main" CTD that veritas uses
    ##  but iostat tracks each individual path
    ##  so find the paths...

    for VXpathCTDs2 in `${ProgPrefix}/SVSQuery fsr "select device from diskpaths where serverid = ${ServerID} and pridev = '${VXctd}s2'"`
    ## for VXpathCTDs2 in `${ProgPrefix}/NewQuery fsr "select device from diskpaths where serverid = ${ServerID} and pridev = '${VXctd}s2'" | head -2`
    do
      VXpathCTD=`echo $VXpathCTDs2 | sed s/s[0-7]$//`
      ## echo "        VXpath $VXpathCTDs2 --> $VXpathCTD"
      ## echo "          `${ProgPrefix}/NewQuery fsr \"select count(rs) from iostat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and device = '${VXpathCTD}'\"`"

      ${ProgPrefix}/NewQuery fsr "select esttime, rs from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and esttime between ${StartEpoch} and ${EndEpoch} and device = '${VXpathCTD}' order by esttime" > ${PlotDataDir}/iostat_RopsALL-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXpathCTD}.dat
      printf "."
      ${ProgPrefix}/NewQuery fsr "select esttime, ws from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and esttime between ${StartEpoch} and ${EndEpoch} and device = '${VXpathCTD}' order by esttime" > ${PlotDataDir}/iostat_WopsALL-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXpathCTD}.dat
      ## printf "."
      ${ProgPrefix}/NewQuery fsr "select esttime, (ws + rs) from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and esttime between ${StartEpoch} and ${EndEpoch} and device = '${VXpathCTD}' order by esttime" > ${PlotDataDir}/iostat_TOTopsALL-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXpathCTD}.dat
      ## printf "."
      ${ProgPrefix}/NewQuery fsr "select esttime, krs from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and esttime between ${StartEpoch} and ${EndEpoch} and device = '${VXpathCTD}' order by esttime" > ${PlotDataDir}/iostat_readkALL-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXpathCTD}.dat
      ## printf "."
      ${ProgPrefix}/NewQuery fsr "select esttime, kws from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and esttime between ${StartEpoch} and ${EndEpoch} and device = '${VXpathCTD}' order by esttime" > ${PlotDataDir}/iostat_writekALL-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXpathCTD}.dat
      ## printf "."
      ${ProgPrefix}/NewQuery fsr "select esttime, asvct from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and esttime between ${StartEpoch} and ${EndEpoch} and device = '${VXpathCTD}' order by esttime" > ${PlotDataDir}/iostat_asvctALL-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXpathCTD}.dat
      ## printf "."
      ${ProgPrefix}/NewQuery fsr "select esttime, wsvct from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and esttime between ${StartEpoch} and ${EndEpoch} and device = '${VXpathCTD}' order by esttime" > ${PlotDataDir}/iostat_wsvctALL-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXpathCTD}.dat
      ## printf "."
      ${ProgPrefix}/NewQuery fsr "select esttime, actv from iostat where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and esttime between ${StartEpoch} and ${EndEpoch} and device = '${VXpathCTD}' order by esttime" > ${PlotDataDir}/iostat_actvALL-${ServerName}-${StartTime}_${EndTime}-VX-${VXgroup}-${VXpathCTD}.dat
      ## printf "."


    done  ##  for each path

  done  ##  for each disk in a disk group
  printf "\n"
done  ##  for each veritas disk group

##  ASM disk groups

for ASMgroup in $ASMgroups
do
  echo "    ASM $ASMgroup"
  ## for ASMdevice in `${ProgPrefix}/NewQuery fsr "select name from asmmap where server = ${ServerID} and asmgroup = '${ASMgroup}'"`
  for ASMdevice in `${ProgPrefix}/NewQuery fsr "select name from asmmap where server = ${ServerID} and asmgroup = '${ASMgroup}'" | head -2`
  do

    ##  ASM "devices" could be CTD (MPXIO) or volumes (Veritas)
    ##  we need CTDs with or without slice information

    if [ -z `echo $ASMdevice | egrep 'vol|asm'` ]
    then

      ##  MPXIO - we have CTD

      ASMctdS=$ASMdevice
      ASMctd=`echo $ASMctdS | sed s/s[0-7]$//`
      echo "      $ASMctdS --> $ASMctd"
      ## echo "        `${ProgPrefix}/NewQuery fsr \"select count(rs) from iostat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and device = '${ASMctd}'\"`"
    else

      ##  Veritas - we have a volume

      ## for ASMctdS in `${ProgPrefix}/SVSQuery fsr "select device from vxsd where server = ${ServerID} and volume = '${ASMdevice}'"`
      for ASMctdS in `${ProgPrefix}/SVSQuery fsr "select device from vxsd where server = ${ServerID} and volume = '${ASMdevice}'" | head -2`
      do
	echo "      Vol $ASMdevice --> $ASMctdS"
	ASMctd=`echo $ASMctdS | sed s/s[0-7]$//`
	echo "        VXdevice $ASMctdS --> $ASMctd"

	##  and now we have the "main" CTD that veritas uses
	##  but iostat tracks each individual path
	##  so find the paths...

	## for ASMpathCTDs2 in `${ProgPrefix}/SVSQuery fsr "select device from diskpaths where serverid = ${ServerID} and pridev = '${ASMctd}s2'"`
	for ASMpathCTDs2 in `${ProgPrefix}/SVSQuery fsr "select device from diskpaths where serverid = ${ServerID} and pridev = '${ASMctd}s2'" | head -2`
	do
	  ASMpathCTD=`echo $ASMpathCTDs2 | sed s/s[0-7]$//`
	  echo "          VXpath $ASMpathCTDs2 --> $ASMpathCTD"
	  ## echo "            `${ProgPrefix}/NewQuery fsr \"select count(rs) from iostat where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} and device = '${ASMpathCTD}'\"`"
	done  ##  for each path

      done  ##  for each device in the volume
    fi

  done  ##  for each disk in a disk group
done  ##  for each ASM disk group


}  ##  end of function Create_Data_Files

Mkplot_vxvol()
{

  echo "Creating Veritas volume plot scripts..."

  ##
  ##  determine the volume groups with read operations data
  ##

  echo "  Read operations..."

  for VGwithdata in `ls -l ${PlotDataDir}/vxstat_vol_Rops-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxvolrops"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/vxstat_vol_Rops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/vxstat_vol_Rops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/vxstat_vol_Rops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/vxstat_vol_Rops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/vxstat_vol_Rops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} Volume Read Operations'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Volume Read Operations</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Volume read ops from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with read operations data

  ##
  ##  determine the volume groups with write operations data
  ##

  echo "  Write operations..."

  for VGwithdata in `ls -l ${PlotDataDir}/vxstat_vol_Wops-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxvolwops"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/vxstat_vol_Wops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/vxstat_vol_Wops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/vxstat_vol_Wops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/vxstat_vol_Wops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/vxstat_vol_Wops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} Volume Write Operations'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Volume Write Operations</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Volume write ops from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with write operations data

  ##
  ##  determine the volume groups with read blocks data
  ##

  echo "  Read Blocks..."

  for VGwithdata in `ls -l ${PlotDataDir}/vxstat_vol_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxvolreadk"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/vxstat_vol_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/vxstat_vol_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/vxstat_vol_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/vxstat_vol_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/vxstat_vol_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} Volume Read Blocks'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Volume Read Blocks</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Volume read blocks from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with read blocks data

  ##
  ##  determine the volume groups with write blocks data
  ##

  echo "  Write Blocks..."

  for VGwithdata in `ls -l ${PlotDataDir}/vxstat_vol_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxvolwritek"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/vxstat_vol_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/vxstat_vol_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/vxstat_vol_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/vxstat_vol_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/vxstat_vol_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} Volume Write Blocks'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Volume Write Blocks</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Volume write blocks from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with write blocks data

  ##
  ##  determine the volume groups with read time data
  ##

  echo "  Read Time..."

  for VGwithdata in `ls -l ${PlotDataDir}/vxstat_vol_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxvolreadms"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/vxstat_vol_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/vxstat_vol_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/vxstat_vol_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/vxstat_vol_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/vxstat_vol_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} Volume Read Time (ms)'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Volume Read Time (ms)</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Volume read time from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with read time data

  ##
  ##  determine the volume groups with write time data
  ##

  echo "  Write Time..."

  for VGwithdata in `ls -l ${PlotDataDir}/vxstat_vol_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxvolwritems"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/vxstat_vol_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/vxstat_vol_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/vxstat_vol_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/vxstat_vol_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/vxstat_vol_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} Volume Write Time (ms)'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Volume Write Time (ms)</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Volume write time from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with write time data


}  ##  end of Mkplot_vxvol


Mkplot_vxdm()
{

  echo "Creating Veritas disk media plot scripts..."

  ##
  ##  determine the volume groups with read operations data
  ##

  echo "  Read operations..."

  for VGwithdata in `ls -l ${PlotDataDir}/vxstat_dm_Rops-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxdmrops"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/vxstat_dm_Rops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/vxstat_dm_Rops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/vxstat_dm_Rops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/vxstat_dm_Rops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/vxstat_dm_Rops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} Disk Read Operations'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Disk Read Operations</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Disk read ops from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with read operations data

  ##
  ##  determine the volume groups with write operations data
  ##

  echo "  Write operations..."

  for VGwithdata in `ls -l ${PlotDataDir}/vxstat_dm_Wops-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxdmwops"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/vxstat_dm_Wops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/vxstat_dm_Wops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/vxstat_dm_Wops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/vxstat_dm_Wops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/vxstat_dm_Wops-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} Disk Write Operations'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Disk Write Operations</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Disk write ops from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with write operations data

  ##
  ##  determine the volume groups with read blocks data
  ##

  echo "  Read Blocks..."

  for VGwithdata in `ls -l ${PlotDataDir}/vxstat_dm_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxdmreadk"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/vxstat_dm_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/vxstat_dm_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/vxstat_dm_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/vxstat_dm_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/vxstat_dm_ReadK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} Disk Read Blocks'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Disk Read Blocks</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Disk read blocks from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with read blocks data

  ##
  ##  determine the volume groups with write blocks data
  ##

  echo "  Write K..."

  for VGwithdata in `ls -l ${PlotDataDir}/vxstat_dm_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxdmwritek"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/vxstat_dm_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/vxstat_dm_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/vxstat_dm_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/vxstat_dm_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/vxstat_dm_WriteK-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} Disk Write K'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Disk Write Blocks</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Disk write blocks from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with write blocks data

  ##
  ##  determine the volume groups with read time data
  ##

  echo "  Read Time..."

  for VGwithdata in `ls -l ${PlotDataDir}/vxstat_dm_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxdmreadms"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/vxstat_dm_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/vxstat_dm_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/vxstat_dm_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/vxstat_dm_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/vxstat_dm_ReadMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} Disk Read Time (ms)'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Disk Read Time (ms)</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Disk read time from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with read time data

  ##
  ##  determine the volume groups with write time data
  ##

  echo "  Write Time..."

  for VGwithdata in `ls -l ${PlotDataDir}/vxstat_dm_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxdmwritems"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/vxstat_dm_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/vxstat_dm_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/vxstat_dm_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/vxstat_dm_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/vxstat_dm_WriteMS-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} Disk Write Time (ms)'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Disk Write Time (ms)</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Disk write time from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with write time data


}  ##  end of Mkplot_vxdm

Mkplot_vxlun()
{

  echo "Creating Veritas LUN plot scripts..."

  ##
  ##  determine the volume groups with read operations data
  ##

  echo "  Read operations..."

  for VGwithdata in `ls -l ${PlotDataDir}/iostat_RopsALL-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxlunrops"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/iostat_RopsALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/iostat_RopsALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/iostat_RopsALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/iostat_RopsALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/iostat_RopsALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} LUN Read Operations'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Disk Read Operations</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Disk read ops from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html

  done  ##  for each volume group with read operations data

  ##
  ##  determine the volume groups with write operations data
  ##

  echo "  Write operations..."

  for VGwithdata in `ls -l ${PlotDataDir}/iostat_WopsALL-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxlunwops"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/iostat_WopsALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/iostat_WopsALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/iostat_WopsALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/iostat_WopsALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/iostat_WopsALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} LUN Write Operations'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Disk Write Operations</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Disk write ops from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html

  done  ##  for each volume group with write operations data


  ##
  ##  determine the volume groups with read blocks data
  ##

  echo "  Read K..."

  for VGwithdata in `ls -l ${PlotDataDir}/iostat_readkALL-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxlunreadk"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/iostat_readkALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/iostat_readkALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/iostat_readkALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/iostat_readkALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/iostat_readkALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} LUN Read K'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Disk Read Blocks</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Disk read blocks from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html

  done  ##  for each volume group with read K data

  ##
  ##  determine the volume groups with write blocks data
  ##

  echo "  Write K..."

  for VGwithdata in `ls -l ${PlotDataDir}/iostat_writekALL-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxlunwritek"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/iostat_writekALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/iostat_writekALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/iostat_writekALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/iostat_writekALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/iostat_writekALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} LUN Write Blocks'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Disk Write Blocks</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Disk write blocks from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html

  done  ##  for each volume group with write K data

  ##
  ##  determine the volume groups with service time data
  ##

  echo "  Service Time..."

  for VGwithdata in `ls -l ${PlotDataDir}/iostat_asvctALL-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxlunasvct"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/iostat_asvctALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/iostat_asvctALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/iostat_asvctALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/iostat_asvctALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/iostat_asvctALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} LUN Service Time (ms)'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Disk Read Time (ms)</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Disk read time from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with service time data

  ##
  ##  determine the volume groups with write time data
  ##

  echo "  Wait Time..."

  for VGwithdata in `ls -l ${PlotDataDir}/iostat_wsvctALL-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxlunwsvct"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/iostat_wsvctALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/iostat_wsvctALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/iostat_wsvctALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/iostat_wsvctALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/iostat_wsvctALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} LUN Wait Time (ms)'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Disk Write Time (ms)</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Disk write time from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with wait time data

  ##
  ##  determine the volume groups with write time data
  ##

  echo "  Active Transactions..."

  for VGwithdata in `ls -l ${PlotDataDir}/iostat_actvALL-${ServerName}-${StartTime}_${EndTime}-VX-*.dat | basename \`awk '{ print $NF }'\` | awk -F\- '{ print $5 }' | sort -u`
  do
    ##  echo "    VG $VGwithdata"

    GFileBase="${ServerName}_${StartTime}-${EndTime}_VX_${VGwithdata}_vxlunactv"
    PlotScript="${GFileBase}.gplot"
    rm -f $PlotScript 2>/dev/null
    legendX=$LEGENDX
    legendY=$LEGENDY
    legincY=$LEGINCY
    plotIndex=1

    ##  create the gnuplot script header

    Echo_Header > $PlotScript

    ## echo "set logscale y" >> $PlotScript

    ##  find the ranges

    minX=`cat ${PlotDataDir}/iostat_actvALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | head -1`
    maxX=`cat ${PlotDataDir}/iostat_actvALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $1 }' | sort -un | tail -1`

    minY=`cat ${PlotDataDir}/iostat_actvALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | head -1`
    maxY=`cat ${PlotDataDir}/iostat_actvALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat | awk '{ print $2 }' | sort -un | tail -1`

    ##  echo "    X:  $minX to $maxX"
    ##  echo "    Y:  $minY to $maxY"

    if [ $maxY = 0 ]
    then
      maxY=1
    fi

    for DataFilePath in ${PlotDataDir}/iostat_actvALL-${ServerName}-${StartTime}_${EndTime}-VX-${VGwithdata}*.dat
    do
      ## echo "      $DataFilePath"

      DataFile=`basename $DataFilePath`

      echo >> $PlotScript.$$
      echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
      echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
      ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
      echo "set xrange [${StartEpoch}:${EndEpoch}]" >> $PlotScript.$$
      echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
      ## echo "plot \"${DataFilePath}\" using 1:2 title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$
      echo "plot \"${DataFilePath}\" using 1:2 with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


      ##  increment stuff and loop again
      plotIndex=`expr $plotIndex + 1`
    done  ##  for each DataFilePath

    echo "set multiplot title '${ServerName} - ${StartTime} to ${EndTime} - Veritas Disk Group ${VGwithdata} LUN Active Transactions'" >> $PlotScript
    echo "set xtics format \"\"" >> $PlotScript
    cat $PlotScript.$$ >> $PlotScript

    rm -f $PlotScript.$$ 2>/dev/null

    ##  echo "<li><a href=\"${GFileBase}-${resX}x${resY}.png\">Veritas: Disk Group ${VGwithdata} Disk Write Time (ms)</a>" >> ${WebDir}/index.html
    ##  echo "<blockquote class=\"summary\">" >> ${WebDir}/index.html
    ##  echo "Disk write time from $minY to $maxY" >> ${WebDir}/index.html
    ##  echo "</blockquote>" >> ${WebDir}/index.html


  done  ##  for each volume group with active transaction data



}  ##  end of Mkplot_vxlun




######################################################################
######################################################################
##
##  main  
##
######################################################################
######################################################################

##  arg checks

## if [ -z "$1" -o -z "$2" -o -z "$3" ]
if [ -z "$3" ]
then
  echo
  echo "usage:  `basename $0` servername startTIME endTIME [ -t ] [ -nb ]"
  echo
  exit
fi

if [ "$4" = "-t" -o "$5" = "-t" ]
then
  TESTMODE=1
else
  TESTMODE=0
fi

if [ "$4" = "-nb" -o "$5" = "-nb" ]
then
  NBServer=1
else
  NBServer=0
fi

ServerName=$1
StartTime=$2
EndTime=$3

StartEpoch=`./ToEpoch $2`
EndEpoch=`./ToEpoch $3`


## initialize stuff

. ./DateFuncs.ksh

MyEMail="doug.greenwald@gmail.com"

PATH="${PATH}:."

IFSorig="${IFS}"

if [ -d /Volumes/External300/DBProgs/RacePics ]
then
  ProgPrefix="/Volumes/External300/DBProgs/RacePics"
else
  ProgPrefix="/Users/douggreenwald/RacePics"
fi

DBLocation=`${ProgPrefix}/FindDB.ksh`
if [ "$DBLocation" = "notfound" ]
then
  echo "no database - bailing..."
  exit
fi
if [ "$DBLocation" = "localhost" ]
then
  MYSQL="mysql -u doug -pILikeSex -A"
else
  MYSQL="mysql -h big-mac -u doug -pILikeSex -A"
fi

WorkDir=`pwd`
ArchiveDir=${WorkDir}/Graph-DiskGroups
PlotDataDir=${ArchiveDir}/GPlotData
WebDir=${ArchiveDir}/Web-${ServerName}-${StartTime}-${EndTime}
## WebDir=/Volumes/External300/Sites/TheFirst60Feet.com/WFPerf/${ServerName}-${StartTime}-${EndTime}
## RangeFile=${ArchiveDir}/Ranges

unset asvctNOT0
if [ "$1" = "-i" ]
then
  asvctNOT0=1
fi  ##  if arg1 is -i

ServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${ServerName}'"`

##
##  these are variables used to control various aspects of the plot
##

##  for 640x480

# resX=640
# resY=480

# sizeX=77
# sizeY=96

# LEGENDX=76
# LEGENDY=90
# LEGINCY=06

# legfontName="Georgia Bold"
# legfontSize=12

# TITLEX=46
# TITLEY=96

# titlefontName="Arial"
# titlefontSize=14

##  for 1280x640

# resX=1280
# resY=640

# sizeX=86
# sizeY=96

# LEGENDX=86
# LEGENDY=90
# LEGINCY=06

# legfontName="Georgia Bold"
# legfontSize=14

# TITLEX=49
# TITLEY=962

# titlefontName="Arial"
# titlefontSize=16

##  for 2048x1024

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

##  for 4096x2048

# resX=4096
# resY=2048

# sizeX=940
# sizeY=97

# LEGENDX=955
# LEGENDY=95
# LEGINCY=03

# legfontName="Georgia Bold"
# legfontSize=14

# TITLEX=511
# TITLEY=985

# titlefontName="Arial"
# titlefontSize=20

##  for 8192x4096

## resX=8192
## resY=4096

## sizeX=965
## sizeY=97

## LEGENDX=977
## LEGENDY=97
## LEGINCY=01

## legfontName="Georgia Bold"
## legfontSize=14

## TITLEX=51
## TITLEY=985

## titlefontName="Arial"
## titlefontSize=40

##  resolution independent

originX="01"
originY="01"

scaleX=1
scaleY=1

GFileBase="TestSize"

##
##  start actually doing stuff
##

echo
echo "Clearing old runs..."

## if [ -d $PlotDataDir ]
## then
##   rm -f ${PlotDataDir}/*${ServerName}-${StartTime}_${EndTime}*.dat 2>/dev/null
## else
##   mkdir -p $PlotDataDir 2>/dev/null
## fi

if [ ! -d $WebDir ]
then
  mkdir -p $WebDir
else
  cd $WebDir
  /bin/rm -f * 2>/dev/null
  cd $WorkDir
fi

rm -f ${ArchiveDir}/${ServerName}_${StartTime}-${EndTime}*.png 2>/dev/null
rm -f ${ArchiveDir}/${ServerName}_${StartTime}-${EndTime}*.gplot 2>/dev/null

##
##  start the HTML files
##

cat > ${WebDir}/index.html <<EOF
<html>
<head>
<title>${ServerName} Disk Group Performance from ${StartTime} to ${EndTime}</title>
<link rel=stylesheet href="Perf-DiskGroups.css" type="text/css">
</head>
<body>
<h1 align=center>${ServerName} from ${StartTime} to ${EndTime}</h1>
EOF

##
##  determine disk groupings
##
##    zpools
##    veritas disk groups
##    ASM disk groups
##

echo
echo "Determining disk groupings..."

ZFSpools=`${ProgPrefix}/SVSQuery fsr "select distinct pool from zfsmap where server = ${ServerID} order by pool"`

echo "  ZFS pools : ${ZFSpools}"

VXgroups=`${ProgPrefix}/SVSQuery fsr "select distinct diskgroup from vdisk where server = ${ServerID} order by diskgroup"`
##  VXgroups=`${ProgPrefix}/NewQuery fsr "select distinct diskgroup from vdisk where server = ${ServerID} order by diskgroup" | head -1`

echo "  VX groups : ${VXgroups}"

ASMgroups=`${ProgPrefix}/SVSQuery fsr "select distinct asmgroup from asmmap where server = ${ServerID} order by asmgroup"`
##  ASMgroups=`${ProgPrefix}/NewQuery fsr "select distinct asmgroup from asmmap where server = ${ServerID} order by asmgroup" | head -1`

echo "  ASM groups: ${ASMgroups}"

##
##  create the data files
##

## Create_Data_Files

##
##  create the plot scripts
##

echo

Mkplot_vxvol

Mkplot_vxdm

Mkplot_vxlun






##
##  create the images and scatter them into place
##

echo
echo "Creating the images..."

for PlotFile in ${ServerName}*.gplot
do
  echo "  $PlotFile"
  gnuplot < $PlotFile 2>/dev/null
done

mv ${ServerName}_${StartTime}-${EndTime}*-${resX}x${resY}.png ${ServerName}_${StartTime}-${EndTime}*.gplot ${ArchiveDir}/
cp ${ArchiveDir}/${ServerName}_${StartTime}-${EndTime}*-${resX}x${resY}.png ${WebDir}/
cp Perf-DiskGroups.css ${WebDir}/


##
##  continue the index.html
##

echo
echo "Creating Veritas Disk Group links in index.html..."

if [ ! -z "$VXgroups" ]
then
  echo "<p>Veritas Disk Groups</p>" >> ${WebDir}/index.html

  echo "<blockquote>" >> ${WebDir}/index.html

  for VXgroup in $VXgroups
  do
    echo "<p>$VXgroup" >> ${WebDir}/index.html

    ##
    ##  Volume graphs as available
    ##

    echo "<blockquote>" >> ${WebDir}/index.html
    echo "Volume based graphs:" >> ${WebDir}/index.html

    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxvolreadk-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxvolreadk-${resX}x${resY}.png\">[&nbsp;Read&nbsp;Blocks&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxvolreadms-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxvolreadms-${resX}x${resY}.png\">[&nbsp;Read&nbsp;Times&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxvolrops-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxvolrops-${resX}x${resY}.png\">[&nbsp;Read&nbsp;Ops&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxvolwritek-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxvolwritek-${resX}x${resY}.png\">[&nbsp;Write&nbsp;Blocks&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxvolwritems-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxvolwritems-${resX}x${resY}.png\">[&nbsp;Write&nbsp;Times&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxvolwops-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxvolwops-${resX}x${resY}.png\">[&nbsp;Write&nbsp;Ops&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi

    echo "</blockquote>" >> ${WebDir}/index.html

    ##
    ##  DM graphs as available
    ##

    echo "<blockquote>" >> ${WebDir}/index.html
    echo "DM based graphs:" >> ${WebDir}/index.html

    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxdmreadk-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxdmreadk-${resX}x${resY}.png\">[&nbsp;Read&nbsp;Blocks&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxdmreadms-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxdmreadms-${resX}x${resY}.png\">[&nbsp;Read&nbsp;Times&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxdmrops-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxdmrops-${resX}x${resY}.png\">[&nbsp;Read&nbsp;Ops&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxdmwritek-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxdmwritek-${resX}x${resY}.png\">[&nbsp;Write&nbsp;Blocks&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxdmwritems-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxdmwritems-${resX}x${resY}.png\">[&nbsp;Write&nbsp;Times&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxdmwops-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxdmwops-${resX}x${resY}.png\">[&nbsp;Write&nbsp;Ops&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi

    echo "</blockquote>" >> ${WebDir}/index.html

    ##
    ##  LUN graphs as available
    ##

    echo "<blockquote>" >> ${WebDir}/index.html
    echo "LUN based graphs:" >> ${WebDir}/index.html

    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunasvct-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunasvct-${resX}x${resY}.png\">[&nbsp;Service&nbsp;Times&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunwsvct-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunwsvct-${resX}x${resY}.png\">[&nbsp;Wait&nbsp;Times&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunactv-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunactv-${resX}x${resY}.png\">[&nbsp;Active&nbsp;Trans&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi

    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunreadk-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunreadk-${resX}x${resY}.png\">[&nbsp;Read&nbsp;K&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunrops-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunrops-${resX}x${resY}.png\">[&nbsp;Read&nbsp;Ops&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi

    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunwritek-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunwritek-${resX}x${resY}.png\">[&nbsp;Write&nbsp;K&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi
    if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunwops-${resX}x${resY}.png ]
    then
      echo "<a href=\"${ServerName}_${StartTime}-${EndTime}_VX_${VXgroup}_vxlunwops-${resX}x${resY}.png\">[&nbsp;Write&nbsp;Ops&nbsp;]</a>&nbsp;&nbsp; " >> ${WebDir}/index.html
    fi


    echo "</blockquote>" >> ${WebDir}/index.html


    echo "</p>" >> ${WebDir}/index.html
  done  ##  for each veritas disk group

  echo "</blockquote>" >> ${WebDir}/index.html

fi  ##  if we have veritas disk groups

##
##  create the tarball of datafiles
##

##  echo
##  echo "Creating the data tarball..."

##  there are so many procbycpu files they need to be tar'd individually

##  for i in 1 2 3 4 5 6 7 8 9
##  do
##    tar cf ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-ProcCPUFiles-${i}.tar ${PlotDataDir}/proccpu_pctcpu-${ServerName}-${StartTime}_${EndTime}-${i}*.dat 2>/dev/null
##    tar cf ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-ProcMemFiles-${i}.tar ${PlotDataDir}/procmem_pctmem-${ServerName}-${StartTime}_${EndTime}-${i}*.dat 2>/dev/null
##  done  ##  for each PID leading number

##  tar cf ${WebDir}/${ServerName}_${StartTime}-${EndTime}-DataFiles.tar \
##      ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-ProcCPUFiles-*.tar \
##      ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-ProcMemFiles-*.tar \
##      ${PlotDataDir}/iocalc*-${ServerName}-${StartTime}_${EndTime}*.dat \
##      ${PlotDataDir}/iostat*-${ServerName}-${StartTime}_${EndTime}*.dat \
##      ${PlotDataDir}/mpstat*-${ServerName}-${StartTime}_${EndTime}*.dat \
##      ${PlotDataDir}/vmstat*-${ServerName}-${StartTime}_${EndTime}*.dat \
##      ${PlotDataDir}/vxdisk*-${ServerName}-${StartTime}_${EndTime}*.dat \
##      ${PlotDataDir}/vxstat*-${ServerName}-${StartTime}_${EndTime}*.dat \
##      ${PlotDataDir}/vxvol*-${ServerName}-${StartTime}_${EndTime}*.dat \
##      2>/dev/null

##     ## iocalc
##     ## iostat
##     ## mpstat
##     ## vmstat
##     ## vxdisk
##     ## vxstat
##     ## vxvol

##  gzip ${WebDir}/${ServerName}_${StartTime}-${EndTime}-DataFiles.tar

##  echo "<p>Data tarball</p>" >> ${WebDir}/index.html
##  echo "<ul>" >> ${WebDir}/index.html
##  echo "<li><a href=\"${ServerName}_${StartTime}-${EndTime}-DataFiles.tar.gz\">${ServerName}_${StartTime}-${EndTime}-DataFiles.tar.gz</a>" >> ${WebDir}/index.html
##  echo "</ul>" >> ${WebDir}/index.html

##
##  close the index.html and copy the images
##

cat >> ${WebDir}/index.html <<EOF
</body>
</html>
EOF

##
##  open the images
##

echo
echo "dougopen Graph-DiskGroups/${ServerName}_${StartTime}-${EndTime}*.png"
echo
