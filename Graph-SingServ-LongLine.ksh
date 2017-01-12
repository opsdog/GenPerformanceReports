#!/bin/ksh
##
##  script to generate the data and produce the graphs to mimic the
##  spreadsheets i create by hand
##
##  i want to be done with excel
##

. ./MkplotFunctions.ksh

. ./Func-GPlotStats.ksh

. ./Graph-SingServ-Overview-def.ksh

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

DBLocation=`${ProgPrefix}/FindDB.ksh`
if [ "$DBLocation" = "notfound" ]
then
  echo "no database - bailing..."
  exit
fi
if [ "$DBLocation" = "localhost" ]
then
  MYSQL="mysql -u root -A"
else
  MYSQL="mysql -h big-mac -u doug -pILikeSex -A"
fi

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
ArchiveDir=${WorkDir}/Graph-LongLine
PlotDataDir=${ArchiveDir}/GPlotData
WebDir=${ArchiveDir}/Web-${ServerName}-${StartTime}-${EndTime}

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

##  resX=2048
##  resY=1024

##  sizeX=91
##  sizeY=96

##  LEGENDX=915
##  LEGENDY=93
##  LEGINCY=04

##  legfontName="Georgia Bold"
##  legfontSize=14

##  TITLEX=507
##  TITLEY=97

##  titlefontName="Arial"
##  titlefontSize=20

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
  rm -f ${PlotDataDir}/*${ServerName}-${StartTime}_${EndTime}*.dat 2>/dev/null
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

rm -f ${ArchiveDir}/${ServerName}_${StartTime}-${EndTime}*.png 2>/dev/null
rm -f ${ArchiveDir}/${ServerName}_${StartTime}-${EndTime}*.gplot 2>/dev/null

##
##  start the HTML files
##

cat > ${WebDir}/index.html <<EOF
<html>
<head>
<title>${ServerName} Performance Overview from ${StartTime} to ${EndTime}</title>
<link rel=stylesheet href="Perf-Overview-LL.css" type="text/css">
</head>
<body>
<h1 align=center>${ServerName} from ${StartTime} to ${EndTime}</h1>
EOF

##
##  create the data files
##

Make_Data_local_ll

##
##  put new functions here to test
##


##
##  create the CPU/memory stats
##

echo "<p>Overview CPU and Memory Graphs</p>" >> ${WebDir}/index.html
echo "<ul>" >> ${WebDir}/index.html

Mkplot_swap_free_local
Mkplot_sr_local
Mkplot_epaging_local
Mkplot_apaging_local
Mkplot_fpaging_local
Mkplot_cpu_local
Mkplot_kqueues_local
Mkplot_server_syscalls
Mkplot_CPUxRQ_local

echo "</ul>" >> ${WebDir}/index.html

echo "<p>Individual CPU and Dispatch Graphs</p>" >> ${WebDir}/index.html
echo "<ul>" >> ${WebDir}/index.html

Mkplot_mpstat_CPUusr
Mkplot_mpstat_CPUsys
Mkplot_mpstat_CPUwait
Mkplot_mpstat_syscall
Mkplot_mpstat_intr
Mkplot_context_switches_local
Mkplot_cpu_migrations_local
Mkplot_mpstat_SPINmutex
Mkplot_mpstat_SPINrwlock

echo "</ul>" >> ${WebDir}/index.html

##
##  create the network stats
##

echo "<p>Network Graphs</p>" >> ${WebDir}/index.html
echo "<ul>" >> ${WebDir}/index.html

Mkplot_netinput_local
Mkplot_netoutput_local

echo "</ul>" >> ${WebDir}/index.html

##
##  create the iocalc stats
##

echo "<p>Solaris Disk I/O Graphs</p>" >> ${WebDir}/index.html
echo "<ul>" >> ${WebDir}/index.html

Mkplot_iorwops_local
Mkplot_iorwk_local
Mkplot_ioawtrans_local
Mkplot_iodevcount_local
Mkplot_ioaasvct_local
Mkplot_iowasvct_local
Mkplot_servXwait_local

if [ $TESTMODE = 0 ]
then
  Mkplot_iolundata_local
  Mkplot_iolunactv_local
  Mkplot_iolunwait_local
  Mkplot_iolunservXwait_local
fi

echo "</ul>" >> ${WebDir}/index.html

##
##  create the veritas stats
##

##  check to see if this server has veritas...

VXCount=`wc -l ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }'`

if [ $VXCount -ne 0 ]
then

  echo "<p>Veritas Graphs</p>" >> ${WebDir}/index.html
  echo "<ul>" >> ${WebDir}/index.html

  Mkplot_vxops_local
  Mkplot_vxblk_local
  Mkplot_vxserv_local
  Mkplot_vxreadavgmax_local
  Mkplot_vxwriteavgmax_local
  Mkplot_vxnumdevs_local
  Mkplot_vxrawdata_local

  echo "</ul>" >> ${WebDir}/index.html

  ##
  ##  veritas filesystem cache stats
  ##

  echo "<p>Veritas Filesystem Cache Graphs</p>" >> ${WebDir}/index.html
  echo "<ul>" >> ${WebDir}/index.html

  Mkplot_vxcache_totXdcache
  Mkplot_vxcache_blookXbcache
  Mkplot_vxcache_ilookXicache
  Mkplot_vxcache_totXfast
  Mkplot_vxcache_iaXif

  echo "</ul>" >> ${WebDir}/index.html

fi  ##  if server has veritas

##
##  no process plots - way too much data to be sensible
##

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

for PNGFile in ${ArchiveDir}/${ServerName}_${StartTime}-${EndTime}*-${resX}x${resY}.png
do
  cp -p ${PNGFile} ${WebDir}/
done

cp Perf-Overview-LL.css ${WebDir}/

##
##  open the images
##

echo
echo "dougopen Graph-SingServ/${ServerName}_${StartTime}-${EndTime}*.png"
echo
