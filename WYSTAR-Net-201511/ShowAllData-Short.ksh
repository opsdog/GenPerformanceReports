#!/bin/ksh
##
##  script to display what data is available and to extract it into CSV files
##

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

WorkDir=`pwd`

make >/dev/null 2>&1

#echo
#echo "ShowAllData Working from:"
#echo "  $DBLocation"
#echo

##
##  display the data available by server
##

echo
echo "Data available for:"

for SRCServerID in `${ProgPrefix}/NewQuery fsr "select distinct srcserverid from pingtime order by srcserverid"`
do
  ${ProgPrefix}/NewQuery fsr "select name from server where id = ${SRCServerID}" | read SRCServerName
  for DESTServerID in `${ProgPrefix}/NewQuery fsr "select distinct destserverid from pingtime where srcserverid = ${SRCServerID} order by destserverid"`
  do
    ${ProgPrefix}/NewQuery fsr "select name from server where id = ${DESTServerID}" | read DESTServerName

    echo "From $SRCServerName to $DESTServerName"

    ##
    ##  determine what collection dates are available for this path
    ##

    for ColDate in `${ProgPrefix}/NewQuery fsr "select distinct datestr from pingtime where srcserverid = ${SRCServerID} and destserverid = ${DESTServerID} order by datestr"`
    do
      echo "  $ColDate"

      ${ProgPrefix}/NewQuery fsr "select min(esttime), max(esttime) from pingtime where srcserverid = ${SRCServerID} and destserverid = ${DESTServerID} and datestr = '${ColDate}'" | read StartEpoch EndEpoch
      echo "    `../FromEpoch ${StartEpoch}` to `../FromEpoch ${EndEpoch}"

    done  ##  for each collection date
    echo
  done  ##  for each destintion for source server
done  ##  for each source server in pingtime
