#!/bin/ksh
##
##  script to display what data is available and to extract it into CSV files
##

##  initialize stuff

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

for ServerID in `${ProgPrefix}/NewQuery fsr "select distinct serverid from colldate order by serverid"`
do
  #echo $ServerID
  ServerName=`${ProgPrefix}/NewQuery fsr "select name from server where id = $ServerID"`
  ServerOS=`${ProgPrefix}/NewQuery fsr "select OS from server where id = $ServerID"`
  echo
  echo "  $ServerName (${ServerOS})"

  ##
  ##  determine what collection dates are available for this server
  ##

  case $ServerOS in

    SunOS )  ##  echo "    Pulling coldates for SunOS (${ServerID})..."
             ColDates=`${ProgPrefix}/NewQuery fsr "select distinct datestr from vmstat where serverid = ${ServerID} order by datestr"`
	     VMTable=vmstat
	     WhereClause="and vmtype = 'S'"
	     ;;

    Linux )
             ColDates=`${ProgPrefix}/NewQuery fsr "select distinct datestr from linux_vmstat where serverid = ${ServerID} order by datestr"`
	     VMTable=linux_vmstat
	     WhereClause=""
	     ;;

    * )      echo "Unsupported OS $ServerOS - bailing..."
	     exit 1
	     ;;

  esac

  for ColDate in $ColDates
  do
    echo "    $ColDate"

    ##
    ##  determine what type of perf data is available for this server/date
    ##

    VM_S_Data=`${ProgPrefix}/NewQuery fsr "select count(esttime) from ${VMTable} where serverid = $ServerID and datestr = '$ColDate' ${WhereClause}"`

    ##  echo "      $VM_S_Data"

    if [ $VM_S_Data != 0 ]
    then
      echo -n "      vmstat -S  from "
      MinEpoch=`${ProgPrefix}/NewQuery fsr "select min(esttime) from ${VMTable} where serverid = $ServerID and datestr = '$ColDate' ${WhereClause}"`
      MaxEpoch=`${ProgPrefix}/NewQuery fsr "select max(esttime) from ${VMTable} where serverid = $ServerID and datestr = '$ColDate' ${WhereCluase}"`
      #echo "        $MinEpoch to $MaxEpoch"
      MinDate=`./FromEpoch $MinEpoch`
      MaxDate=`./FromEpoch $MaxEpoch`
      echo "$MinDate to $MaxDate"

    fi  ##  if we have vmstat -S data

  done  ##  for each collection date for this server
done  ##  for each serverid

##
##  clean up and go home
##

echo 
