#!/bin/ksh
##
##  script to return the veritas volume given a server and veritas dm
##

##  initialize stuff

. ./DateFuncs.ksh

PATH="${PATH}:."

IFSorig="${IFS}"

ProgPrefix="/Volumes/External300/DBProgs/RacePics"

unset MYSQL
. ./SetDBCase.ksh

WorkDir=`pwd`

make >/dev/null 2>&1

##
##  arg checking
##

if [ -z "$2" ]
then
  echo
  echo "usage:  `basename $0` servername veritasDM"
  echo
  exit
fi

ServerName=$1
ServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${ServerName}'"`
VeritasDM=$2

##  echo 
##  echo "ServerName:  $ServerName"
##  echo "ServerID  :  $ServerID"
##  echo "VeritasDM :  $VeritasDM"
##  echo

${ProgPrefix}/NewQuery fsr "select volume from vxsd where server = ${ServerID} and disk = '${VeritasDM}'"

