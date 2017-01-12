#!/bin/ksh
##
##  script to generate the iostat and iocalc based graphs of a 
##  subset of a server's disks
##
##  disks are listed in a file with the first line of either
##  "Veritas" or "Solaris"
##
##  a Veritas file contains dm entries from a veritas disk group
##
##  a Solaris files contains CTDs 
##

##
##  do all graphs from Graph-SingleServer.ksh
##
##  do all reports from GenPRB-SAN.ksh
##

##  Graph-DiskGroup.ksh server startDATE endDATE DiskListFile

##  get CTD from veritas dm name:
##    select diskgroup, disk, device from vxsd where server = 29 and disk = 'p1ogl99_redodg_asm012'

##  get array and ldev given CTD(s2)
##    select name, ArrayNum, SANid from disk where server = 29 and name like 'c1t50060E801662764Ad141s%'

##  get all CTDs with given array and LDEV
##    select name, ArrayNum, SANid from disk where server = 29 and ArrayNum = 90742 and SANid = '0F:04'

##  get data from iostat for server and CTD (no slice)
##    select device, rs from iostat where serverid = 29 and device = 'c2t50060E801662765Ad141'

##
##  initialize stuff
##

. ./MkplotFunctions.ksh

. ./DateFuncs.ksh

. ./Func-GPlotStats.ksh

. ./Graph-DiskGroup-def.ksh

export PATH="${PATH}:`pwd`"

MyEMail="doug.greenwald@gmail.com"

PATH="${PATH}:."

IFSorig="${IFS}"

ProgPrefix="/Volumes/External300/DBProgs/RacePics"

. ./SetDBCase.ksh

##  process args

if [ -z "$4" ]
then
  echo
  echo "Usage:  `basename $0` server startDATE endDATE DiskListFile [ -n ]"
  echo 
  exit 10
fi

ServerName=$1
StartTime=$2
EndTime=$3

StartEpoch=`./ToEpoch $2`
EndEpoch=`./ToEpoch $3`

FindAllPaths=1
if [ ! -z "$5" ]
then
  if [ "$5" = "-n" ]
  then
    FindAllPaths=0
  fi
fi

##
##  local variables
##

ServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${ServerName}'"`
ServerOS=`${ProgPrefix}/NewQuery fsr "select os from server where id = ${ServerID}"`

##  these are variables used to control various aspects of the plot

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
##  prep the work directories
##

echo
echo "Clearing old runs..."

BaseDir=`pwd`
ArchiveDir=`pwd`/Graph-DiskGroup
WorkDir=${ArchiveDir}/${ServerName}_$$
WebDir=${ArchiveDir}/Web-${ServerName}-${StartTime}-${EndTime}
PlotDataDir=${WorkDir}/GPlotData

##  echo
##  echo "Working from:"
##  echo "  BaseDir     :  $BaseDir"
##  echo "  ArchiveDir  :  $ArchiveDir"
##  echo "  WorkDir     :  $WorkDir"
##  echo "  WebDir      :  $WebDir"
##  echo "  PlotDataDir :  $PlotDataDir"
##  echo

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

cd $BaseDir

##
##  get the disk information
##

exec 4<$4

read -u 4 DiskGroupType
read -u 4 DiskGroupName
echo
echo "Reading '${DiskGroupName}' (${DiskGroupType}) members..."

case $DiskGroupType in

  Veritas )  echo "  Processing Veritas disks..."
	     rm -f ${WorkDir}/tmp_gdg_CTDs2 2>/dev/null
	     touch ${WorkDir}/tmp_gdg_CTDs2
	     rm -f ${WorkDir}/tmp_gdg_CTD 2>/dev/null
	     touch ${WorkDir}/tmp_gdg_CTD
	     while read -u4 DiskMember
	     do
	       ##  echo "    $DiskMember"
               ##  get the CTDs from the dm entries
	       ${ProgPrefix}/NewQuery fsr "select device from vxsd where server = ${ServerID} and disk = '${DiskMember}'" | read CTD
	       CTDS2="${CTD}s2"
	       echo $CTDS2 >> ${WorkDir}/tmp_gdg_CTDs2
	       echo $CTD   >> ${WorkDir}/tmp_gdg_CTD
	     done
             ;;

  Solaris )  echo "  Processing Solaris disks..."
             while read -u4 CTD
	     do
	       CTDS2="${CTD}s2"
               echo $CTDS2 >> ${WorkDir}/tmp_gdg_CTDs2
               echo $CTD   >> ${WorkDir}/tmp_gdg_CTD
	     done
             ;;

  * )        echo
             echo "UNKNOWN disk group type $DiskGroupType - bailing..."
             exit 20
             ;;

esac
exec 4<&-

##
##  now we have 2 lists of disks - CTD and CTDs2 comprised of our 
##  specified disks.

if [ $FindAllPaths = 1 ]
then

  ##
  ##  now find the array and LDEV info for each of the target disks
  ##
  ##  then find each path to that array and LDEV
  ##

  echo
  echo "Finding all iostat paths for each CTDs2..."
  rm -f ${WorkDir}/tmp_gdg_iostatpaths 2>/dev/null
  touch ${WorkDir}/tmp_gdg_iostatpaths
  exec 4<${WorkDir}/tmp_gdg_CTDs2
  while read -u 4 CTDs2
  do
    ${ProgPrefix}/NewQuery fsr "select ArrayNum, SANid from disk where server = ${ServerID} and name = '${CTDs2}'" | read ArrayDEC LDEV
    ##  echo "  $CTDs2 $ArrayDEC $LDEV"

    for CTDs2Path in `${ProgPrefix}/NewQuery fsr "select name from disk where server = ${ServerID} and ArrayNum = ${ArrayDEC} and SANid = '${LDEV}'"`
    do
      CTDPath=`echo $CTDs2Path | sed s/s2$//`
      ##  echo "    $CTDs2Path --> $CTDPath"
      echo "    $CTDPath" >> ${WorkDir}/tmp_gdg_iostatpaths
    done  ##  for each LUN path

  done  ##  while reading each CTDs2
  exec 4<&-
  NumIOPaths=`wc -l ${WorkDir}/tmp_gdg_iostatpaths | awk '{ print $1 }'`
  echo "  $NumIOPaths iostat paths found"

else  

  ##
  ##  do not find all paths - use the exact disks given
  ##

  cp ${WorkDir}/tmp_gdg_CTD ${WorkDir}/tmp_gdg_iostatpaths
  NumIOPaths=`wc -l ${WorkDir}/tmp_gdg_iostatpaths | awk '{ print $1 }'`
  echo "  $NumIOPaths iostat paths found"

fi  ##  if FindAllPaths

##
##  at this point we have all knowns paths that iostat reports on
##  or all paths we want to report on
##

##
##  let's make some temp tables from iostat that contain just this data
##

echo
echo "Creating the iostat and iocalc tables ($$)..."

${MYSQL} <<EOF

use fsr;

drop table if exists tmp_gdg_iostat_$$;
drop table if exists tmp_gdg_iocalc_$$;

create table tmp_gdg_iostat_$$ (
pkey         int not null auto_increment,
serverid     int unsigned not null,
datestr      char(15) default 'NULL',
esttime      int unsigned not null default 0,

rs       float not null default 0.0,   ##  read ops
ws       float not null default 0.0,   ##  write ops
krs      float not null default 0.0,   ##  kbytes read per second
kws      float not null default 0.0,   ##  kbytes written per second
wait     float not null default 0.0,   ##  avg num transactions waiting (q len)
actv     float not null default 0.0,   ##  avg num transactions being serviced
wsvct    float not null default 0.0,   ##  avg time spent in queue (wait)
asvct    float not null default 0.0,   ##  avg actual service time
pctw     int unsigned not null default 0,  ##  % of time queue non-empty
pctb     int unsigned not null default 0,  ##  % of time disk is busy processing
device   varchar(75),                  ##  the device
avgread  float not null default 0.0,   ##  avg read i/o size
avgwrit  float not null default 0.0,   ##  avg write i/o size
devtype  int default -1,

primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_datestr (datestr),
index i_rs (rs),
index i_ws (ws),
index i_krs (krs),
index i_kws (kws),
index i_wait (wait),
index i_actv (actv),
index i_wsvct (wsvct),
index i_asvct (asvct),
index i_pctb (pctb),
index i_device (device),
index i_devtype (devtype),

index i_estwsvct (esttime, wsvct),
index i_estasvct (esttime, asvct),
index i_servestwsvct (serverid, esttime, wsvct),
index i_servestasvct (serverid, esttime, asvct),

index i_servdate (serverid, datestr),
index i_servest (serverid, esttime)

)
engine = MyISAM
${DBdirClause}
;


create table tmp_gdg_iocalc_$$ (
pkey         int not null auto_increment,
serverid     int unsigned not null,
esttime      int unsigned not null default 0,

rs_sum      float not null default 0.0,
ws_sum      float not null default 0.0,
krs_sum     float not null default 0.0,
kws_sum     float not null default 0.0,
wait_sum    float not null default 0.0,
actv_sum    float not null default 0.0,
wsvct_avg   float not null default 0.0,
asvct_avg   float not null default 0.0,
pctw_avg    float not null default 0.0,
pctb_avg    float not null default 0.0,
avgread_avg float not null default 0.0,
avgwrit_avg float not null default 0.0,
asvct_avg_a float not null default 0.0,
wsvct_avg_a float not null default 0.0,
adevices    int   not null default 0,
wkperop     float not null default 0.0,
rkperop     float not null default 0.0,

primary key (pkey),

index i_serverid (serverid),
index i_esttime (esttime),
index i_rssum (rs_sum),
index i_wssum (ws_sum),
index i_krssum (krs_sum),
index i_kwssum (kws_sum),
index i_actvsum (actv_sum),
index i_asvct_avg (asvct_avg),
index i_adevices (adevices),
index i_wkperop (wkperop),
index i_rkperop (rkperop),

index i_servest (serverid, esttime)

) engine = MyISAM
;

EOF

##
##  loop on each path and populate the tmp tables
##

##  echo
##  echo "WHACKING THE IOSTAT PATHS FOR DEBUGGING..."
##  wc -l ${WorkDir}/tmp_gdg_iostatpaths | awk '{ print $1 }' | read dougeeBEFORE
##  head -2 ${WorkDir}/tmp_gdg_iostatpaths > ${WorkDir}/dougee
##  mv ${WorkDir}/dougee ${WorkDir}/tmp_gdg_iostatpaths
##  wc -l ${WorkDir}/tmp_gdg_iostatpaths | awk '{ print $1 }' | read dougeeAFTER
##  echo "  $dougeeBEFORE --> $dougeeAFTER"

echo
echo "Populating temp iostat table..."

exec 4<${WorkDir}/tmp_gdg_iostatpaths
while read -u 4 IOPath
do
  printf "."
  ##  echo "  $IOPath"

  ##  echo "    iostat"
${MYSQL} <<EOF

use fsr;

insert into tmp_gdg_iostat_$$ 
    (serverid, rs, ws, krs, kws, wait, actv, wsvct, asvct, pctw, pctb, device, 
     avgread, avgwrit, devtype, esttime)
  select
    serverid, rs, ws, krs, kws, wait, actv, wsvct, asvct, pctw, pctb, device, 
    avgread, avgwrit, devtype, esttime
  from
    iostat
  where
    serverid = ${ServerID} and
    esttime between ${StartEpoch} and ${EndEpoch} and
    device = '${IOPath}'
  ;

EOF

done  ##  while reading each iostat path
exec 4<&-

echo

##
##  iocalc isn't by CTD so only need to do a single insert
##

echo
echo "  iocalc"

##  ${MYSQL} <<EOF

##  use fsr;

##  insert into tmp_gdg_iocalc_$$
##      (serverid, esttime, rs_sum, ws_sum, krs_sum, kws_sum, wait_sum, actv_sum,
##       pctw_avg, pctb_avg, avgread_avg, avgwrit_avg, asvct_avg_a, wsvct_avg_a,
##       adevices, wkperop, rkperop, wsvct_avg, asvct_avg)
##    select
##      serverid, esttime, rs_sum, ws_sum, krs_sum, kws_sum, wait_sum, actv_sum,
##      pctw_avg, pctb_avg, avgread_avg, avgwrit_avg, asvct_avg_a, wsvct_avg_a,
##      adevices, wkperop, rkperop, wsvct_avg, asvct_avg
##    from
##      iocalc
##    where
##      serverid = ${ServerID} and
##      esttime between ${StartEpoch} and ${EndEpoch}
##    ;

##  EOF

./CreateIOCalc-GDG $$

##
##  now we have a tmp table with iostat info for just the 
##  disks in this group.
##
##  this should make generating the data files easier - less overall
##  data to select from and the time range has already been accounted
##  for
##

##
##  generate the iostat data files for the plots
##

echo
echo "Generating iostat data files..."

echo "  SAN devices"

${ProgPrefix}/NewQuery fsr "select asvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and asvct != 0.0  order by esttime, asvct" > ${PlotDataDir}/iostat_asvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select wsvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and wsvct != 0.0  order by esttime, wsvct" > ${PlotDataDir}/iostat_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select actv from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and actv != 0.0  order by esttime, actv" > ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select avgread from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgread != 0.0  order by esttime, avgread" > ${PlotDataDir}/iostat_readkperop-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select avgwrit from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgwrit != 0.0  order by esttime, avgwrit" > ${PlotDataDir}/iostat_writkperop-${ServerName}-${StartTime}_${EndTime}.dat

##  with timestamps for combined charts

${ProgPrefix}/NewQuery fsr "select esttime, asvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and asvct != 0.0  order by esttime, asvct" > ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, wsvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and wsvct != 0.0  order by esttime, wsvct" > ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, actv from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and actv != 0.0  order by esttime, actv" > ${PlotDataDir}/iostat_timeactv-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, avgread from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgread != 0.0  order by esttime, avgread" > ${PlotDataDir}/iostat_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, avgwrit from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and avgwrit != 0.0  order by esttime, avgwrit" > ${PlotDataDir}/iostat_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat

##
##  ACFS mount stats
##

echo "  ACFS mounts"

${ProgPrefix}/NewQuery fsr "select asvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 7 and asvct != 0.0  order by esttime, asvct" > ${PlotDataDir}/iostatacfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select wsvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 7 and wsvct != 0.0  order by esttime, wsvct" > ${PlotDataDir}/iostatacfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select actv from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 7 and actv != 0.0  order by esttime, actv" > ${PlotDataDir}/iostatacfs_actv-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select avgread from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 7 and avgread != 0.0  order by esttime, avgread" > ${PlotDataDir}/iostatacfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select avgwrit from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 7 and avgwrit != 0.0  order by esttime, avgwrit" > ${PlotDataDir}/iostatacfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat

##  with timestamps for combined charts

${ProgPrefix}/NewQuery fsr "select esttime, asvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 7 and asvct != 0.0  order by esttime, asvct" > ${PlotDataDir}/iostatacfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, wsvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 7 and wsvct != 0.0  order by esttime, wsvct" > ${PlotDataDir}/iostatacfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, actv from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 7 and actv != 0.0  order by esttime, actv" > ${PlotDataDir}/iostatacfs_timeactv-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, avgread from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 7 and avgread != 0.0  order by esttime, avgread" > ${PlotDataDir}/iostatacfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, avgwrit from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 7 and avgwrit != 0.0  order by esttime, avgwrit" > ${PlotDataDir}/iostatacfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat

##
##  NFS mount stats
##

echo "  NFS mounts"

${ProgPrefix}/NewQuery fsr "select asvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 4 and asvct != 0.0  order by esttime, asvct" > ${PlotDataDir}/iostatnfs_asvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select wsvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 4 and wsvct != 0.0  order by esttime, wsvct" > ${PlotDataDir}/iostatnfs_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select actv from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 4 and actv != 0.0  order by esttime, actv" > ${PlotDataDir}/iostatnfs_actv-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select avgread from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 4 and avgread != 0.0  order by esttime, avgread" > ${PlotDataDir}/iostatnfs_readkperop-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select avgwrit from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 4 and avgwrit != 0.0  order by esttime, avgwrit" > ${PlotDataDir}/iostatnfs_writkperop-${ServerName}-${StartTime}_${EndTime}.dat

##  with timestamps for combined charts

${ProgPrefix}/NewQuery fsr "select esttime, asvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 4 and asvct != 0.0  order by esttime, asvct" > ${PlotDataDir}/iostatnfs_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, wsvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 4 and wsvct != 0.0  order by esttime, wsvct" > ${PlotDataDir}/iostatnfs_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, actv from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 4 and actv != 0.0  order by esttime, actv" > ${PlotDataDir}/iostatnfs_timeactv-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, avgread from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 4 and avgread != 0.0  order by esttime, avgread" > ${PlotDataDir}/iostatnfs_timereadkperop-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, avgwrit from tmp_gdg_iostat_$$ where serverid = ${ServerID} and devtype = 4 and avgwrit != 0.0  order by esttime, avgwrit" > ${PlotDataDir}/iostatnfs_timewritkperop-${ServerName}-${StartTime}_${EndTime}.dat

##
##  individual path data files
##

printf "  Individual path iostat data"

exec 4<${WorkDir}/tmp_gdg_iostatpaths
while read -u4 IOPath
do
  printf "."
  ${ProgPrefix}/NewQuery fsr "select esttime, rs, ws, krs, kws, wait, actv, wsvct, asvct, avgread, avgwrit, ( krs / rs), ( kws / ws) from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2) and device = '${IOPath}' order by esttime" > ${PlotDataDir}/iostatpath_timeALL-${ServerName}-${StartTime}_${EndTime}-${IOPath}.dat
done
echo
exec 4<&-

##  dougee

##  echo "  Generating RAW iostat data..."
##  ${ProgPrefix}/NewQuery fsr "select asvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and asvct != 0.0  order by esttime, asvct" > ${PlotDataDir}/iostat_asvct-${ServerName}-${StartTime}_${EndTime}.dat
##  ${ProgPrefix}/NewQuery fsr "select wsvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and wsvct != 0.0  order by esttime, wsvct" > ${PlotDataDir}/iostat_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
##  ${ProgPrefix}/NewQuery fsr "select actv from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and actv != 0.0  order by esttime, actv" > ${PlotDataDir}/iostat_actv-${ServerName}-${StartTime}_${EndTime}.dat
    
    ##  with timestamps for combined charts

##  ${ProgPrefix}/NewQuery fsr "select esttime, asvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and asvct != 0.0  order by esttime, asvct" > ${PlotDataDir}/iostat_timeasvct-${ServerName}-${StartTime}_${EndTime}.dat
##  ${ProgPrefix}/NewQuery fsr "select esttime, wsvct from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and wsvct != 0.0  order by esttime, wsvct" > ${PlotDataDir}/iostat_timewsvct-${ServerName}-${StartTime}_${EndTime}.dat
##  ${ProgPrefix}/NewQuery fsr "select esttime actv from tmp_gdg_iostat_$$ where serverid = ${ServerID} and ( devtype = 1 or devtype = 2 ) and actv != 0.0  order by esttime, actv" > ${PlotDataDir}/iostat_timeactv-${ServerName}-${StartTime}_${EndTime}.dat


##
##  generate the iocalc data files for the plots
##

echo
echo "Generating iocalc data files..."

${ProgPrefix}/NewQuery fsr "select esttime, rs_sum from tmp_gdg_iocalc_$$ where serverid = ${ServerID} order by esttime" > ${PlotDataDir}/iocalc_Rops-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, ws_sum from tmp_gdg_iocalc_$$ where serverid = ${ServerID} order by esttime" > ${PlotDataDir}/iocalc_Wops-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, (ws_sum + rs_sum) from tmp_gdg_iocalc_$$ where serverid = ${ServerID} order by esttime" > ${PlotDataDir}/iocalc_TOTops-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, krs_sum from tmp_gdg_iocalc_$$ where serverid = ${ServerID} order by esttime" > ${PlotDataDir}/iocalc_readk-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, kws_sum from tmp_gdg_iocalc_$$ where serverid = ${ServerID} order by esttime" > ${PlotDataDir}/iocalc_writek-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg from tmp_gdg_iocalc_$$ where serverid = ${ServerID} order by esttime" > ${PlotDataDir}/iocalc_asvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, asvct_avg_a from tmp_gdg_iocalc_$$ where serverid = ${ServerID} order by esttime" > ${PlotDataDir}/iocalc_weighted-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg from tmp_gdg_iocalc_$$ where serverid = ${ServerID} order by esttime" > ${PlotDataDir}/iocalc_wsvct-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, wsvct_avg_a from tmp_gdg_iocalc_$$ where serverid = ${ServerID} order by esttime" > ${PlotDataDir}/iocalc_wsvct_a-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, avgread_avg from tmp_gdg_iocalc_$$ where serverid = ${ServerID} order by esttime" > ${PlotDataDir}/iocalc_readkperop-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, avgwrit_avg from tmp_gdg_iocalc_$$ where serverid = ${ServerID} order by esttime" > ${PlotDataDir}/iocalc_writkperop-${ServerName}-${StartTime}_${EndTime}.dat
${ProgPrefix}/NewQuery fsr "select esttime, adevices from tmp_gdg_iocalc_$$ where serverid = ${ServerID} order by esttime" > ${PlotDataDir}/iocalc_numdev-${ServerName}-${StartTime}_${EndTime}.dat

##
##  we have data files - start generating graphs and HTML
##

##
##  start the HTML files
##

if [ -d $WebDir ]
then
  /bin/rm -rf ${WebDir}
fi

WebDir=${ArchiveDir}/Web-${ServerName}-${StartTime}-${EndTime}-${DiskGroupName}

if [ ! -d $WebDir ]
then
  mkdir -p $WebDir
else
  cd $WebDir
  /bin/rm -f * 2>/dev/null
  cd $WorkDir
fi





cat > ${WebDir}/index.html <<EOF
<html>
<head>
<title>${ServerName} ${DiskGroupName} Performance Overview from ${StartTime} to ${EndTime}</title>
<link rel=stylesheet href="Perf-Overview.css" type="text/css">
</head>
<body>
<h1 align=center>${ServerName} ${DiskGroupName} from ${StartTime} to ${EndTime}</h1>
EOF

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

Mkplot_iolundata_local
Mkplot_iolunactv_local
Mkplot_iolunwait_local
Mkplot_iolunservXwait_local
Mkplot_iolunperops_local


echo "</ul>" >> ${WebDir}/index.html

echo "<br clear=""all"">" >> ${WebDir}/index.html

echo "<p>Per Disk Path I/O Graphs</p>" >> ${WebDir}/index.html
echo "<ul>" >> ${WebDir}/index.html
Mkplot_byLUN_local
echo "</ul>" >> ${WebDir}/index.html



##
##  check to see if this server has NFS...
##

echo

NFSCount=0
if [ -f ${PlotDataDir}/iocalcnfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat ]
then
  NFSCount=`wc -l ${PlotDataDir}/iocalcnfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }'`
fi

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

VXCount=0
if [ -f ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat ]
then
  VXCount=`wc -l ${PlotDataDir}/vxvol_volrblk-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }'`
fi

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

ACFSCount=0
if [ -f ${PlotDataDir}/iocalcacfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat ]
then
  ACFSCount=`wc -l ${PlotDataDir}/iocalcacfs_Rops-${ServerName}-${StartTime}_${EndTime}.dat | awk '{ print $1 }'`
fi

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

##  echo
##  echo $$
##  echo

