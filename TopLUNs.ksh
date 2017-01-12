#!/bin/ksh
##
##  script to show the top LUNs for activity
##
##  takes some args - see usage statement below
##
##  can also take a start and end epoch time

##
##  had to rename all the tables - the names were stuck in some internal 
##  config table
##
##    TMP_TopLUNsAllDevices --> dougee01
##    TMP_TopLUNsAllDevCount --> dougee02
##    TMP_TopLUNsKRead --> dougee03
##    TMP_TopLUNsKWrite --> dougee04
##    TMP_TopLUNsASVCT --> dougee05
##    TMP_TopLUNsWSVCT --> dougee06

##    tmp_toplunsalldevices --> dougee01
##    tmp_toplunsalldevcount --> dougee02
##    tmp_toplunskread --> dougee03
##    tmp_toplunskwrite --> dougee04
##    tmp_toplunsasvct --> dougee05
##    tmp_toplunswsvct --> dougee06
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

##
##  arg checking
##

if [ -z "$1" -o -z "$2" ]
then
  echo
  echo "usage:  `basename $0` servername limit [ startDATE endDATE ]"
  echo
  exit
fi

ServerName=$1
ServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${ServerName}'"`
Limit=$2

if [ ! -z "$3" -a -z "$4" ]
then
  echo
  echo "usage:  `basename $0` servername limit [ startDATE endDATE ]"
  echo
  echo "        if ya give me a start, i need an end"
  echo
  exit
fi

StartEpoch=`ToEpoch $3`
EndEpoch=`ToEpoch $4`

if [ ! -z "$3" ]
then
  ## WHERECLAUSE="serverid = ${ServerID} and esttime between $StartEpoch and $EndEpoch and device like '%t%' "
  WHERECLAUSE="serverid = ${ServerID} and esttime between $StartEpoch and $EndEpoch and ( devtype = 1 or devtype = 2 ) "
  ReportCSV=${WorkDir}/RPT_TopLUNs_${ServerName}_${Limit}_`FromEpoch ${StartEpoch} -s`-`FromEpoch ${EndEpoch} -s`.csv
  ReportTXT=${WorkDir}/RPT_TopLUNs_${ServerName}_${Limit}_`FromEpoch ${StartEpoch} -s`-`FromEpoch ${EndEpoch} -s`.txt
else
  ## WHERECLAUSE="serverid = ${ServerID} and device like '%t%' "
  WHERECLAUSE="serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) "
  ReportCSV=${WorkDir}/RPT_TopLUNs_${ServerName}_${Limit}_ALL.csv
  ReportTXT=${WorkDir}/RPT_TopLUNs_${ServerName}_${Limit}_ALL.txt
fi

rm -f $ReportCSV $ReportTXT
touch $ReportCSV $ReportTXT

##
##  create the temp tables
##

echo
echo "Creating work tables..."

$MYSQL <<EOF
use fsr;

##  ALTER TABLE tmp_toplunskread DISCARD TABLESPACE;
##  ALTER TABLE tmp_toplunskwrite DISCARD TABLESPACE;
##  ALTER TABLE tmp_toplunsasvct DISCARD TABLESPACE;
##  ALTER TABLE tmp_toplunswsvct DISCARD TABLESPACE;

drop table if exists tmp_toplunskread;
drop table if exists tmp_toplunskwrite;
drop table if exists tmp_toplunsasvct;
drop table if exists tmp_toplunswsvct;

create table tmp_toplunskread (
  pkey int not null auto_increment,
  krs float,
  device varchar(50),
  datestr char(15),
  esttime int,

  primary key (pkey)
)
engine = MyISAM
${DBdirClause}
;

insert into tmp_toplunskread (krs, device, datestr, esttime)
  select
    krs, device, datestr, esttime
  from
    iostat
  where
    ${WHERECLAUSE}
  order by
    krs desc limit ${Limit}
;

create table tmp_toplunskwrite (
  pkey int not null auto_increment,
  kws float,
  device varchar(50),
  datestr char(15),
  esttime int,

  primary key (pkey)
)
engine = MyISAM
${DBdirClause}
;

insert into tmp_toplunskwrite (kws, device, datestr, esttime)
  select
    kws, device, datestr, esttime
  from
    iostat
  where
    ${WHERECLAUSE}
  order by
    kws desc limit ${Limit}
;

create table tmp_toplunsasvct (
  pkey int not null auto_increment,
  asvct float,
  device varchar(50),
  datestr char(15),
  esttime int,

  primary key (pkey)
)
engine = MyISAM
${DBdirClause}
;

insert into tmp_toplunsasvct (asvct, device, datestr, esttime)
  select
    asvct, device, datestr, esttime
  from
    iostat
  where
    ${WHERECLAUSE}
  order by
    asvct desc limit ${Limit}
;

create table tmp_toplunswsvct (
  pkey int not null auto_increment,
  wsvct float,
  device varchar(50),
  datestr char(15),
  esttime int,

  primary key (pkey)
)
engine = MyISAM
${DBdirClause}
;

insert into tmp_toplunswsvct (wsvct, device, datestr, esttime)
  select
    wsvct, device, datestr, esttime
  from
    iostat
  where
    ${WHERECLAUSE} and wsvct > 0.0
  order by
    wsvct desc limit ${Limit}
;

EOF

##
##  write the report header
##

echo "Server,Metric,Limit,Device,Array,SAN ID,Count,Value(s),Timestamp(s)" > ${ReportCSV}

##
##  show top LUNs by K reads
##

echo
echo "Top $Limit LUNs by Kbytes of data read..."
echo "Top $Limit LUNs by Kbytes of data read:" >> ${ReportTXT}
DeviceCount=`${ProgPrefix}/NewQuery fsr "select count(distinct device) from tmp_toplunskread"`
echo "  $DeviceCount LUNs make up the top $Limit" >> ${ReportTXT}

for Device in `${ProgPrefix}/NewQuery fsr "select distinct device from tmp_toplunskread"`
do

    ##  echo "  ###################################################################"
    ##  echo "  ###################################################################"
    ##  echo 
    ##  echo "  TOP OF LOOP"
    ##  echo 
    ##  echo "  Starting with Device = $Device"

  DevAppears=`${ProgPrefix}/NewQuery fsr "select count(*) from tmp_toplunskread where device = '${Device}'"`
  KReadsC=`${ProgPrefix}/SVCQuery fsr "select krs from tmp_toplunskread where device = '${Device}'"`
  KReadsS=`${ProgPrefix}/SVSQuery fsr "select krs from tmp_toplunskread where device = '${Device}'"`
  Epochs=`${ProgPrefix}/SVCQuery fsr "select esttime from tmp_toplunskread where device = '${Device}'"`
  unset DeviceASMGroup DeviceASMName DeviceSANid DevicePrimaryPath DeviceRawName

  ${ProgPrefix}/NewQuery fsr "select name, ArrayNum, SANid from disk where server = ${ServerID} and name like '${Device}s%'" | read DevicePrimaryPath DeviceArraySer DeviceSANid
  ##  DeviceRawName=`echo $DevicePrimaryPath | sed s/s[0-9]$//`
  DeviceRawName=`echo $DevicePrimaryPath | sed s/s[0-9]$// | sed s/^c[0-9]/c\%/`

  ##  echo "  Primary path is $DevicePrimaryPath --> $DeviceRawName"

  ##
  ##  we should have a valid SAN id
  ##  try to figure out what the disk is in use as
  ##

  ##  echo
  ##  echo
  ##  echo "    Server:             $ServerName"
  ##  echo "    ServerID:           $ServerID"
  ##  echo "    Device:             $Device"
  ##  echo "    DeviceArraySer:     $DeviceArraySer"
  ##  echo "    DeviceSANid:        $DeviceSANid"
  ##  echo "    DevicePrimaryPath:  $DevicePrimaryPath"
  ##  echo "    DeviceRawName:      $DeviceRawName"
  ##  echo "    DevAppears:         $DevAppears"
  ##  echo "    KReadsC:            $KReadsC"
  ##  echo "    KReadsS:            $KReadsS"
  ##  echo "    Epochs:             $Epochs"
  ##  echo
  ##  echo

  unset DeviceASMGroup DeviceASMName
  DeviceASMGroup=`${ProgPrefix}/NewQuery fsr "select ASMgroup from asmmap where server = ${ServerID} and name like '${DeviceRawName}s%'"`
  DeviceASMName=`${ProgPrefix}/NewQuery fsr "select ASMname from asmmap where server = ${ServerID} and name like '${DeviceRawName}s%'"`

  ##  echo 
  ##  echo "  After checking if ASM: $ServerID $Device $DeviceSANid $DevicePrimaryPath"

  if [ -z "${DeviceASMName}" ]
  then
    ## echo
    ##  echo "  Not an ASM disk - check Veritas..."

    ##  get potential veritas disk "names"

    for PotVDisk in `${ProgPrefix}/NewQuery fsr "select name from disk where server = ${ServerID} and ArrayNum = '${DeviceArraySer}' and SANid = '${DeviceSANid}'"`
    do
      ##  echo "    Checking $PotVDisk as a potential Veritas disk"
      ${ProgPrefix}/NewQuery fsr "select diskgroup, name from vdisk where server = ${ServerID} and device = '${PotVDisk}'" | read DeviceASMGroup DeviceASMName
      if [ ! -z "$DeviceASMGroup" ]
      then
	break
      fi
    done

    ##  if DeviceASMName is still null - it must be ZFS
    if [ -z "${DeviceASMName}" ]
    then
      echo "  Not ASM or Veritas - check ZFS..."
      ${ProgPrefix}/NewQuery fsr "select pool, state from zfsmap where server = ${ServerID} and name like '${DeviceRawName}%'" | read DeviceASMName DeviceASMGroup
    fi  ##  if not asm or veritas
  fi  ##  if not asm

  if [ -z "${DeviceSANid}" ]
  then
    DeviceSANid="NULL"
  fi

  echo "    $Device (${DeviceArraySer},${DeviceSANid},${DeviceASMName}) appears $DevAppears times with values $KReadsS" >> ${ReportTXT}

  echo "${ServerName},krs,${Limit},${Device},${DeviceArraySer},${DeviceSANid},${DevAppears},${KReadsC}${Epochs}" >> ${ReportCSV}
  
done  ##  for each Device

##
##  show top LUNs by K writes
##

echo >> ${ReportTXT}
echo "Top $Limit LUNs by Kbytes of data write..."
echo "Top $Limit LUNs by Kbytes of data write:" >> ${ReportTXT}
DeviceCount=`${ProgPrefix}/NewQuery fsr "select count(distinct device) from tmp_toplunskwrite"`
echo "  $DeviceCount LUNs make up the top $Limit" >> ${ReportTXT}

for Device in `${ProgPrefix}/NewQuery fsr "select distinct device from tmp_toplunskwrite"`
do

    ##  echo "  ###################################################################"
    ##  echo "  ###################################################################"
    ##  echo 
    ##  echo "  TOP OF LOOP"
    ##  echo 
    ##  echo "  Starting with Device = $Device"

  DevAppears=`${ProgPrefix}/NewQuery fsr "select count(*) from tmp_toplunskwrite where device = '${Device}'"`
  KWritesC=`${ProgPrefix}/SVCQuery fsr "select kws from tmp_toplunskwrite where device = '${Device}'"`
  KWritesS=`${ProgPrefix}/SVSQuery fsr "select kws from tmp_toplunskwrite where device = '${Device}'"`
  Epochs=`${ProgPrefix}/SVCQuery fsr "select esttime from tmp_toplunskwrite where device = '${Device}'"`


  unset DeviceASMGroup DeviceASMName DeviceSANid DevicePrimaryPath DeviceRawName
  ##  DevicePrimaryPath=`${ProgPrefix}/NewQuery fsr "select pridev from diskpaths where serverid = ${ServerID} and device like '${Device}s%'"`
  ##  if [ -z "${DevicePrimaryPath}" ]
  ##  then
    ##  DevicePrimaryPath=${Device}s2
  ##  fi
  ##  DeviceArraySer=`${ProgPrefix}/NewQuery fsr "select arraynum from disk where server = ${ServerID} and name = '${DevicePrimaryPath}'"`
  ##  DeviceSANid=`${ProgPrefix}/NewQuery fsr "select SANid from disk where server = ${ServerID} and name = '${DevicePrimaryPath}'"`

  ${ProgPrefix}/NewQuery fsr "select name, ArrayNum, SANid from disk where server = ${ServerID} and name like '${Device}s%'" | read DevicePrimaryPath DeviceArraySer DeviceSANid

  DeviceRawName=`echo $DevicePrimaryPath | sed s/s[0-9]$//`

  ##  echo "    Primary path is $DevicePrimaryPath --> $DeviceRawName"

  ##
  ##  we should have a valid SAN id
  ##  try to figure out what the disk is in use as
  ##

  ##  echo
  ##  echo
  ##  echo "    Server:             $ServerName"
  ##  echo "    ServerID:           $ServerID"
  ##  echo "    Device:             $Device"
  ##  echo "    DeviceArraySer:     $DeviceArraySer"
  ##  echo "    DeviceSANid:        $DeviceSANid"
  ##  echo "    DevicePrimaryPath:  $DevicePrimaryPath"
  ##  echo "    DeviceRawName:      $DeviceRawName"
  ##  echo "    DevAppears:         $DevAppears"
  ##  echo "    KReadsC:            $KReadsC"
  ##  echo "    KReadsS:            $KReadsS"
  ##  echo "    Epochs:             $Epochs"
  ##  echo
  ##  echo

  unset DeviceASMGroup DeviceASMName
  DeviceASMGroup=`${ProgPrefix}/NewQuery fsr "select ASMgroup from asmmap where server = ${ServerID} and name like '${DeviceRawName}s%'"`
  DeviceASMName=`${ProgPrefix}/NewQuery fsr "select ASMname from asmmap where server = ${ServerID} and name like '${DeviceRawName}s%'"`

  ## echo 
  ## echo "      ASM queries:  $DeviceASMGroup $DeviceASMName"
  if [ -z "${DeviceASMName}" ]
  then
    ## echo
    ## echo "  Not an ASM disk - check Veritas..."


    ##  get potential veritas disk "names"

    for PotVDisk in `${ProgPrefix}/NewQuery fsr "select name from disk where server = ${ServerID} and ArrayNum = '${DeviceArraySer}' and SANid = '${DeviceSANid}'"`
    do
      ##  echo "    Checking $PotVDisk as a potential Veritas disk"
      ${ProgPrefix}/NewQuery fsr "select diskgroup, name from vdisk where server = ${ServerID} and device = '${PotVDisk}'" | read DeviceASMGroup DeviceASMName
      if [ ! -z "$DeviceASMGroup" ]
      then
	break
      fi
    done

    ##  if DeviceASMName is still null - it must be ZFS
    if [ -z "${DeviceASMName}" ]
    then
      ## echo "    Not ASM or Veritas - check ZFS..."
      ${ProgPrefix}/NewQuery fsr "select pool, state from zfsmap where server = ${ServerID} and name like '${DeviceRawName}%'" | read DeviceASMName DeviceASMGroup
    fi  ##  if not asm or veritas
  fi  ##  if not asm


  if [ -z "${DeviceSANid}" ]
  then
    DeviceSANid="NULL"
  fi

  echo "    $Device (${DeviceArraySer},${DeviceSANid},${DeviceASMName}) appears $DevAppears times with values $KWritesS" >> ${ReportTXT}

  echo "${ServerName},kws,${Limit},${Device},${DeviceArraySer},${DeviceSANid},${DevAppears},${KWritesC}${Epochs}" >> ${ReportCSV}
  
done

##
##  show top LUNs by service time (asvct)
##

echo >> ${ReportTXT}
echo "Top $Limit LUNs by service time (ms)..."
echo "Top $Limit LUNs by service time (ms):" >> ${ReportTXT}
DeviceCount=`${ProgPrefix}/NewQuery fsr "select count(distinct device) from tmp_toplunsasvct"`
echo "  $DeviceCount LUNs make up the top $Limit" >> ${ReportTXT}

for Device in `${ProgPrefix}/NewQuery fsr "select distinct device from tmp_toplunsasvct"`
do

    ##  echo "  ###################################################################"
    ##  echo "  ###################################################################"
    ##  echo 
    ##  echo "  TOP OF LOOP"
    ##  echo 
    ##  echo "  Starting with Device = $Device"

  DevAppears=`${ProgPrefix}/NewQuery fsr "select count(*) from tmp_toplunsasvct where device = '${Device}'"`
  asvctC=`${ProgPrefix}/SVCQuery fsr "select asvct from tmp_toplunsasvct where device = '${Device}'"`
  asvctS=`${ProgPrefix}/SVSQuery fsr "select asvct from tmp_toplunsasvct where device = '${Device}'"`
  Epochs=`${ProgPrefix}/SVCQuery fsr "select esttime from tmp_toplunsasvct where device = '${Device}'"`

  unset DeviceASMGroup DeviceASMName DeviceSANid DevicePrimaryPath DeviceRawName
  ##  DevicePrimaryPath=`${ProgPrefix}/NewQuery fsr "select pridev from diskpaths where serverid = ${ServerID} and device like '${Device}s%'"`
  ##  if [ -z "${DevicePrimaryPath}" ]
  ##  then
    ##  DevicePrimaryPath=${Device}s2
  ##  fi
  ##  DeviceArraySer=`${ProgPrefix}/NewQuery fsr "select arraynum from disk where server = ${ServerID} and name = '${DevicePrimaryPath}'"`
  ##  DeviceSANid=`${ProgPrefix}/NewQuery fsr "select SANid from disk where server = ${ServerID} and name = '${DevicePrimaryPath}'"`

  ${ProgPrefix}/NewQuery fsr "select name, ArrayNum, SANid from disk where server = ${ServerID} and name like '${Device}s%'" | read DevicePrimaryPath DeviceArraySer DeviceSANid

  DeviceRawName=`echo $DevicePrimaryPath | sed s/s[0-9]$//`
  ##  echo "        Primary path is $DevicePrimaryPath --> $DeviceRawName"

  ##
  ##  we should have a valid SAN id
  ##  try to figure out what the disk is in use as
  ##

  ##  echo
  ##  echo
  ##  echo "    Server:             $ServerName"
  ##  echo "    ServerID:           $ServerID"
  ##  echo "    Device:             $Device"
  ##  echo "    DeviceArraySer:     $DeviceArraySer"
  ##  echo "    DeviceSANid:        $DeviceSANid"
  ##  echo "    DevicePrimaryPath:  $DevicePrimaryPath"
  ##  echo "    DeviceRawName:      $DeviceRawName"
  ##  echo "    DevAppears:         $DevAppears"
  ##  echo "    KReadsC:            $KReadsC"
  ##  echo "    KReadsS:            $KReadsS"
  ##  echo "    Epochs:             $Epochs"
  ##  echo
  ##  echo

  unset DeviceASMGroup DeviceASMName
  DeviceASMGroup=`${ProgPrefix}/NewQuery fsr "select ASMgroup from asmmap where server = ${ServerID} and name like '${DeviceRawName}s%'"`
  DeviceASMName=`${ProgPrefix}/NewQuery fsr "select ASMname from asmmap where server = ${ServerID} and name like '${DeviceRawName}s%'"`

  ## echo 
  ## echo "$ServerID $Device $DeviceSANid $DevicePrimaryPath"
  if [ -z "${DeviceASMName}" ]
  then
    ## echo
    ## echo "  Not an ASM disk - check Veritas..."

    ##  get potential veritas disk "names"

    for PotVDisk in `${ProgPrefix}/NewQuery fsr "select name from disk where server = ${ServerID} and ArrayNum = '${DeviceArraySer}' and SANid = '${DeviceSANid}'"`
    do
      ##  echo "    Checking $PotVDisk as a potential Veritas disk"
      ${ProgPrefix}/NewQuery fsr "select diskgroup, name from vdisk where server = ${ServerID} and device = '${PotVDisk}'" | read DeviceASMGroup DeviceASMName
      if [ ! -z "$DeviceASMGroup" ]
      then
	break
      fi
    done

    ##  if DeviceASMName is still null - it must be ZFS
    if [ -z "${DeviceASMName}" ]
    then
      ## echo "    Not ASM or Veritas - check ZFS..."
      ${ProgPrefix}/NewQuery fsr "select pool, state from zfsmap where server = ${ServerID} and name like '${DeviceRawName}%'" | read DeviceASMName DeviceASMGroup
    fi  ##  if not asm or veritas
  fi  ##  if not asm

  if [ -z "${DeviceSANid}" ]
  then
    DeviceSANid="NULL"
  fi

  echo "    $Device (${DeviceArraySer},${DeviceSANid},${DeviceASMName}) appears $DevAppears times with values $asvctS" >> ${ReportTXT}

  echo "${ServerName},asvct,${Limit},${Device},${DeviceArraySer},${DeviceSANid},${DevAppears},${asvctC}${Epochs}" >> ${ReportCSV}
  
done

##
##  show top LUNs by service time (wsvct)
##

echo >> ${ReportTXT}
echo "Top $Limit LUNs by wait time (ms)..."
echo "Top $Limit LUNs by wait time (ms):" >> ${ReportTXT}
DeviceCount=`${ProgPrefix}/NewQuery fsr "select count(distinct device) from tmp_toplunswsvct"`
echo "  $DeviceCount LUNs make up the top $Limit (non-zero)" >> ${ReportTXT}

for Device in `${ProgPrefix}/NewQuery fsr "select distinct device from tmp_toplunswsvct"`
do

    ##  echo "  ###################################################################"
    ##  echo "  ###################################################################"
    ##  echo 
    ##  echo "  TOP OF LOOP"
    ##  echo 
    ##  echo "  Starting with Device = $Device"

  DevAppears=`${ProgPrefix}/NewQuery fsr "select count(*) from tmp_toplunswsvct where device = '${Device}'"`
  wsvctC=`${ProgPrefix}/SVCQuery fsr "select wsvct from tmp_toplunswsvct where device = '${Device}'"`
  wsvctS=`${ProgPrefix}/SVSQuery fsr "select wsvct from tmp_toplunswsvct where device = '${Device}'"`
  Epochs=`${ProgPrefix}/SVCQuery fsr "select esttime from tmp_toplunswsvct where device = '${Device}'"`

  unset DeviceASMGroup DeviceASMName DeviceSANid DevicePrimaryPath DeviceRawName
  ##  DevicePrimaryPath=`${ProgPrefix}/NewQuery fsr "select pridev from diskpaths where serverid = ${ServerID} and device like '${Device}s%'"`
  ##  if [ -z "${DevicePrimaryPath}" ]
  ##  then
    ##  DevicePrimaryPath=${Device}s2
  ##  fi
  ##  DeviceArraySer=`${ProgPrefix}/NewQuery fsr "select arraynum from disk where server = ${ServerID} and name = '${DevicePrimaryPath}'"`
  ##  DeviceSANid=`${ProgPrefix}/NewQuery fsr "select SANid from disk where server = ${ServerID} and name = '${DevicePrimaryPath}'"`

  ${ProgPrefix}/NewQuery fsr "select name, ArrayNum, SANid from disk where server = ${ServerID} and name like '${Device}s%'" | read DevicePrimaryPath DeviceArraySer DeviceSANid

  DeviceRawName=`echo $DevicePrimaryPath | sed s/s[0-9]$//`
  ##  echo "        Primary path is $DevicePrimaryPath --> $DeviceRawName"

  ##
  ##  we should have a valid SAN id
  ##  try to figure out what the disk is in use as
  ##

  ##  echo
  ##  echo
  ##  echo "    Server:             $ServerName"
  ##  echo "    ServerID:           $ServerID"
  ##  echo "    Device:             $Device"
  ##  echo "    DeviceArraySer:     $DeviceArraySer"
  ##  echo "    DeviceSANid:        $DeviceSANid"
  ##  echo "    DevicePrimaryPath:  $DevicePrimaryPath"
  ##  echo "    DeviceRawName:      $DeviceRawName"
  ##  echo "    DevAppears:         $DevAppears"
  ##  echo "    KReadsC:            $KReadsC"
  ##  echo "    KReadsS:            $KReadsS"
  ##  echo "    Epochs:             $Epochs"
  ##  echo
  ##  echo

  unset DeviceASMGroup DeviceASMName
  DeviceASMGroup=`${ProgPrefix}/NewQuery fsr "select ASMgroup from asmmap where server = ${ServerID} and name like '${DeviceRawName}s%'"`
  DeviceASMName=`${ProgPrefix}/NewQuery fsr "select ASMname from asmmap where server = ${ServerID} and name like '${DeviceRawName}s%'"`

  ## echo 
  ## echo "$ServerID $Device $DeviceSANid $DevicePrimaryPath"
  if [ -z "${DeviceASMName}" ]
  then
    ## echo
    ## echo "  Not an ASM disk - check Veritas..."

    ##  get potential veritas disk "names"

    for PotVDisk in `${ProgPrefix}/NewQuery fsr "select name from disk where server = ${ServerID} and ArrayNum = '${DeviceArraySer}' and SANid = '${DeviceSANid}'"`
    do
      ##  echo "    Checking $PotVDisk as a potential Veritas disk"
      ${ProgPrefix}/NewQuery fsr "select diskgroup, name from vdisk where server = ${ServerID} and device = '${PotVDisk}'" | read DeviceASMGroup DeviceASMName
      if [ ! -z "$DeviceASMGroup" ]
      then
	break
      fi
    done

    ##  if DeviceASMName is still null - it must be ZFS
    if [ -z "${DeviceASMName}" ]
    then
      ## echo "    Not ASM or Veritas - check ZFS..."
      ${ProgPrefix}/NewQuery fsr "select pool, state from zfsmap where server = ${ServerID} and name like '${DeviceRawName}%'" | read DeviceASMName DeviceASMGroup
    fi  ##  if not asm or veritas
  fi  ##  if not asm

  if [ -z "${DeviceSANid}" ]
  then
    DeviceSANid="NULL"
  fi

  echo "    $Device (${DeviceArraySer},${DeviceSANid},${DeviceASMName}) appears $DevAppears times with values $wsvctS" >> ${ReportTXT}

  echo "${ServerName},wsvct,${Limit},${Device},${DeviceArraySer},${DeviceSANid},${DevAppears},${wsvctC}${Epochs}" >> ${ReportCSV}
  
done

##
##  now we have the top LUNs by various parameters
##
##  let's do some cumulative stats...
##

##
##  determine LUNs that appear the most in all categories
##

echo >> ${ReportTXT}
echo
echo "Cumulative stats..."
#echo "Cumulative stats:" >> ${ReportTXT}

echo "  Building temp tables"

${MYSQL} <<EOF
use fsr;

drop table if exists tmp_toplunsalldevices;
drop table if exists tmp_toplunsalldevcount;

create table tmp_toplunsalldevices (
pkey         int not null auto_increment,
device       varchar(50),
datestr      char(15),
esttime      int,

primary key (pkey)
);

create table tmp_toplunsalldevcount (
pkey         int not null auto_increment,
device       varchar(50),
count        int,

primary key (pkey)
);

EOF

##  get the info from the performance parameter TMP tables

rm -f tmp_toplunsalldevs

${ProgPrefix}/NewQuery fsr "select device, datestr, esttime from tmp_toplunskread" > tmp_toplunsalldevs
${ProgPrefix}/NewQuery fsr "select device, datestr, esttime from tmp_toplunskwrite" >> tmp_toplunsalldevs
${ProgPrefix}/NewQuery fsr "select device, datestr, esttime from tmp_toplunsasvct" >> tmp_toplunsalldevs
${ProgPrefix}/NewQuery fsr "select device, datestr, esttime from tmp_toplunswsvct" >> tmp_toplunsalldevs

exec 4<tmp_toplunsalldevs
while read -u4 device datestr esttime
do
${MYSQL} <<EOF
use fsr;
insert into tmp_toplunsalldevices (device, datestr, esttime) values ('${device}', '${datestr}', ${esttime});
EOF
done
exec 4<&-

##  count how often each device appears in all performance tables

echo
echo "Top $Limit overall devices..."
echo "Top $Limit overall devices:" >> $ReportTXT

for Device in `${ProgPrefix}/NewQuery fsr "select distinct(device) from tmp_toplunsalldevices"`
do

    ##  echo "  ###################################################################"
    ##  echo "  ###################################################################"
    ##  echo 
    ##  echo "  TOP OF INSERT LOOP"
    ##  echo 
    ##  echo "  Starting with Device = $Device"

  DevCount=`${ProgPrefix}/NewQuery fsr "select count(device) from tmp_toplunsalldevices where device = '${Device}'"`
  ${MYSQL} <<EOF
  use fsr;

  insert into tmp_toplunsalldevcount (device, count) values ('${Device}', ${DevCount});
EOF
done

${ProgPrefix}/NewQuery fsr "select device, count from tmp_toplunsalldevcount order by count desc limit 10" > tmp_toplunsbig10

exec 4<tmp_toplunsbig10
while read -u4 Device DeviceCount
do

    ##  echo "  ###################################################################"
    ##  echo "  ###################################################################"
    ##  echo 
    ##  echo "  TOP OF PROCESSING LOOP"
    ##  echo 
    ##  echo "  Starting with Device = $Device"

  unset DeviceASMGroup DeviceASMName DeviceSANid DevicePrimaryPath DeviceRawName
  ##  DevicePrimaryPath=`${ProgPrefix}/NewQuery fsr "select pridev from diskpaths where serverid = ${ServerID} and device like '${Device}s%'"`
  ##  if [ -z "${DevicePrimaryPath}" ]
  ##  then
    ##  DevicePrimaryPath=${Device}s2
  ##  fi
  ##  DeviceArraySer=`${ProgPrefix}/NewQuery fsr "select arraynum from disk where server = ${ServerID} and name = '${DevicePrimaryPath}'"`
  ##  DeviceSANid=`${ProgPrefix}/NewQuery fsr "select SANid from disk where server = ${ServerID} and name = '${DevicePrimaryPath}'"`

  ${ProgPrefix}/NewQuery fsr "select name, ArrayNum, SANid from disk where server = ${ServerID} and name like '${Device}s%'" | read DevicePrimaryPath DeviceArraySer DeviceSANid

  DeviceRawName=`echo $DevicePrimaryPath | sed s/s[0-9]$//`
  ##  echo "        Primary path is $DevicePrimaryPath --> $DeviceRawName"

  ##
  ##  we should have a valid SAN id
  ##  try to figure out what the disk is in use as
  ##

  ##  echo
  ##  echo
  ##  echo "    Server:             $ServerName"
  ##  echo "    ServerID:           $ServerID"
  ##  echo "    Device:             $Device"
  ##  echo "    DeviceArraySer:     $DeviceArraySer"
  ##  echo "    DeviceSANid:        $DeviceSANid"
  ##  echo "    DevicePrimaryPath:  $DevicePrimaryPath"
  ##  echo "    DeviceRawName:      $DeviceRawName"
  ##  echo "    DevAppears:         $DevAppears"
  ##  echo "    KReadsC:            $KReadsC"
  ##  echo "    KReadsS:            $KReadsS"
  ##  echo "    Epochs:             $Epochs"
  ##  echo
  ##  echo

  unset DeviceASMGroup DeviceASMName
  DeviceASMGroup=`${ProgPrefix}/NewQuery fsr "select ASMgroup from asmmap where server = ${ServerID} and name like '${DeviceRawName}s%'"`
  DeviceASMName=`${ProgPrefix}/NewQuery fsr "select ASMname from asmmap where server = ${ServerID} and name like '${DeviceRawName}s%'"`

  ## echo 
  ## echo "$ServerID $Device $DeviceSANid $DevicePrimaryPath"
  if [ -z "${DeviceASMName}" ]
  then
    ## echo
    ## echo "  Not an ASM disk - check Veritas..."

    ##  get potential veritas disk "names"

    for PotVDisk in `${ProgPrefix}/NewQuery fsr "select name from disk where server = ${ServerID} and ArrayNum = '${DeviceArraySer}' and SANid = '${DeviceSANid}'"`
    do
      ##  echo "    Checking $PotVDisk as a potential Veritas disk"
      ${ProgPrefix}/NewQuery fsr "select diskgroup, name from vdisk where server = ${ServerID} and device = '${PotVDisk}'" | read DeviceASMGroup DeviceASMName
      if [ ! -z "$DeviceASMGroup" ]
      then
	break
      fi
    done

    ##  if DeviceASMName is still null - it must be ZFS
    if [ -z "${DeviceASMName}" ]
    then
      ## echo "    Not ASM or Veritas - check ZFS..."
      ${ProgPrefix}/NewQuery fsr "select pool, state from zfsmap where server = ${ServerID} and name like '${DeviceRawName}%'" | read DeviceASMName DeviceASMGroup
    fi  ##  if not asm or veritas
  fi  ##  if not asm


  if [ -z "${DeviceSANid}" ]
  then
    DeviceSANid="NULL"
  fi

  echo "  $Device (${DeviceArraySer},${DeviceSANid}) appears $DeviceCount times (${DeviceASMName})" >> $ReportTXT
  echo -n "${ServerName},ALL,${Limit},${Device},${DeviceArraySer},${DeviceSANid},${DeviceCount}" >> $ReportCSV
  for Epoch in `${ProgPrefix}/NewQuery fsr "select esttime from tmp_toplunsalldevices where device = '${Device}'"`
  do
    HumanDate=`FromEpoch $Epoch`
    echo -n ",$HumanDate" >> $ReportCSV
  done  ##  for each epoch time
  echo >> $ReportCSV
done  ##  while reading device count file
exec 4<&-
