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

export PATH="${PATH}:`pwd`"

make >/dev/null 2>&1

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

. ./SetDBCase.ksh

BaseDir=`pwd`
ArchiveDir=`pwd`/Graph-SingServ
WorkDir=${ArchiveDir}/${ServerName}_$$
WebDir=${ArchiveDir}/Web-${ServerName}-${StartTime}-${EndTime}
PlotDataDir=${WorkDir}/GPlotData
## WebDir=/Volumes/External300/Sites/TheFirst60Feet.com/WFPerf/${ServerName}-${StartTime}-${EndTime}
## RangeFile=${ArchiveDir}/Ranges

unset asvctNOT0
if [ "$1" = "-i" ]
then
  asvctNOT0=1
fi  ##  if arg1 is -i

ServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${ServerName}'"`
ServerOS=`${ProgPrefix}/NewQuery fsr "select os from server where id = ${ServerID}"`

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

if [ ! -d ${ArchiveDir} ]
then
  mkdir -p ${ArchiveDir} 2>/dev/null
fi

if [ -d $PlotDataDir ]
then
  rm -f ${PlotDataDir}/*${ServerName}-${StartTime}_${EndTime}*.dat 2>/dev/null
else
  mkdir -p $PlotDataDir 2>/dev/null
fi

if [ ! -d $WorkDir ]
then
  mkdir -p $WorkDir
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
<link rel=stylesheet href="Perf-Overview.css" type="text/css">
</head>
<body>
<h1 align=center>${ServerName} from ${StartTime} to ${EndTime}</h1>
EOF

##
##  create the data files
##

Make_Data_local

##
##  put new functions here to test
##

##  Mkplot_iolunperops_local

##  exit

## echo "<p>Solaris Tape I/O Graphs</p>" >> ${WebDir}/index.html
## echo "<ul>" >> ${WebDir}/index.html

## Mkplot_iorwops_tape_local
## Mkplot_iorwk_tape_local
## Mkplot_ioawtrans_tape_local
## Mkplot_iodevcount_tape_local
## Mkplot_ioaasvct_tape_local

## if [ $TESTMODE = 0 ]
## then
##   Mkplot_iolundata_tape_local
##   Mkplot_iolunactv_tape_local
## fi

##  add read k per op
##  add write k per op

## echo "</ul>" >> ${WebDir}/index.html

## exit

##
##  create the CPU/memory stats
##

echo "<p>Overview CPU and Memory Graphs</p>" >> ${WebDir}/index.html
echo "<ul>" >> ${WebDir}/index.html

case ${ServerOS} in

  SunOS )
           Mkplot_swap_free_local
	   Mkplot_sr_local
	   Mkplot_epaging_local
	   Mkplot_apaging_local
	   Mkplot_fpaging_local
	   Mkplot_cpu_local
	   Mkplot_kqueues_local
	   Mkplot_server_syscalls
	   Mkplot_CPUxRQ_local
	   ;;

  Linux )
           Mkplot_swap_free_linux
	   ;;

  *     )  echo "Unsupported OS $ServerOS - bailing..."
           exit 1
	   ;;

esac

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

##  notused  ##  Mkplot_nicinput_local
##  notused  ##  Mkplot_nicoutput_local

Mkplot_nicutil_local
Mkplot_nicthru_local

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
  Mkplot_iolunperops_local
fi

##  add read k per op
##  add write k per op

echo "</ul>" >> ${WebDir}/index.html

##
##  check to see if this server has NFS...
##

NFSCount=`wc -l ${PlotDataDir}/iocalcnfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }'`

if [ $NFSCount -ne 0 ]
then

  echo "<p>NFS Mount I/O Graphs</p>" >> ${WebDir}/index.html
  echo "<ul>" >> ${WebDir}/index.html

  Mkplot_iorwopsnfs_local
  Mkplot_iorwknfs_local
  Mkplot_ioawtransnfs_local
  Mkplot_iodevcountnfs_local
  Mkplot_ioaasvctnfs_local
  Mkplot_iowasvctnfs_local
  Mkplot_servXwaitnfs_local

  if [ $TESTMODE = 0 ]
  then
    Mkplot_iolundatanfs_local
    Mkplot_iolunactvnfs_local
    Mkplot_iolunwaitnfs_local
    Mkplot_iolunservXwaitnfs_local
    Mkplot_iolunperopsnfs_local
  fi

  echo "</ul>" >> ${WebDir}/index.html

fi  ##  if server has NFS mounts

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

  echo "<p>Veritas Overhead</p>" >> ${WebDir}/index.html
  echo "<ul>" >> ${WebDir}/index.html

  Mkplot_vxo_avgservtime
  Mkplot_vxo_rawservtime

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
##  ACFS plots
##

ACFSCount=`wc -l ${PlotDataDir}/iocalcacfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }'`

if [ $ACFSCount -ne 0 ]
then

  echo "<p>ACFS Mount I/O Graphs</p>" >> ${WebDir}/index.html
  echo "<ul>" >> ${WebDir}/index.html

  Mkplot_iorwopsacfs_local
  Mkplot_iorwkacfs_local
  Mkplot_ioawtransacfs_local
  Mkplot_iodevcountacfs_local
  Mkplot_ioaasvctacfs_local
  Mkplot_iowasvctacfs_local
  Mkplot_servXwaitacfs_local

  if [ $TESTMODE = 0 ]
  then
    Mkplot_iolundataacfs_local
    Mkplot_iolunactvacfs_local
    Mkplot_iolunwaitacfs_local
    Mkplot_iolunservXwaitacfs_local
    Mkplot_iolunperopsacfs_local
  fi

  echo "</ul>" >> ${WebDir}/index.html

fi  ##  if server has ACFS


##
##  create the process plots
##

echo "<p>Process Graphs (if data available)</p>" >> ${WebDir}/index.html
echo "<ul>" >> ${WebDir}/index.html

Mkplot_procbymem_local
Mkplot_procbycpu_local

echo "</ul>" >> ${WebDir}/index.html


##
##  create the images
##

echo
echo "Creating the images and archiving the plot scripts..."

(
  cd $WorkDir
  for PlotFile in ${ServerName}*.gplot
  do
    echo "  $PlotFile"
    gnuplot < $PlotFile 2>/dev/null
    ##  mv ${PlotFile} ${ArchiveDir}/
  done
)

## echo "  Archiving the images..."
##  for PNGFile in ${WorkDir}/${ServerName}*.png
##  do
##    mv ${PNGFile} ${ArchiveDir}/
##  done

##  mv ${ServerName}_${StartTime}-${EndTime}*-${resX}x${resY}.png ${ServerName}_${StartTime}-${EndTime}*.gplot ${ArchiveDir}/


##
##  create the tarball of datafiles
##
##  WFPerf went from  13G (13358628)
##                to 6.6G ( 6933480)
##

##  echo
##  echo "Creating the data tarball..."

##  there are so many procbycpu files they need to be tar'd individually

##  for i in 1 2 3 4 5 6 7 8 9
##  do
##    tar cf ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-ProcCPUFiles-${i}.tar ${PlotDataDir}/proccpu_pctcpu-${ServerName}-${StartTime}_${EndTime}-${i}*.dat 2>/dev/null
##    tar cf ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-ProcMemFiles-${i}.tar ${PlotDataDir}/procmem_pctmem-${ServerName}-${StartTime}_${EndTime}-${i}*.dat 2>/dev/null
##  done  ##  for each PID leading number

##  for i in intr migrate smtx srw switches sys syscall usr wait 
##  do
##    tar cf ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-MPSTAT${i}.tar ${PlotDataDir}/mpstat_${i}-${ServerName}-${StartTime}_${EndTime}*.dat 2>/dev/null
##  done  ##  for each mpstat statistic


##  tar cf ${WebDir}/${ServerName}_${StartTime}-${EndTime}-DataFiles.tar \
##      ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-ProcCPUFiles-*.tar \
##      ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-ProcMemFiles-*.tar \
##      ${PlotDataDir}/iocalc*-${ServerName}-${StartTime}_${EndTime}*.dat \
##      ${PlotDataDir}/iostat*-${ServerName}-${StartTime}_${EndTime}*.dat \
##      ${PlotDataDir}/${ServerName}_${StartTime}-${EndTime}-MPSTAT*.tar \
##      ${PlotDataDir}/vmstat*-${ServerName}-${StartTime}_${EndTime}*.dat \
##      ${PlotDataDir}/vxdisk*-${ServerName}-${StartTime}_${EndTime}*.dat \
##      ${PlotDataDir}/vxstat*-${ServerName}-${StartTime}_${EndTime}*.dat \
##      ${PlotDataDir}/vxvol*-${ServerName}-${StartTime}_${EndTime}*.dat \
##      2>/dev/null

##  gzip ${WebDir}/${ServerName}_${StartTime}-${EndTime}-DataFiles.tar 2>/dev/null

##  if [ -f ${WebDir}/${ServerName}_${StartTime}-${EndTime}-DataFiles.tar.gz ]
##  then
##    echo "<p>Data tarball</p>" >> ${WebDir}/index.html
##    echo "<ul>" >> ${WebDir}/index.html
##    echo "<li><a href=\"${ServerName}_${StartTime}-${EndTime}-DataFiles.tar.gz\">${ServerName}_${StartTime}-${EndTime}-DataFiles.tar.gz</a>" >> ${WebDir}/index.html
##    echo "</ul>" >> ${WebDir}/index.html
##  fi

##
##  close the index.html and copy the images
##

cat >> ${WebDir}/index.html <<EOF
</body>
</html>
EOF

##  for PNGFile in ${ArchiveDir}/${ServerName}_${StartTime}-${EndTime}*-${resX}x${resY}.png
for PNGFile in ${WorkDir}/${ServerName}_${StartTime}-${EndTime}*-${resX}x${resY}.png
do
  mv ${PNGFile} ${WebDir}/
done

cp ${BaseDir}/Perf-Overview.css ${WebDir}/

##
##  kill any hanging gnuplot_x11 processes from the throwaway plots
##

ps -ef | egrep gnuplot_x11 | egrep -v grep | awk '{ print $2 }' | xargs kill

##
##  clear the working directory
##

cd $BaseDir
rm -rf $WorkDir

##
##  open the images
##

##  echo
##  echo "dougopen Graph-SingServ/${ServerName}_${StartTime}-${EndTime}*.png"
##  echo
