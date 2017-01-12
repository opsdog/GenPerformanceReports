#!/bin/ksh
##
##  script to load PingTime data files
##
##  these are not collected as part of the normal DougPerfData collectors
##  but will be collected as needed for specific servers
##
##  the ping source is oxmoor so times are relative to oxmoor
##
##  collection timing is 30 minutes
##

ServerRelation()
{

  ##  horrible hack follows
  ##
  ##  for the current Server (name) (from the data file) determine the "real"
  ##  server name and interface to populate the database
  ##

  case $Server in

    aloxnhf505.wellsfargo.net )
                    RealServerName=aloxnhf505
                    RealServerIntf=nfs0
		    ;;

    aloxnsf701z1.wellsfargo.net )
                    RealServerName=aloxnsf701z1
                    RealServerIntf=nfs0
                    ;;

    mns2nsf701z1.wellsfargo.net )
                    RealServerName=mns2nsf701z1
		    RealServerIntf=nfs0
		    ;;

    mostnsf701z1.wellsfargo.net )
	            RealServerName=mostnsf701z1
		    RealServerIntf=nfs0
		    ;;

    mns2nhf503.wellsfargo.com )
                    RealServerName=mns2nhf503
                    RealServerIntf=nfs0
                    ;;

    cnpsd06a0100 )  RealServerName=cnpsd06a0100
	            RealServerIntf=bge0
		    ;;

    cnpsd06e0100 )  RealServerName=cnpsd06a0100
	            RealServerIntf=nxge5
		    ;;

    cppsd01a0101 )  RealServerName=cppsd01a0101
	            RealServerIntf=net0
		    ;;

    cppsi01a0101 )  RealServerName=cppsi01a0101
	            RealServerIntf=net0
		    ;;

    crpsi01a0101 )  RealServerName=crpsi01a0101
                    RealServerIntf=net0
                    ;;

    appsd01a0001 )  RealServerName=appsd01a0001
                    RealServerIntf=ixgbe4
                    ;;

    appsd01b0001 )  RealServerName=appsd01a0001
                    RealServerIntf=ixgbe0
                    ;;

    appsd02a0001 )  RealServerName=appsd02a0001
                    RealServerIntf=ixgbe4
                    ;;

    appsd02b0001 )  RealServerName=appsd02a0001
                    RealServerIntf=ixgbe0
                    ;;

    cppsa02a0100 )  RealServerName=cppsa02a0100
                    RealServerIntf=nxge1
                    ;;

    cppsa02e0100 )  RealServerName=cppsa02a0100
                    RealServerIntf=nxge6
                    ;;

    cppsd01a0101 )  RealServerName=cppsd01a0101
                    RealServerIntf=ipmp0
                    ;;

    cppsd02a0101 )  RealServerName=cppsd02a0101
                    RealServerIntf=ipmp0
                    ;;

    cppsd09a0100 )  RealServerName=cppsd09a0100
                    RealServerIntf=bge0
                    ;;

    cppsd09e0100 )  RealServerName=cppsd09a0100
                    RealServerIntf=nxge6
                    ;;

    cppsd13a0100 )  RealServerName=cppsd13a0100
                    RealServerIntf=bge0
                    ;;

    cppsd13e0100 )  RealServerName=cppsd13a0100
                    RealServerIntf=nxge2
                    ;;

    crpsd01a0101 )  RealServerName=crpsd01a0101
                    RealServerIntf=ipmp0
                    ;;

    cupsd01a0101 )  RealServerName=cupsd01a0101
                    RealServerIntf=ipmp0
                    ;;

    rppsd00a0001 )  RealServerName=rppsd00a0001
                    RealServerIntf=igb0
                    ;;

    rppsd01a0002 )  RealServerName=rppsd01a0002
                    RealServerIntf=igb0
                    ;;

    rppsd01e0002 )  RealServerName=rppsd01a0002
                    RealServerIntf=igb5
                    ;;

    rppsd01i0002 )  RealServerName=rppsd01a0002
                    RealServerIntf=igb4
                    ;;

    rppsd02a0002 )  RealServerName=rppsd02a0002
                    RealServerIntf=igb0
                    ;;

    rppsd02e0002 )  RealServerName=rppsd02a0002
                    RealServerIntf=igb5
                    ;;

    rppsd02i0002 )  RealServerName=rppsd02a0002
                    RealServerIntf=igb4
                    ;;

    rrpsd01a0002 )  RealServerName=rrpsd01a0002
                    RealServerIntf=igb0
                    ;;

    rrpsd01e0002 )  RealServerName=rrpsd01a0002
                    RealServerIntf=igb5
                    ;;

    rrpsd01i0002 )  RealServerName=rrpsd01a0002
                    RealServerIntf=igb4
                    ;;

    rrpsd02a0002 )  RealServerName=rrpsd02a0002
                    RealServerIntf=igb0
                    ;;

    rrpsd02e0002 )  RealServerName=rrpsd02a0002
                    RealServerIntf=igb5
                    ;;

    rrpsd02i0002 )  RealServerName=rrpsd02a0002
                    RealServerIntf=igb4
                    ;;

    cdpsd01a0101 )  RealServerName=cdpsd01a0101
                    RealServerIntf=ipmp0
                    ;;

    *  )  echo
          echo "No relation for server $Server - bailing..."
	  echo
          exit 1
          ;;

  esac

}  ##  end ServerRelation function

MakeTable()
{
  echo
  echo "Creating PingTime table..."

  $MYSQL <<EOF
use fsr;

drop table if exists pingtime;

create table pingtime (
pkey         int not null auto_increment,
datestr      char(15) default 'NULL',
esttime      int unsigned not null default 0,

srcserverid    int unsigned not null,                  ##  source server
srcserverintf varchar(11) not null default 'NULL',

destserverid     int unsigned not null,                  ##  target server
destserverintf varchar(11) not null default 'NULL',

##  ptintf       varchar(11) not null default 'NULL',
ptxmit       int not null default 0,
ptrcv        int not null default 0,
ptmin        float not null default 0.0,
ptavg        float not null default 0.0,
ptmax        float not null default 0.0,
ptstd        float not null default 0.0,

primary key (pkey),

index i_sserverid (srcserverid),
index i_dserverid (destserverid),
index i_esttime (esttime),
##  index i_ptinf (ptintf),
index i_ptmin (ptmin),
index i_ptavg (ptavg),
index i_ptmax (ptmax),
index i_ptstd (ptstd)

)
engine = MyISAM
${DBdirClause}
;

EOF

}  ##  end of MakeTable function




##  ##########################################################################
##  ##########################################################################
##
##                                      main
##
##  ##########################################################################
##  ##########################################################################

##
##  turn on/off DBLoad profiling
##

DBProfile="Prof"  ##  turn on

##  DBProfile=""      ##  turn off

##
##  initialize stuff
##

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

unset MYSQL
. ./SetDBCase.ksh

WorkDir=`pwd`
InsertFile="${WorkDir}/tmp_LoadPing_Inserts.sql"
UpdateFile="${WorkDir}/tmp_LoadPing_Updates.sql"

InputDir=${WorkDir}/Inputs/InputsPingTimes

echo
echo "LoadPingTimesTC Working from:"
echo "  $DBLocation"
echo

##
##  clear old runs
##

echo "Clearing old runs..."

rm -f $InsertFile $UpdateFile
touch $InsertFile $UpdateFile

##
##  build any required programs
##

echo "Building any required programs..."

(cd $ProgPrefix ; make ) >/dev/null 2>&1
make >/dev/null 2>&1

##
##  create the PingTime table to load
##

MakeTable

##
##  let's roll
##

echo
echo "Loading PingTime data..."

for FilePath in `ls -l ${InputDir}/*PingTest.txt 2>/dev/null | awk '{ print $NF }'`
do
  INFile=`echo $FilePath | awk -F\/ '{ print $NF }'`
  echo "  Processing $INFile"
  Server=`echo $INFile | awk -F\_ '{ print $1 }'`
  SrcServer=cnpsd06a0100
  ColDate=`echo $INFile | awk -F\_ '{ print $2 }'`

  ##  get the real source server name

  ServerRelation

  ##  echo "    Server         :  $Server"
  ##  echo "    RealServerName :  $RealServerName"
  ##  echo "    RealServerIntf :  $RealServerIntf"
  ##  echo "    ColDate        :  $ColDate"

  ##  cleanse the input file

  cat $FilePath | egrep -v 'ICMP|icmp from' > tmp_LoadPing_inputfile

  RealServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${RealServerName}'"`
  SrcServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${SrcServer}'"`

  if [ -z "${RealServerID}" ]
  then
    ##  server not in database - insert it
    echo "    Inserting $RealServerName"
    IFS=$IFSorig
$MYSQL <<EOF
    use fsr;
    insert into server (name) values ('${RealServerName}');
EOF
    RealServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${RealServerName}'"`
  fi


  if [ -z "${SrcServerID}" ]
  then
    ##  server not in database - insert it
    echo "    Inserting $SrcServer"
    IFS=$IFSorig
$MYSQL <<EOF
    use fsr;
    insert into server (name) values ('${SrcServer}');
EOF
    SrcServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${SrcServer}'"`
  fi

  ##
  ##  process the file
  ##

  ##  exec 4<$FilePath
  exec 4<tmp_LoadPing_inputfile
  while read -u4 Line
  do
    ##  echo "    ====== $Line ======"
    
    ##  extract the date and turn it into epoch seconds

    echo $Line | awk '{ print $2 }' | read DateHuman
    ${WorkDir}/ToEpoch $DateHuman | read DateEpoch

    ##  echo "      Date        : $DateHuman"
    ##  echo "      DateEpoch   : $DateEpoch"

    ##  extract the packet count

    read -u4 PacketsXMIT junk1 junk2 PacketsRCV junk3

    ##  echo "      PacketsXMIT : $PacketsXMIT"
    ##  echo "      PacketsRCV  : $PacketsRCV"

    ##  extract the stats

    read -u4 junk1 junk2 junk3 junk4 PingStats

    echo $PingStats | awk -F\/ '{ print $1" "$2" "$3" "$4 }' | read PingMIN PingAVG PingMAX PingSTD

    ##  echo "      PingStats   : $PingStats"
    ##  echo "      PingMIN     : $PingMIN"
    ##  echo "      PingAVG     : $PingAVG"
    ##  echo "      PingMAX     : $PingMAX"
    ##  echo "      PingSTD     : $PingSTD"

    ##  consume the blank line

    read -u4 Line

    ##  write the insert

    echo "insert into pingtime (destserverid, srcserver, datestr, esttime, ptintf, ptxmit, ptrcv, ptmin, ptavg, ptmax, ptstd) values (${RealServerID}, ${SrcServerID}, '${ColDate}', ${DateEpoch}, '${RealServerIntf}', ${PacketsXMIT}, ${PacketsRCV}, ${PingMIN}, ${PingAVG}, '${PingMAX}', ${PingSTD});" >> $InsertFile

  done  ##  while reading the file
  exec 4<&-

done  ##  for each input file

##
##  load the data
##

$MYSQL <<EOF
use fsr;

source ${InsertFile};

EOF

##
##  load the source to destination ping files
##

rm -f $InsertFile $UpdateFile
touch $InsertFile $UpdateFile

echo
echo "Loading Source to Destination PingTime data..."

for FilePath in `ls -l ${InputDir}/*PingTest2.txt 2>/dev/null | awk '{ print $NF }'`
do
  INFile=`echo $FilePath | awk -F\/ '{ print $NF }'`
  echo "  Processing $INFile"
  DESTServerName=`echo $INFile | awk -F\_ '{ print $3 }'`
  SRCServerName=`echo $INFile | awk -F\_ '{ print $1 }'`
  ColDate=`echo $INFile | awk -F\_ '{ print $4 }'`

  ##  get the real source server name

  Server=$SRCServerName

  ServerRelation

  SRCServerIntf=$RealServerIntf

  ##  get the real destination server name

  Server=$DESTServerName

  ServerRelation

  DESTServerIntf=$RealServerIntf

  ##  cleanse the input file

  cat $FilePath | egrep -v 'ICMP|icmp from' > tmp_LoadPing_inputfile

  SRCServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${SRCServerName}'"`
  if [ -z "${SRCServerID}" ]
  then
    ##  server not in database - insert it
    echo "    Inserting $SRCServerName"
    IFS=$IFSorig
$MYSQL <<EOF
    use fsr;
    insert into server (name) values ('${SRCServerName}');
EOF
    SRCServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${SRCServerName}'"`
  fi


  DESTServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${DESTServerName}'"`

  if [ -z "${DESTServerID}" ]
  then
    ##  server not in database - insert it
    echo "    Inserting $DESTServerName"
    IFS=$IFSorig
$MYSQL <<EOF
    use fsr;
    insert into server (name) values ('${DESTServerName}');
EOF
    DESTServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${DESTServerName}'"`
  fi

  ##
  ##  DEBUG info
  ##

  ##  echo
  ##  echo "    ColDate            :  $ColDate"
  ##  echo "    source server name :  $SRCServerName"
  ##  echo "    source server intf :  $SRCServerIntf" 
  ##  echo "    source server id   :  $SRCServerID" 
  ##  echo "    dest    server name:  $DESTServerName"
  ##  echo "    dest    server intf:  $DESTServerIntf" 
  ##  echo "    dest    server id  :  $DESTServerID" 
  ##  echo


  ##
  ##  now we know the interfaces for the server names
  ##
  ##  update the server table
  ##

${MYSQL} <<EOF
use fsr;

update server set intf = '${SRCServerIntf}' where id = ${SRCServerID};
update server set intf = '${DESTServerIntf}' where id = ${DESTServerID};
EOF

  ##
  ##  process the file
  ##

  ##  exec 4<$FilePath
  exec 4<tmp_LoadPing_inputfile
  while read -u4 Line
  do
    ##  echo "    ====== $Line ======"
    
    ##  extract the date and turn it into epoch seconds

    echo $Line | awk '{ print $2 }' | read DateHuman
    ${WorkDir}/ToEpoch $DateHuman | read DateEpoch

    ##  echo "      Date        : $DateHuman"
    ##  echo "      DateEpoch   : $DateEpoch"

    ##  extract the packet count

    read -u4 PacketsXMIT junk1 junk2 PacketsRCV junk3

    ##  echo "      PacketsXMIT : $PacketsXMIT"
    ##  echo "      PacketsRCV  : $PacketsRCV"

    ##  if all packets are lost --> PacketsRCV = 0
    ##  then skip this entry

    if [ $PacketsRCV -gt 0 ]
    then

      ##  extract the stats

      read -u4 junk1 junk2 junk3 junk4 PingStats

      echo $PingStats | awk -F\/ '{ print $1" "$2" "$3" "$4 }' | read PingMIN PingAVG PingMAX PingSTD

      ##  echo
      ##  echo "      PingStats   : $PingStats"
      ##  echo "      PingMIN     : $PingMIN"
      ##  echo "      PingAVG     : $PingAVG"
      ##  echo "      PingMAX     : $PingMAX"
      ##  echo "      PingSTD     : $PingSTD"
      ##  echo

      ##  write the insert

      echo "insert into pingtime (srcserverid, destserverid, datestr, esttime, srcserverintf, destserverintf, ptxmit, ptrcv, ptmin, ptavg, ptmax, ptstd) values (${SRCServerID}, ${DESTServerID}, '${ColDate}', ${DateEpoch}, '${SRCServerIntf}', '${DESTServerIntf}', ${PacketsXMIT}, ${PacketsRCV}, ${PingMIN}, ${PingAVG}, '${PingMAX}', ${PingSTD});" >> $InsertFile

      ##  consume the blank line

      read -u4 Line
    else
      ##  consume the blank line

      read -u4 Line

    fi  ##  if receive packets are not 0


  done  ##  while reading the file
  exec 4<&-

done  ##  for each input file

##
##  load the data
##

$MYSQL <<EOF
use fsr;

source ${InsertFile};

EOF

##
##  clean up and go home
##

##  /bin/rm -f tmp_LoadPing*
