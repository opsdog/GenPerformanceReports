##
##  include file to give the Compare scripts common plots
##

Make_Data()
{

echo
echo "Creating data files..."

exec 4<${RangeFile}
while read -u4 ServerName junk1 junk2 StartEpoch EndEpoch junk3 LegendText
do

  ServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${ServerName}'"`
  echo "  $ServerName ($ServerID) $StartEpoch $EndEpoch $LegendText"

  ${ProgPrefix}/NewQuery fsr "select swap from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_swap-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select free from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_free-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select psr from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_sr-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select pfpi from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_fpi-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select pfpo from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_fpo-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select pfpf from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_fpf-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select pepi from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_epi-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select pepo from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_epo-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select pepf from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_epf-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select papi from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_api-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select papo from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_apo-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select papf from vmstat where serverid = ${ServerID} and vmtype = 'p' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_apf-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select ( us + sys ) from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_cpu-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select rq from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_rqueue-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select bq from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_bqueue-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select wq from vmstat where serverid = ${ServerID} and vmtype = 'S' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vmstat_wqueue-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select adevices from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_numdev-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select asvct_avg from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_asvct-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select rs_sum from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_rops-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select krs_sum from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_readk-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select ws_sum from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_wops-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select kws_sum from iocalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/iocalc_writek-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select adevices from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_numdev-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select servtime from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_servtime-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select readops_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_rops-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select readblk_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_rblk-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select writops_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_wops-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select writblk_sum from vxcalc where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxvol_wblk-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select adevices from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_numdev-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select servtime from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_servtime-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select writops_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_wops-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select writblk_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_wblk-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select readops_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_rops-${LegendText}.dat
  ${ProgPrefix}/NewQuery fsr "select readblk_sum from vxcalc_dm where serverid = ${ServerID} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > ${PlotDataDir}/vxdisk_rblk-${LegendText}.dat

  ##
  ##  pull individual iostat data if requested
  ##

  if [ "$asvctNOT0" = "1" ]
  then
    ## echo "    iostatINTERNAL:  $iostatINTERNAL"
    if [ "$iostatINTERNAL" = "1" ]
    then
      ## echo "    INTERNAL only"
      ## ${ProgPrefix}/CSVQuery fsr "select asvct from iostat where serverid = ${ServerID} and ( device = 'c0t1d0' or device = 'c0t0d0' or device = 'c0t3d0' ) and asvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostat_asvct-${LegendText}.dat
      ${ProgPrefix}/CSVQuery fsr "select asvct from iostat where serverid = ${ServerID} and devtype = 1 and asvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostat_asvct-${LegendText}.dat
    else
      ## echo "    SAN only"
      ## ${ProgPrefix}/CSVQuery fsr "select asvct from iostat where serverid = ${ServerID} and device != 'c0t1d0' and device != 'c0t0d0' and device != 'c0t3d0' and asvct != 0.0 and device like '%t%' and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostat_asvct-${LegendText}.dat
      ${ProgPrefix}/CSVQuery fsr "select asvct from iostat where serverid = ${ServerID} and devtype = 2 and asvct != 0.0 and esttime between ${StartEpoch} and ${EndEpoch} order by esttime, asvct" > ${PlotDataDir}/iostat_asvct-${LegendText}.dat
    fi  ##  if iostatINTERNAL

  fi  ##  if -i


done
exec 4<&-

}  ##  end of function Make_Data

##
##  this function spits out the gplot header - suitable for including in all 
##  plot creation scripts
##

Echo_Header()
{

##
##  PNGs are smaller than JPGs :-)
##

echo "set term png size ${resX},${resY}"
echo "set output '${GFileBase}-${resX}x${resY}.png'"

##  echo "set term jpeg size ${resX},${resY}"
##  echo "set output '${GFileBase}-${resX}x${resY}.jpg'"

echo "set autoscale"
echo "unset log"
echo "unset label"
echo "unset object"
echo "set xtic auto"
echo "set ytic auto"
echo "set key off"
echo "set style line 1 lc rgb \"red\" lw 2 pt 1"
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1"
##  echo "set style line 3 lc rgb \"#22ff44\" lw 2 pt 1"
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1"
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1"
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1"
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1"
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1"
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1"
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1"
echo

}  ##  end of function Echo_Header

Mkplot_vmstatSwap()
{

echo
echo  "Creating swap plot script..."

GFileBase="010-vmstatSwap"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_swap*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_swap*.dat | sort -un | tail -1`

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_swap*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Free Swap'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatSwap


Mkplot_vmstatFree()
{

echo
echo  "Creating free plot script..."

GFileBase="015-vmstatFree"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_free*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_free*.dat | sort -un | tail -1`

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_free*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Free Memory'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatFree

Mkplot_vmstatSR()
{

echo
echo  "Creating sr plot script..."

GFileBase="020-vmstatSR"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_sr*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_sr*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_sr*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Swap Reclaims'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatSR

Mkplot_vmstatFPI()
{

echo
echo  "Creating fpi plot script..."

GFileBase="031-vmstatFPI"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_fpi*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_fpi*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_fpi*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'File pageins'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatFPI

Mkplot_vmstatFPO()
{

echo
echo  "Creating fpo plot script..."

GFileBase="032-vmstatFPO"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_fpo*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_fpo*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_fpo*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'File pageouts'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatFPO

Mkplot_vmstatFPF()
{

echo
echo  "Creating fpf plot script..."

GFileBase="033-vmstatFPF"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_fpf*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_fpf*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_fpf*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'File pagefaults'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatFPF

Mkplot_vmstatAPI()
{

echo
echo  "Creating api plot script..."

GFileBase="028-vmstatAPI"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_api*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_api*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_api*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Data pageins'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatAPI

Mkplot_vmstatAPO()
{

echo
echo  "Creating apo plot script..."

GFileBase="029-vmstatAPO"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_apo*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_apo*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_apo*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Data pageouts'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatAPO

Mkplot_vmstatAPF()
{

echo
echo  "Creating apf plot script..."

GFileBase="030-vmstatAPF"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_apf*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_apf*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_apf*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Data pagefaults'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatAPF

Mkplot_vmstatEPI()
{

echo
echo  "Creating epi plot script..."

GFileBase="025-vmstatEPI"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_epi*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_epi*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_epi*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Executable pageins'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatEPI

Mkplot_vmstatEPO()
{

echo
echo  "Creating epo plot script..."

GFileBase="026-vmstatEPO"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_epo*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_epo*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_epo*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Executable pageouts'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatEPO

Mkplot_vmstatEPF()
{

echo
echo  "Creating epf plot script..."

GFileBase="027-vmstatEPF"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_epf*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_epf*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_epf*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Executable pagefaults'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatEPF

Mkplot_vmstatCPU()
{

echo
echo  "Creating CPU plot script..."

GFileBase="040-vmstatCPU"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=0
maxY=100

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_cpu*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'CPU Utilization'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatCPU

Mkplot_vmstatRQueue()
{

echo
echo  "Creating r queue plot script..."

GFileBase="060-vmstatRQueue"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_rqueue*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_rqueue*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_rqueue*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Run Queue'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatRQueue

Mkplot_vmstatBQueue()
{

echo
echo  "Creating b queue plot script..."

GFileBase="062-vmstatBQueue"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_bqueue*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_bqueue*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_bqueue*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Blocked Queue'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatBQueue

Mkplot_vmstatWQueue()
{

echo
echo  "Creating w queue plot script..."

GFileBase="064-vmstatWQueue"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vmstat_wqueue*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vmstat_wqueue*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vmstat_wqueue*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Wait Queue'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vmstatWQueue

Mkplot_iocalcNumDev()
{

echo
echo  "Creating num devices plot script..."

GFileBase="100-iocalcNumDev"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/iocalc_numdev*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/iocalc_numdev*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/iocalc_numdev*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Active Disk Paths'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_iocalcNumDev

Mkplot_iocalcServTime()
{

echo
echo  "Creating average LUN service time plot script..."

GFileBase="105-iocalcServTime"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/iocalc_asvct*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/iocalc_asvct*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/iocalc_asvct*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Average LUN Service Time - ms'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_iocalcServTime

Mkplot_vxvolServTime()
{

echo
echo  "Creating average Volume service time plot script..."

GFileBase="200-vxvolServTime"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vxvol_servtime*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vxvol_servtime*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi
if [ $minY = 0 ]
then
  minY=0.001
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vxvol_servtime*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Average Volume Service Time - ms'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vxvolServTime

Mkplot_vxvolReadBlocks()
{

echo
echo  "Creating Volume read blocks plot script..."

GFileBase="200-vxvolReadBlocks"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

## echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vxvol_rblk*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vxvol_rblk*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vxvol_rblk*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Veritas Volume Read Blocks'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vxvolReadBlocks

Mkplot_vxdiskReadBlocks()
{

echo
echo  "Creating VxDisk read blocks plot script..."

GFileBase="300-vxdiskReadBlocks"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

## echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vxdisk_rblk*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vxdisk_rblk*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vxdisk_rblk*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Veritas Disk Read Blocks'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vxdiskReadBlocks

Mkplot_vxvolWriteBlocks()
{

echo
echo  "Creating Volume write blocks plot script..."

GFileBase="200-vxvolWriteBlocks"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

## echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vxvol_wblk*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vxvol_wblk*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vxvol_wblk*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Veritas Volume Write Blocks'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vxvolWriteBlocks

Mkplot_vxdiskWriteBlocks()
{

echo
echo  "Creating VxDisk write blocks plot script..."

GFileBase="300-vxdiskWriteBlocks"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

## echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vxdisk_wblk*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vxdisk_wblk*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vxdisk_wblk*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Veritas Disk Write Blocks'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vxdiskWriteBlocks

Mkplot_vxdiskServTime()
{

echo
echo  "Creating average Vx Disk service time plot script..."

GFileBase="300-vxdiskServTime"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vxdisk_servtime*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vxdisk_servtime*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi
if [ $minY = 0 ]
then
  minY=0.001
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vxdisk_servtime*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Average Veritas Disk Service Time - ms'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vxdiskServTime

Mkplot_iocalcROPs()
{

echo
echo  "Creating iocalc read ops plot script..."

GFileBase="110-iocalcROPs"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/iocalc_rops*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/iocalc_rops*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi
if [ $minY = 0 ]
then
  minY=0.001
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/iocalc_rops*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  ## echo "x:  $minX to $maxX"
  ## echo "y:  $minY to $maxY"

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Solaris Total Read Operations'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_iocalcROPs

Mkplot_iocalcWOPs()
{

echo
echo  "Creating iocalc write ops plot script..."

GFileBase="115-iocalcWOPs"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/iocalc_wops*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/iocalc_wops*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/iocalc_wops*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Solaris Write Operations'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_iocalcWOPs

Mkplot_vxvolNumDev()
{

echo
echo  "Creating active volumes plot script..."

GFileBase="200-vxvolNumDev"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

#echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vxvol_numdev*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vxvol_numdev*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vxvol_numdev*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Active Veritas Volumes'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vxvolNumDev

Mkplot_vxdiskNumDev()
{

echo
echo  "Creating active Vx disks plot script..."

GFileBase="300-vxdiskNumDev"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

#echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vxdisk_numdev*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vxdisk_numdev*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vxdisk_numdev*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Active Veritas Disks'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vxdiskNumDev

Mkplot_vxvolROPs()
{

echo
echo  "Creating volume read ops plot script..."

GFileBase="200-vxvolROPs"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

#echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vxvol_rops*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vxvol_rops*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vxvol_rops*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Total Volume Read Operations'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vxvolROPs

Mkplot_vxdiskROPs()
{

echo
echo  "Creating Vx disk read ops plot script..."

GFileBase="300-vxdiskROPs"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

#echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vxdisk_rops*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vxdisk_rops*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vxdisk_rops*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Veritas Disk Read Operations'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vxdiskROPs

Mkplot_vxvolWOPs()
{

echo
echo  "Creating volume write ops plot script..."

GFileBase="200-vxvolWOPs"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

#echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vxvol_wops*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vxvol_wops*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vxvol_wops*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Volume Write Operations'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vxvolWOPs

Mkplot_vxdiskWOPs()
{

echo
echo  "Creating Vx disk write ops plot script..."

GFileBase="300-vxdiskWOPs"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

#echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/vxdisk_wops*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/vxdisk_wops*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/vxdisk_wops*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Veritas Disk Write Operations'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_vxdiskWOPs


Mkplot_iostatASVCT()
{

echo
echo  "Creating iostat non-0 asvct plot script..."

GFileBase="106-iostatASVCT"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/iostat_asvct*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/iostat_asvct*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/iostat_asvct*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'LUN service time - raw data'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_iostatASVCT

Mkplot_iocalcReadK()
{

echo
echo  "Creating iocalc Read K plot script..."

GFileBase="112-iocalcReadK"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

#echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/iocalc_readk*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/iocalc_readk*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/iocalc_readk*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Solaris Kbytes Read'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_readk

Mkplot_iocalcWriteK()
{

echo
echo  "Creating iocalc Write K plot script..."

GFileBase="116-iocalcWriteK"
PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null
legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY
plotIndex=1

##  create the gnuplot script header

Echo_Header > $PlotScript

#echo "set logscale y" >> $PlotScript

##  loop through the appropriate data files...

minY=`cat ${PlotDataDir}/iocalc_writek*.dat | sort -un | head -1`
maxY=`cat ${PlotDataDir}/iocalc_writek*.dat | sort -un | tail -1`
if [ $maxY = 0 ]
then
  maxY=1
fi

minX=0

for DataFilePath in `ls -l ${PlotDataDir}/iocalc_writek*.dat 2>/dev/null | awk '{ print $NF }'`
do
  ## echo "  $DataFilePath "
  DataFile=`basename $DataFilePath`
  LegendText=`echo $DataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ##  set the legend text

  echo "set label \"${LegendText}\" at screen 0.${legendX},0.${legendY} front textcolor linestyle ${plotIndex} font \"${legfontName},$legfontSize\"" >> $PlotScript

  ##  create the plot entry to a temp file

  maxX=`wc -l $DataFilePath | awk '{ print $1 }'`

  echo >> $PlotScript.$$
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript.$$
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript.$$
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript.$$
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript.$$
  echo "plot \"${DataFilePath}\" title '${LegendText}' with linespoints linestyle ${plotIndex}" >> $PlotScript.$$


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  plotIndex=`expr $plotIndex + 1`
done  ##  for each data file

echo >> $PlotScript
echo "set multiplot title 'Solaris Kbytes Written'" >> $PlotScript
echo "set xtics format \"\"" >> $PlotScript
cat $PlotScript.$$ >> $PlotScript

rm -f $PlotScript.$$ 2>/dev/null

}  ##  end of function mkplot_writek


Mkplot_vmstatCPUxRQ()
{

echo
echo  "Creating CPU vs run queue plot script..."

legendX=`expr $LEGENDX - 1`
legincY=$LEGINCY
plotIndex=1

CPUminY=0
CPUmaxY=100

minX=0

##  loop through the CPU files and pull in the matching run queue data

for CPUDataFilePath in `ls -l ${PlotDataDir}/vmstat_cpu*.dat 2>/dev/null | awk '{ print $NF }'`
do
  plotIndex=1
  legendY=$LEGENDY
  CPUDataFile=`basename $CPUDataFilePath`
  LegendText=`echo $CPUDataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  GFileBase="050-vmstatCPUxRQ-${LegendText}"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  RQDataFilePath=`ls -l ${PlotDataDir}/vmstat_rqueue-${LegendText}.dat 2>/dev/null | awk '{ print $NF }'`
  RQminY=`cat ${RQDataFilePath} | sort -un | head -1`
  RQmaxY=`cat ${RQDataFilePath} | sort -un | tail -1`
  if [ $RQmaxY = 0 ]
  then
    RQmaxY=1
  fi
  maxX=`wc -l $CPUDataFilePath | awk '{ print $1 }'`

  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ## echo "  x:  $minX to $maxX"
  ## echo "  RQ: $RQminY to $RQmaxY"
  ## echo "  CPU: $CPUminY to $CPUmaxY"

  ##  create the gnuplot script header

  Echo_Header > $PlotScript

  ##  set the legend text

  echo "set label \"CPU\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> $PlotScript
  legendY=`expr $legendY - $legincY`
  echo "set label \"run queue\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> $PlotScript

  echo "set multiplot title '${LegendText} - CPU vs run queue'" >> $PlotScript

  echo >> $PlotScript
  echo "unset xtics" >> $PlotScript
  echo "unset x2tics" >> $PlotScript
  echo "set y2tics" >> $PlotScript
  echo >> $PlotScript
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript
  echo "set yrange [${CPUminY}:${CPUmaxY}]" >> $PlotScript
  echo "set y2range [${RQminY}:${RQmaxY}]" >> $PlotScript


  echo >> $PlotScript
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript
  ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript
  echo "plot \"${CPUDataFilePath}\" title 'CPU' with linespoints linestyle 1 axes x1y1" >> $PlotScript

  ## echo "  LegendText:       $LegendText"
  ## echo "  CPUDataFile       $CPUDataFile"
  ## echo "  CPUDataFilePath:  $CPUDataFilePath"
  ## echo "  RQDataFilePath:   $RQDataFilePath"
  ## echo

  echo >> $PlotScript
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript
  ## echo "set xrange [${minX}:${maxX}]" >> $PlotScript
  ## echo "set yrange [${RQminY}:${RQmaxY}]" >> $PlotScript
  echo "plot \"${RQDataFilePath}\" title 'run queue' with linespoints linestyle 2 axes x1y2" >> $PlotScript


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  ## plotIndex=`expr $plotIndex + 1`
done  ##  for each CPU data file

}  ##  end of function mkplot_vmstatCPUxRQ

Mkplot_iocalcReadKxWriteK()
{

echo
echo  "Creating iocalc Read K vs Write K plot scripts..."

legendX=`expr $LEGENDX - 1`
legincY=$LEGINCY
plotIndex=1

minX=0

##  loop through the ReadK files and pull in the matching WriteK data

for ReadKDataFilePath in `ls -l ${PlotDataDir}/iocalc_readk*.dat 2>/dev/null | awk '{ print $NF }'`
do
  plotIndex=1
  legendY=$LEGENDY
  ReadKDataFile=`basename $ReadKDataFilePath`
  LegendText=`echo $ReadKDataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  GFileBase="120-iocalcRKxWK-${LegendText}"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  WriteKDataFilePath=`ls -l ${PlotDataDir}/iocalc_writek-${LegendText}.dat 2>/dev/null | awk '{ print $NF }'`

  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  WriteKminY=`cat ${WriteKDataFilePath} | sort -un | head -1`
  WriteKmaxY=`cat ${WriteKDataFilePath} | sort -un | tail -1`
  if [ $WriteKmaxY = 0 ]
  then
    WriteKmaxY=1
  fi

  ReadKminY=`cat ${ReadKDataFilePath} | sort -un | head -1`
  ReadKmaxY=`cat ${ReadKDataFilePath} | sort -un | tail -1`
  if [ $ReadKmaxY = 0 ]
  then
    ReadKmaxY=1
  fi

  if [ $ReadKmaxY -gt $WriteKmaxY ]
  then
    maxY=$ReadKmaxY
  else
    maxY=$WriteKmaxY
  fi

  if [ $ReadKminY -lt $WriteKminY ]
  then
    minY=$ReadKminY
  else
    minY=$WriteKminY
  fi

  maxX=`wc -l $ReadKDataFilePath | awk '{ print $1 }'`

  ## echo "  Mins and Maxes:"
  ## echo "    ReadK Y :  $ReadKminY $ReadKmaxY"
  ## echo "    WriteK Y:  $WriteKminY $WriteKmaxY"
  ## echo "    Y       :  $minY $maxY"

  ##  create the gnuplot script header

  Echo_Header > $PlotScript

  ##  set the legend text

  echo "set label \"K Read\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> $PlotScript
  legendY=`expr $legendY - $legincY`
  echo "set label \"K Writes\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> $PlotScript

  echo "set multiplot title '${LegendText} - K Read and K Writes'" >> $PlotScript

  echo >> $PlotScript
  echo "unset xtics" >> $PlotScript
  echo "unset x2tics" >> $PlotScript
  echo "unset y2tics" >> $PlotScript
  echo >> $PlotScript
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript
  echo "set yrange [${minY}:${maxY}]" >> $PlotScript
  echo "set y2range [${minY}:${maxY}]" >> $PlotScript

  echo >> $PlotScript
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript
  echo "plot \"${ReadKDataFilePath}\" title 'K Read' with linespoints linestyle 1 axes x1y1" >> $PlotScript

  ## echo "  LegendText:       $LegendText"
  ## echo "  ReadKDataFile       $ReadKDataFile"
  ## echo "  ReadKDataFilePath:  $ReadKDataFilePath"
  ## echo "  WriteKDataFilePath:   $WriteKDataFilePath"
  ## echo

  echo >> $PlotScript
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript
  echo "plot \"${WriteKDataFilePath}\" title 'K Writes' with linespoints linestyle 2 axes x1y1" >> $PlotScript


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  ## plotIndex=`expr $plotIndex + 1`
done  ##  for each CPU data file

}  ##  end of function mkplot_iocalcReadKxWriteK

Mkplot_iocalcReadKxReadOps()
{

echo
echo  "Creating iocalc Read K vs Read ops plot scripts..."

legendX=`expr $LEGENDX - 1`
legincY=$LEGINCY
plotIndex=1

minX=0

##  loop through the ReadK files and pull in the matching WriteK data

for ReadKDataFilePath in `ls -l ${PlotDataDir}/iocalc_readk*.dat 2>/dev/null | awk '{ print $NF }'`
do
  plotIndex=1
  legendY=$LEGENDY
  ReadKDataFile=`basename $ReadKDataFilePath`
  LegendText=`echo $ReadKDataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  GFileBase="125-iocalcRKxROPs-${LegendText}"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  ROPsDataFilePath=`ls -l ${PlotDataDir}/iocalc_rops-${LegendText}.dat 2>/dev/null | awk '{ print $NF }'`

  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  ROPsminY=`cat ${ROPsDataFilePath} | sort -un | head -1`
  ROPsmaxY=`cat ${ROPsDataFilePath} | sort -un | tail -1`
  if [ $ROPsmaxY = 0 ]
  then
    ROPsmaxY=1
  fi

  ReadKminY=`cat ${ReadKDataFilePath} | sort -un | head -1`
  ReadKmaxY=`cat ${ReadKDataFilePath} | sort -un | tail -1`
  if [ $ReadKmaxY = 0 ]
  then
    ReadKmaxY=1
  fi

  maxX=`wc -l $ReadKDataFilePath | awk '{ print $1 }'`

  ## echo "  Mins and Maxes:"
  ## echo "    ReadK Y :  $ReadKminY $ReadKmaxY"
  ## echo "    ROPs Y  :  $ROPsminY $ROPsmaxY"
  ## echo "    Y       :  $minY $maxY"

  ##  create the gnuplot script header

  Echo_Header > $PlotScript

  ##  set the legend text

  echo "set label \"K Read\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> $PlotScript
  legendY=`expr $legendY - $legincY`
  echo "set label \"Read ops\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> $PlotScript

  echo "set multiplot title '${LegendText} - K Read and Read Operations'" >> $PlotScript

  echo >> $PlotScript
  echo "unset xtics" >> $PlotScript
  echo "unset x2tics" >> $PlotScript
  echo "set y2tics" >> $PlotScript
  echo >> $PlotScript
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript
  echo "set yrange [${ReadKminY}:${ReadKmaxY}]" >> $PlotScript
  echo "set y2range [${ROPsminY}:${ROPsmaxY}]" >> $PlotScript

  echo >> $PlotScript
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript
  echo "plot \"${ReadKDataFilePath}\" title 'K Read' with linespoints linestyle 1 axes x1y1" >> $PlotScript

  ## echo "  LegendText:       $LegendText"
  ## echo "  ReadKDataFile       $ReadKDataFile"
  ## echo "  ReadKDataFilePath:  $ReadKDataFilePath"
  ## echo "  WriteKDataFilePath:   $WriteKDataFilePath"
  ## echo

  echo >> $PlotScript
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript
  echo "plot \"${ROPsDataFilePath}\" title 'Read ops' with linespoints linestyle 2 axes x1y2" >> $PlotScript


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  ## plotIndex=`expr $plotIndex + 1`
done  ##  for each CPU data file

}  ##  end of function mkplot_iocalcReadKxReadOps

Mkplot_iocalcWriteKxWriteOps()
{

echo
echo  "Creating iocalc Write K vs Write ops plot scripts..."

legendX=`expr $LEGENDX - 1`
legincY=$LEGINCY
plotIndex=1

minX=0

##  loop through the WriteK files and pull in the matching WriteK data

for WriteKDataFilePath in `ls -l ${PlotDataDir}/iocalc_writek*.dat 2>/dev/null | awk '{ print $NF }'`
do
  plotIndex=1
  legendY=$LEGENDY
  WriteKDataFile=`basename $WriteKDataFilePath`
  LegendText=`echo $WriteKDataFile | awk -F \. '{ print $1 }' | awk -F \- '{ print $2 }'`
  GFileBase="130-iocalcWKxWOPs-${LegendText}"
  PlotScript="${GFileBase}.gplot"
  rm -f $PlotScript 2>/dev/null
  WOPsDataFilePath=`ls -l ${PlotDataDir}/iocalc_wops-${LegendText}.dat 2>/dev/null | awk '{ print $NF }'`

  echo "  $plotIndex $LegendText at ${legendX},${legendY}"

  WOPsminY=`cat ${WOPsDataFilePath} | sort -un | head -1`
  WOPsmaxY=`cat ${WOPsDataFilePath} | sort -un | tail -1`
  if [ $WOPsmaxY = 0 ]
  then
    WOPsmaxY=1
  fi

  WriteKminY=`cat ${WriteKDataFilePath} | sort -un | head -1`
  WriteKmaxY=`cat ${WriteKDataFilePath} | sort -un | tail -1`
  if [ $WriteKmaxY = 0 ]
  then
    WriteKmaxY=1
  fi

  maxX=`wc -l $WriteKDataFilePath | awk '{ print $1 }'`

  ## echo "  Mins and Maxes:"
  ## echo "    WriteK Y :  $WriteKminY $WriteKmaxY"
  ## echo "    WOPs Y  :  $WOPsminY $WOPsmaxY"
  ## echo "    Y       :  $minY $maxY"

  ##  create the gnuplot script header

  Echo_Header > $PlotScript

  ##  set the legend text

  echo "set label \"K Write\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> $PlotScript
  legendY=`expr $legendY - $legincY`
  echo "set label \"Write ops\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> $PlotScript

  echo "set multiplot title '${LegendText} - K Write and Write Operations'" >> $PlotScript

  echo >> $PlotScript
  echo "unset xtics" >> $PlotScript
  echo "unset x2tics" >> $PlotScript
  echo "set y2tics" >> $PlotScript
  echo >> $PlotScript
  echo "set xrange [${minX}:${maxX}]" >> $PlotScript
  echo "set yrange [${WriteKminY}:${WriteKmaxY}]" >> $PlotScript
  echo "set y2range [${WOPsminY}:${WOPsmaxY}]" >> $PlotScript

  echo >> $PlotScript
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript
  echo "plot \"${WriteKDataFilePath}\" title 'K Write' with linespoints linestyle 1 axes x1y1" >> $PlotScript

  ## echo "  LegendText:       $LegendText"
  ## echo "  WriteKDataFile       $WriteKDataFile"
  ## echo "  WriteKDataFilePath:  $WriteKDataFilePath"
  ## echo "  WriteKDataFilePath:   $WriteKDataFilePath"
  ## echo

  echo >> $PlotScript
  echo "set origin 0.${originX},0.${originY}" >> $PlotScript
  echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript
  echo "plot \"${WOPsDataFilePath}\" title 'Write ops' with linespoints linestyle 2 axes x1y2" >> $PlotScript


  ##  increment stuff and loop again
  legendY=`expr $legendY - $legincY`
  ## plotIndex=`expr $plotIndex + 1`
done  ##  for each CPU data file

}  ##  end of function mkplot_iocalcWriteKxWriteOps
