#!/bin/ksh
##
##  script to generate the data and produce the graphs to mimic the
##  spreadsheets i create by hand
##
##  i want to be done with excel
##

. ./Func-GPlotStats.ksh

. ./Func-Graph-MDay.ksh

. ./Func-DBStats.ksh

######################################################################
######################################################################
##
##  main
##
######################################################################
######################################################################

##  arg checks

TESTMODE=0
if [ ! -z "$2" ]
then
  if [ "$2" != "-t" ]
  then
    echo
    echo "usage:  `basename $0` servername [ -t ]"
    echo
    exit
  else
    TESTMODE=1
  fi  ##  if arg2 is not -t
fi  ##  if arg2 is not null

if [ -z "$1" ]
then
  echo
  echo "usage:  `basename $0` servername [ -t ]"
  echo
  exit
fi  ##  if arg1 is null

ServerName=$1

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

. ./SetDBCase.ksh

ServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${ServerName}'"`

if [ -z "$ServerID" ]
then
  echo
  echo "Invalid server name specified - bailing..."
  exit
fi

StartEpoch=`${ProgPrefix}/NewQuery fsr "select min(esttime) from vmstat where serverid = ${ServerID}"`
EndEpoch=`${ProgPrefix}/NewQuery fsr "select max(esttime) from vmstat where serverid = ${ServerID}"`

##  echo "StartEpoch: $StartEpoch"
##  echo "EndEpoch:   $EndEpoch"

if [ -z "$StartEpoch" -o "$StartEpoch" = "$EndEpoch" ]
then
  echo
  echo "Data problem - does server have data?  Bailing..."
  echo 
  exit
fi  ##  if bad epoch times

StartTime=`${ProgPrefix}/FromEpoch $StartEpoch -s`
EndTime=`${ProgPrefix}/FromEpoch $EndEpoch -s`

##  echo "StartTime: $StartTime"
##  echo "EndTime:   $EndTime"

WorkDir=`pwd`
ArchiveDir=${WorkDir}/Graph-MDayStacks
PlotDataDir=${ArchiveDir}/GPlotData
WebDir=${ArchiveDir}/MDay-${ServerName}-${StartTime}-${EndTime}

##
##  find the full date ranges that include all the data
##

FullRangeBeginTime="`echo $StartTime | cut -c1-8`0000"
DougeeEpoch=`echo $EndEpoch + 86400 | bc`
DougeeTime=`${ProgPrefix}/FromEpoch $DougeeEpoch -s`
##  echo "DougeeTime: $DougeeTime"
FullRangeEndTime="`echo $DougeeTime | cut -c1-8`0000"
FullRangeEndEpoch=`${ProgPrefix}/ToEpoch $FullRangeEndTime`

##  echo "FullRangeBeginTime: $FullRangeBeginTime"
##  echo "FullRangeEndTime:   $FullRangeEndTime"
##  echo "FullRangeEndEpoch:  $FullRangeEndEpoch"

##
##  calculate the daily ranges
##

TempBeginEpoch=`${ProgPrefix}/ToEpoch $FullRangeBeginTime`
TempEndEpoch=`echo $TempBeginEpoch + 86400 | bc`

##  echo "TempBeginEpoch: $TempBeginEpoch"
##  echo "TempEndEpoch:   $TempEndEpoch"

rm -f tmp_mday_ranges 2>/dev/null

echo "$TempBeginEpoch $TempEndEpoch" > tmp_mday_ranges
NumRanges=1

TempBeginEpoch=$TempEndEpoch
while [ $TempBeginEpoch -lt $FullRangeEndEpoch ]
do
  TempEndEpoch=`echo $TempBeginEpoch + 86400 | bc`
  echo "$TempBeginEpoch $TempEndEpoch" >> tmp_mday_ranges

  TempBeginEpoch=$TempEndEpoch
  NumRanges=`echo $NumRanges + 1 | bc`
done  ##  end of loop on epoch time

##  debug block

##  echo
##  echo "NumRanges: $NumRanges"
##  exec 4<tmp_mday_ranges
##  TMPRangeNum=1
##  while read -u4 A B
##  do
##    TMPBegin=`${ProgPrefix}/FromEpoch $A`
##    TMPEnd=`${ProgPrefix}/FromEpoch $B`
##    printf "  %2s : %s --> %s\n" $TMPRangeNum "$TMPBegin" "$TMPEnd"
##    TMPRangeNum=`echo $TMPRangeNum + 1 | bc`  
##  done
##  exec 4<&-
##  echo

##
##  graph-related settings
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

sizeX=98
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

##  resX=8192
##  resY=4096

##  sizeX=965
##  sizeY=97

##  LEGENDX=977
##  LEGENDY=97
##  LEGINCY=01

##  legfontName="Georgia Bold"
##  legfontSize=14

##  TITLEX=51
##  TITLEY=985

##  titlefontName="Arial"
##  titlefontSize=40

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

if [ -d $PlotDataDir ]
then
  rm -f ${PlotDataDir}/*${ServerName}*.dat 2>/dev/null
  ## rm -f ${PlotDataDir}/*-ALL-${ServerName}.dat 2>/dev/null
else
  mkdir -p $PlotDataDir 2>/dev/null
fi

if [ ! -d $WebDir ]
then
  mkdir -p $WebDir
else
  cd $WebDir
  /bin/rm -f * 2>/dev/null
  cd $WorkDir
fi

rm -f ${ArchiveDir}/${ServerName}_*.png 2>/dev/null
rm -f ${ArchiveDir}/${ServerName}_*.gplot 2>/dev/null

##
##  start the HTML files
##

cat > ${WebDir}/index.html <<EOF
<html>
<head>
<title>${ServerName} Performance Multi-Day Comparison from ${FullRangeBeginTime} to ${FullRangeEndTime}</title>
<link rel=stylesheet href="Perf-Overview-MD.css" type="text/css">
</head>
<body>
<h1 align=center>${ServerName} from ${FullRangeBeginTime} to ${FullRangeEndTime}</h1>
EOF

##
##  create the data files
##

Make_Data_local_md

##
##  create the CPU/memory stats
##

echo "<p>Overview CPU and Memory Graphs</p>" >> ${WebDir}/index.html
echo "<ul>" >> ${WebDir}/index.html

Mkplot_swap
Mkplot_free
Mkplot_sr
##  Mkplot_epaging
##  Mkplot_apaging
##  Mkplot_fpaging
Mkplot_cpuTOT
Mkplot_kqueuesR
Mkplot_kqueuesB
Mkplot_kqueuesW
Mkplot_server_syscalls
##  Mkplot_CPUxRQ

echo "</ul>" >> ${WebDir}/index.html


##
##  these really can't be done for each range - too much data per range
##

##  echo "<p>Individual CPU and Dispatch Graphs</p>" >> ${WebDir}/index.html
##  echo "<ul>" >> ${WebDir}/index.html

##  Mkplot_mpstat_CPUusr
##  Mkplot_mpstat_CPUsys
##  Mkplot_mpstat_CPUwait
##  Mkplot_mpstat_syscall
##  Mkplot_mpstat_intr
##  Mkplot_context_switches
##  Mkplot_cpu_migrations
##  Mkplot_mpstat_SPINmutex
##  Mkplot_mpstat_SPINrwlock

##  echo "</ul>" >> ${WebDir}/index.html

##
##  create the network stats
##

echo "<p>Network Graphs</p>" >> ${WebDir}/index.html
echo "<ul>" >> ${WebDir}/index.html

Mkplot_netsum

##  NewQuery fsr "select esttime, sum(ipack) from netstat where serverid = 29 and esttime in (select esttime from netstat where serverid = 29 and esttime between 1431798516 and 1431798546) group by esttime"

echo "</ul>" >> ${WebDir}/index.html

##
##  create the iocalc stats
##

echo "<p>Solaris Disk I/O Graphs</p>" >> ${WebDir}/index.html
echo "<ul>" >> ${WebDir}/index.html

Mkplot_ioops
Mkplot_iokbytes
Mkplot_iotrans
##  Mkplot_iodevcount
Mkplot_ioservavg
##  Mkplot_servXwait

Mkplot_iolunservice      ##  RAW LUN stats
##  Mkplot_iolunservXwait

echo "</ul>" >> ${WebDir}/index.html

##
##  create the veritas stats
##

##  check to see if this server has veritas...


##  wc -l ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat 2>/dev/null
wc -l ${PlotDataDir}/vxcalc_rops-${ServerName}-*.dat >/dev/null 2>&1
VXCount=$?

if [ $VXCount -eq 0 ]
then

  echo "<p>Veritas Graphs</p>" >> ${WebDir}/index.html
  echo "<ul>" >> ${WebDir}/index.html

  Mkplot_vxops
  Mkplot_vxblocks
  Mkplot_vxservice
  Mkplot_vxreadstats    ##  average and max
  Mkplot_vxwritestats   ##  average and max
##    Mkplot_vxnumdevs
  Mkplot_vxrawdata

  echo "</ul>" >> ${WebDir}/index.html

  ##
  ##  veritas filesystem cache stats
  ##

  echo "<p>Veritas Filesystem Cache Graphs</p>" >> ${WebDir}/index.html
  echo "<ul>" >> ${WebDir}/index.html

##    Mkplot_vxcache_totXdcache
##    Mkplot_vxcache_blookXbcache
##    Mkplot_vxcache_ilookXicache
##    Mkplot_vxcache_totXfast
##    Mkplot_vxcache_iaXif

  echo "</ul>" >> ${WebDir}/index.html

fi  ##  if server has veritas

##
##  create the images
##

echo
echo "Creating the images and archiving the plot scripts..."

for PlotFile in ${ServerName}*.gplot
do
  echo "  $PlotFile"
  gnuplot < $PlotFile 2>/dev/null
  mv ${PlotFile} ${ArchiveDir}/
done

## echo "  Archiving the images..."
for PNGFile in ${ServerName}*.png
do
  mv ${PNGFile} ${ArchiveDir}/
done

##  mv ${ServerName}_${StartTime}-${EndTime}*-${resX}x${resY}.png ${ServerName}_${StartTime}-${EndTime}*.gplot ${ArchiveDir}/


##
##  create the tarball of datafiles
##

echo
echo "Creating the data tarball..."

##  there are so many procbycpu files they need to be tar'd individually

for i in 1 2 3 4 5 6 7 8 9
do
  tar cf ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-ProcCPUFiles-${i}.tar ${PlotDataDir}/proccpu_pctcpu-${ServerName}-${StartTime}_${EndTime}-${i}*.dat 2>/dev/null
  tar cf ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-ProcMemFiles-${i}.tar ${PlotDataDir}/procmem_pctmem-${ServerName}-${StartTime}_${EndTime}-${i}*.dat 2>/dev/null
done  ##  for each PID leading number

for i in intr migrate smtx srw switches sys syscall usr wait 
do
  tar cf ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-MPSTAT${i}.tar ${PlotDataDir}/mpstat_${i}-${ServerName}-${StartTime}_${EndTime}*.dat 2>/dev/null
done  ##  for each mpstat statistic


tar cf ${WebDir}/${ServerName}_${StartTime}-${EndTime}-DataFiles.tar \
    ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-ProcCPUFiles-*.tar \
    ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-ProcMemFiles-*.tar \
    ${PlotDataDir}/iocalc*-${ServerName}-${StartTime}_${EndTime}*.dat \
    ${PlotDataDir}/iostat*-${ServerName}-${StartTime}_${EndTime}*.dat \
    ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-MPSTAT*.tar \
    ${PlotDataDir}/vmstat*-${ServerName}-${StartTime}_${EndTime}*.dat \
    ${PlotDataDir}/vxdisk*-${ServerName}-${StartTime}_${EndTime}*.dat \
    ${PlotDataDir}/vxstat*-${ServerName}-${StartTime}_${EndTime}*.dat \
    ${PlotDataDir}/vxvol*-${ServerName}-${StartTime}_${EndTime}*.dat \
    2>/dev/null

   ## ${PlotDataDir}/mpstat*-${ServerName}-${StartTime}_${EndTime}*.dat \
   ## iocalc
   ## iostat
   ## mpstat
   ## vmstat
   ## vxdisk
   ## vxstat
   ## vxvol

gzip ${WebDir}/${ServerName}_${StartTime}-${EndTime}-DataFiles.tar 2>/dev/null

if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}-DataFiles.tar.gz ]
then
  echo "<p>Data tarball</p>" >> ${WebDir}/index.html
  echo "<ul>" >> ${WebDir}/index.html
  echo "<li><a href=\"${ServerName}_${StartTime}-${EndTime}-DataFiles.tar.gz\">${ServerName}_${StartTime}-${EndTime}-DataFiles.tar.gz</a>" >> ${WebDir}/index.html
  echo "</ul>" >> ${WebDir}/index.html
fi

##
##  close the index.html and copy the images
##

cat >> ${WebDir}/index.html <<EOF
</body>
</html>
EOF

for PNGFile in ${ArchiveDir}/${ServerName}_${StartTime}-${EndTime}*.png
do
  cp -p ${PNGFile} ${WebDir}/
done

cp Perf-Overview-MD.css ${WebDir}/

##
##  kill the hanging gnuplot_x11 processes from the throwaway plots
##

ps -ef | egrep gnuplot_x11 | egrep -v grep | awk '{ print $2 }' | xargs kill

##
##  open the images
##

echo
echo "dougopen Graph-SingServ/${ServerName}_${StartTime}-${EndTime}*.png"
echo
