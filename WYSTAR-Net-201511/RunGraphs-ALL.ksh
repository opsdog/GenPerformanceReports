#!/bin/ksh
##
##  script to run network stats for all pingtime data loaded
##

##  no args to check

##  initialize stuff

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
WorkDir=${ArchiveDir}/ALL_$$
WebDir=${ArchiveDir}/Net1-ALL-${StartTime}-${EndTime}
PlotDataDir=${WorkDir}/GPlotData

##
##  get the server list from the pingtime table
##

for SRCServerInfo in `${ProgPrefix}/NewQuery fsr "select name, id from server where id in ( select distinct srcserverid from pingtime order by srcserverid) order by name" | tr ' ' ','`
do
  echo $SRCServerInfo | tr ',' ' ' | read SRCServerName SRCServerID
  echo "====== $SRCServerName ======"

  for DSTServerInfo in `${ProgPrefix}/NewQuery fsr "select name, id from server where id in ( select distinct destserverid from pingtime where srcserverid = ${SRCServerID} order by destserverid) order by name" | tr ' ' ','`
  do
    echo $DSTServerInfo | tr ',' ' ' | read DSTServerName DSTServerID
    echo "  to $DSTServerName"

    ##  get the min and max times for this server pair

    ##  ${ProgPrefix}/NewQuery fsr "select min(esttime), max(esttime) from pingtime where serverid = ${ServerID}" | read StartEpoch EndEpoch
    ${ProgPrefix}/NewQuery fsr "select min(esttime), max(esttime) from pingtime where srcserverid = ${SRCServerID} and destserverid = ${DSTServerID}" | read StartEpoch EndEpoch
    ##  echo "  $StartEpoch --> $EndEpoch"
    StartTime=`../FromEpoch $StartEpoch -s`
    EndTime=`../FromEpoch $EndEpoch -s`
    ##  echo "  $StartTime --> $EndTime"

    echo "    ./Net-PingVSPacket.ksh $SRCServerName $DSTServerName $DSTServerName $StartTime $EndTime"

    ./Net-PingVSPacket.ksh $SRCServerName $DSTServerName $DSTServerName $StartTime $EndTime >/dev/null 2>&1

  done  ##  for each DSTserver

done  ##  for each SRCserver
