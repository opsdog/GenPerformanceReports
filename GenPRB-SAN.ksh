#!/bin/ksh
##
##  script the read a RPT*.csv and generate data for a problem ticket
##  to the SAN team with the top offenders for service time
##

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

##
##  turn on/off DBLoad profiling
##

DBProfile="Prof"  ##  turn on

##  DBProfile=""      ##  turn off


unset MYSQL
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
  ##  echo "usage:  `basename $0` servername limit [ startepoch endepoch ]"
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
  WHERECLAUSE="serverid = ${ServerID} and esttime between $StartEpoch and $EndEpoch "
  ##  ReportCSV=${WorkDir}/RPT_TopLUNs_${ServerName}_${Limit}_${StartEpoch}-${EndEpoch}.csv
  ##  ReportTXT=${WorkDir}/RPT_TopLUNs_${ServerName}_${Limit}_${StartEpoch}-${EndEpoch}.txt
  ##  MyReportTXT=${WorkDir}/RPT_PRB_${ServerName}_${Limit}_${StartEpoch}-${EndEpoch}.txt
  ReportCSV=${WorkDir}/RPT_TopLUNs_${ServerName}_${Limit}_`FromEpoch ${StartEpoch} -s`-`FromEpoch ${EndEpoch} -s`.csv
  ReportTXT=${WorkDir}/RPT_TopLUNs_${ServerName}_${Limit}_`FromEpoch ${StartEpoch} -s`-`FromEpoch ${EndEpoch} -s`.txt
  MyReportTXT=${WorkDir}/RPT_PRB_${ServerName}_${Limit}_`FromEpoch ${StartEpoch} -s`-`FromEpoch ${EndEpoch} -s`.txt
else
  WHERECLAUSE="serverid = ${ServerID}"
  ReportCSV=${WorkDir}/RPT_TopLUNs_${ServerName}_${Limit}_ALL.csv
  ReportTXT=${WorkDir}/RPT_TopLUNs_${ServerName}_${Limit}_ALL.txt
  MyReportTXT=${WorkDir}/RPT_PRB_${ServerName}_${Limit}_ALL.txt
fi

rm -f $ReportCSV $ReportTXT
touch $ReportCSV $ReportTXT

##
##  generate the report
##

echo
echo "Generate the report..."

ReportCMD="./TopLUNs.ksh $@"

${ReportCMD}

##
##  process the CSV report
##

rm -f $MyReportTXT
touch $MyReportTXT

if [ ! -z "$3" ]
then
  echo "Server ${ServerName} for period from `FromEpoch ${StartEpoch}` to `FromEpoch ${EndEpoch}`" >> ${MyReportTXT}
else
  echo "Server ${ServerName} for all data collected" >> ${MyReportTXT}
fi
echo >> ${MyReportTXT}

echo
echo "Processing ${ReportCSV}..."

echo "High service times:" >> $MyReportTXT

cat ${ReportCSV} | awk -F \, ' $2 == "asvct" { print }' | tr \, \  | sort -rnk 8 > tmp_gp_asvct

exec 4<tmp_gp_asvct
while read -u4 server metric limit aserial device sanid count values
##  while read -u4 server metric limit device aserial sanid count values
do
  ##  echo "  $server ($count) $values"
  ##  echo "    $server $metric $limit $device $sanid $count $values"
  ValueCurrent=1
  MetricCount=0
  EpochCount=0

  rm -f tmp_gp_file1 tmp_gp_file2

  while [[ $MetricCount -lt $count ]]
  do
    MetricValue=`echo $values | awk ' { print $ValueCurrent }' ValueCurrent=$ValueCurrent`
    ##  echo "    Value:  $ValueCurrent --> $MetricValue"
    echo "$server $aserial $device $sanid $MetricValue" >> tmp_gp_file1

    ValueCurrent=`echo "${ValueCurrent} + 1" | bc`
    MetricCount=`echo "${MetricCount} + 1" | bc`
  done

  while [[ $EpochCount -lt $count ]]
  do
    MetricValue=`echo $values | awk ' { print $ValueCurrent }' ValueCurrent=$ValueCurrent`
    ##  echo "    Epoch:  $ValueCurrent --> $MetricValue"
    echo "$MetricValue" >> tmp_gp_file2

    ValueCurrent=`echo "${ValueCurrent} + 1" | bc`
    EpochCount=`echo "${EpochCount} + 1" | bc`
  done

  exec 5<tmp_gp_file1
  exec 6<tmp_gp_file2
  while read -u5 SERVER DEVICE ASERIAL SANID VALUE
  do
    read -u6 EPOCH
    ##  echo "should be an EPOCH time --> $EPOCH"
    HumanTime=`FromEpoch $EPOCH`
    ##  echo "$SERVER $DEVICE $SANID had $VALUE service time on $HumanTime"
    echo "  $SERVER device $DEVICE on array $ASERIAL with LDEV $SANID had $VALUE service time on $HumanTime" >> $MyReportTXT
  done
  exec 5<&-
  exec 6<&-


done
exec 4<&-

##
##

echo >> $MyReportTXT
echo "High wait times:" >> $MyReportTXT

cat ${ReportCSV} | awk -F \, ' $2 == "wsvct" { print }' | tr \, \  | sort -rnk 8 > tmp_gp_asvct

exec 4<tmp_gp_asvct
while read -u4 server metric limit aserial device sanid count values
do
  ## echo "  $server ($count) $values"
  ## echo "    $server $metric $limit $device $sanid $count $values"
  ValueCurrent=1
  MetricCount=0
  EpochCount=0

  rm -f tmp_gp_file1 tmp_gp_file2

  while [[ $MetricCount -lt $count ]]
  do
    MetricValue=`echo $values | awk ' { print $ValueCurrent }' ValueCurrent=$ValueCurrent`
    ## echo "    Value:  $ValueCurrent --> $MetricValue"
    echo "$server $aserial $device $sanid $MetricValue" >> tmp_gp_file1

    ValueCurrent=`echo "${ValueCurrent} + 1" | bc`
    MetricCount=`echo "${MetricCount} + 1" | bc`
  done

  while [[ $EpochCount -lt $count ]]
  do
    MetricValue=`echo $values | awk ' { print $ValueCurrent }' ValueCurrent=$ValueCurrent`
    ## echo "    Epoch:  $ValueCurrent --> $MetricValue"
    echo "$MetricValue" >> tmp_gp_file2

    ValueCurrent=`echo "${ValueCurrent} + 1" | bc`
    EpochCount=`echo "${EpochCount} + 1" | bc`
  done

  exec 5<tmp_gp_file1
  exec 6<tmp_gp_file2
  while read -u5 SERVER DEVICE ASERIAL SANID VALUE
  do
    read -u6 EPOCH
    HumanTime=`FromEpoch $EPOCH`
    ##  echo "$SERVER $DEVICE $SANID had $VALUE service time on $HumanTime"
    echo "  $SERVER device $DEVICE on array $ASERIAL with LDEV $SANID had $VALUE wait time on $HumanTime" >> $MyReportTXT
  done
  exec 5<&-
  exec 6<&-


done
exec 4<&-
