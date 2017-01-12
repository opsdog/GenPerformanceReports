#!/bin/ksh
##
##  script to generate graphs that show network interface packet
##  counts vs. interface latency as measured from oxmoor
##

. ../MkplotFunctions.ksh

. ../Func-GPlotStats.ksh

. ./Net-PingVSPacket-def.ksh

######################################################################
######################################################################
##
##  main
##
######################################################################
######################################################################

##  arg checks

if [ -z "$5" ]
then
  echo
  echo "usage:  `basename $0` SRCservername DESTservername RealDESTservername startTIME endTIME [ -t ]"
  echo
  exit
fi

if [ "$6" = "-t" ]
then
  TESTMODE=1
else
  TESTMODE=0
fi

SRCServerName=$1
DESTServerName=$2
RealDESTServerName=$3
StartTime=$4
EndTime=$5
StartEpoch=`../ToEpoch $4`
EndEpoch=`../ToEpoch $5`

## initialize stuff

. ../DateFuncs.ksh

MyEMail="doug.greenwald@gmail.com"

PATH="${PATH}:."

IFSorig="${IFS}"

if [ -d /Volumes/External300/DBProgs/RacePics ]
then
  ProgPrefix="/Volumes/External300/DBProgs/RacePics"
else
  ProgPrefix="/Users/douggreenwald/RacePics"
fi

. ../SetDBCase.ksh

ArchiveDir=`pwd`/Graph-PvsP
WorkDir=${ArchiveDir}/${SRCServerName}_${DESTServerName}_$$
WebDir=${ArchiveDir}/Net1-${SRCServerName}_${DESTServerName}-${StartTime}-${EndTime}
PlotDataDir=${WorkDir}/GPlotData

SRCServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${SRCServerName}'"`
DESTServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${DESTServerName}'"`
RealDESTServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${RealDESTServerName}'"`
SRCServerOS=`${ProgPrefix}/NewQuery fsr "select os from server where id = ${SRCServerID}"`
DESTServerOS=`${ProgPrefix}/NewQuery fsr "select os from server where id = ${DESTServerID}"`
SRCServerIntf=`${ProgPrefix}/NewQuery fsr "select intf from server where id = ${SRCServerID}"`
DESTServerIntf=`${ProgPrefix}/NewQuery fsr "select intf from server where id = ${DESTServerID}"`

##  echo
##  echo "  start time     :  $StartTime (${StartEpoch})"
##  echo "  end   time     :  $EndTime (${EndEpoch})"
##  echo "  source server  :  $SRCServerName"
##  echo "  source serverid:  $SRCServerID"
##  echo "  source intf    :  $SRCServerIntf"
##  echo "  source serveros:  $SRCServerOS"
##  echo "  dest   server  :  $DESTServerName"
##  echo "  dest   serverid:  $DESTServerID"
##  echo "  dest   intf    :  $DESTServerIntf"
##  echo "  dest   serveros:  $DESTServerOS"
##  echo "  real d server  :  $RealDESTServerName"
##  echo

##
##  resolution independent graph parameters
##

originX="01"
originY="01"

scaleX=1
scaleY=1

GFileBase="TestSize"

##  set the default graph size

SetGraph4K

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
  rm -f ${PlotDataDir}/*${SRCServerName}_${DESTServerName}-${StartTime}_${EndTime}*.dat 2>/dev/null
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

rm -f ${ArchiveDir}/${SRCServerName}_${DESTServerName}_${StartTime}-${EndTime}*.png 2>/dev/null
rm -f ${ArchiveDir}/${SRCServerName}_${DESTServerName}_${StartTime}-${EndTime}*.gplot 2>/dev/null

##
##  start the HTML files
##

cat > ${WebDir}/index.html <<EOF
<html>
<head>
<title>${SRCServerName} to ${DESTServerName} Network Details from ${StartTime} to ${EndTime}</title>
<link rel=stylesheet href="Perf-Overview.css" type="text/css">
</head>
<body>
<h1 align=center>${SRCServerName} (${SRCServerIntf}) to ${DESTServerName} (${DESTServerIntf})<br>${StartTime} to ${EndTime}</h2>
<br clear=all>
EOF

##
##  create the data files
##

Make_Data_local

##
##  latency for all interfaces
##

echo
echo "<p>Latency</p>" >> ${WebDir}/index.html
echo "<ul>"  >> ${WebDir}/index.html

Mkplot_latency_all

echo "</ul>"  >> ${WebDir}/index.html

##
##  packet count for all interfaces
##

##  echo "<p>Packet Counts</p>" >> ${WebDir}/index.html
##  echo "<ul>"  >> ${WebDir}/index.html

##  Mkplot_packetcount_all

##  echo "</ul>"  >> ${WebDir}/index.html

##
##  packet count vs latencey for all interface
##

echo "<p>NIC Packet Count vs Latency</p>" >> ${WebDir}/index.html
echo "<ul>" >> ${WebDir}/index.html

echo "<p>Source NIC:</p>" >> ${WebDir}/index.html
echo "<blockquote>" >> ${WebDir}/index.html
Mkplot_packetVSlatency_src
echo "</blockquote>" >> ${WebDir}/index.html
echo "<p>Destination NIC:</p>" >> ${WebDir}/index.html
echo "<blockquote>" >> ${WebDir}/index.html
Mkplot_packetVSlatency_dest
echo "</blockquote>" >> ${WebDir}/index.html

echo "</ul>" >> ${WebDir}/index.html

##
##  NIC utilization vs latencey for all interface
##

echo "<p>NIC Utilization vs Latency</p>" >> ${WebDir}/index.html
echo "<ul>" >> ${WebDir}/index.html

echo "<p>Source NIC:</p>" >> ${WebDir}/index.html
echo "<blockquote>" >> ${WebDir}/index.html
Mkplot_nicutilVSlatency_src
echo "</blockquote>" >> ${WebDir}/index.html
echo "<p>Destination NIC:</p>" >> ${WebDir}/index.html
echo "<blockquote>" >> ${WebDir}/index.html
Mkplot_nicutilVSlatency_dest
echo "</blockquote>" >> ${WebDir}/index.html

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

##
##  close the index.html and copy the images
##

cat >> ${WebDir}/index.html <<EOF
</body>
</html>
EOF

##  for PNGFile in ${WorkDir}/${ServerName}_${StartTime}-${EndTime}*-${resX}x${resY}.png
##  for PNGFile in ${WorkDir}/${ServerName}_${StartTime}-${EndTime}*.png ${WorkDir}/${ServerName}_${StartTime}-${EndTime}*.jpg
##  for PNGFile in `ls -l ${WorkDir}/${SRCServerName}-${DESTServerName}_${StartTime}-${EndTime}*.png ${WorkDir}/${SRCServerName}_${DESTServerName}_${StartTime}-${EndTime}*.jpg 2>/dev/null | awk '{ print $NF }'`
for PNGFile in `ls -l ${WorkDir}/*.png ${WorkDir}/*.jpg 2>/dev/null | awk '{ print $NF }'`
do
  mv ${PNGFile} ${WebDir}/
done

cp /Volumes/External300/DBProgs/FSRServers/DougPerfData/Perf-Overview.css ${WebDir}

##
##  clear the working directory
##

rm -rf $WorkDir
