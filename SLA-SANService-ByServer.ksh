#!/bin/ksh
##
##  for the specified server, find all full day ranges and report on
##  SAN service time SLA.
##
##  assumes Tier 2 SLA as all Finance SAN is Tier 2
##  assumes measurement is not by array - "SAN is SAN"
##

. ./Func-DBStats.ksh

######################################################################
######################################################################
##
##  main
##
######################################################################
######################################################################

##  arg checks

TESTMODE=0
if [ ! -z "$2" ]
then
  if [ "$2" != "-t" ]
  then
    echo
    echo "usage:  `basename $0` servername [ -t ]"
    echo
    exit
  else
    TESTMODE=1
  fi  ##  if arg2 is not -t
fi  ##  if arg2 is not null

if [ -z "$1" ]
then
  echo
  echo "usage:  `basename $0` servername [ -t ]"
  echo
  exit
fi  ##  if arg1 is null

ServerName=$1

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

ServerID=`${ProgPrefix}/NewQuery fsr "select id from server where name = '${ServerName}'"`

if [ -z "$ServerID" ]
then
  echo
  echo "Invalid server name specified - bailing..."
  exit
fi

ServerOS=`${ProgPrefix}/NewQuery fsr "select OS from server where id = $ServerID"`

##  StartEpoch=`${ProgPrefix}/NewQuery fsr "select min(esttime) from vmstat where serverid = ${ServerID}"`
##  EndEpoch=`${ProgPrefix}/NewQuery fsr "select max(esttime) from vmstat where serverid = ${ServerID}"`

case $ServerOS in

  SunOS )
	  StartEpoch=`${ProgPrefix}/NewQuery fsr "select min(esttime) from iostat58 where serverid = ${ServerID}"`
	  EndEpoch=`${ProgPrefix}/NewQuery fsr "select max(esttime) from iostat58 where serverid = ${ServerID}"`
	  ;;

  Linux ) 
	  StartEpoch=`${ProgPrefix}/NewQuery fsr "select min(esttime) from linux_iostat58 where serverid = ${ServerID}"`
	  EndEpoch=`${ProgPrefix}/NewQuery fsr "select max(esttime) from linux_iostat58 where serverid = ${ServerID}"`
	  ;;

  * )     echo "Unsupported OS $ServerOS - bailing..."
	  exit 1
	  ;;

esac

if [ -z "$StartEpoch" -o "$StartEpoch" = "$EndEpoch" ]
then
  echo
  echo "Data problem - does server have data?  Bailing..."
  echo 
  exit
fi  ##  if bad epoch times

StartTime=`${ProgPrefix}/FromEpoch $StartEpoch -s`
EndTime=`${ProgPrefix}/FromEpoch $EndEpoch -s`

##  print debug stuff

##  echo "Server    : $ServerName"
##  echo "ServerID  : $ServerID"
##  echo "ServerOS  : $ServerOS"
##  echo "StartEpoch: $StartEpoch"
##  echo "EndEpoch  : $EndEpoch"
##  echo "StartTime : $StartTime"
##  echo "EndTime   : $EndTime"

##  WorkDir=`pwd`
ArchiveDir=`pwd`/Graph-SLA-SANserv
PlotDataDir=${ArchiveDir}/GPlotData
WebDir=${ArchiveDir}/SLA-${ServerName}-${StartTime}-${EndTime}
ReportFile=${WebDir}/RPT-SANSLA-${ServerName}-${StartTime}-${EndTime}.txt
WorkDir=${ArchiveDir}/${ServerName}_$$

##
##  start actually doing stuff
##

echo
echo "Clearing old runs..."

if [ -d $PlotDataDir ]
then
  rm -f ${PlotDataDir}/*${ServerName}-*.dat 2>/dev/null
  rm -f ${PlotDataDir}/*-ALL-${ServerName}.dat 2>/dev/null
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

rm -f ${ArchiveDir}/${ServerName}_*.png 2>/dev/null
rm -f ${ArchiveDir}/${ServerName}_*.gplot 2>/dev/null
rm -f $ReportFile 2>/dev/null

##
##  start the HTML files
##

cp Perf-SLA-SANserv.css ${WebDir}/

cat > ${WebDir}/index.html <<EOF
<html>
<head>
<title>${ServerName} SAN Service Time SLA Report from ${StartTime} to ${EndTime}</title>
<link rel=stylesheet href="Perf-SLA-SANserv.css" type="text/css">
</head>
<body>
<!-- <h1 align=center>${ServerName} SAN Service SLA Report from ${StartTime} to ${EndTime}</h1> -->
<h1 align=center>${ServerName} SAN Service SLA Report</h1>
<br clear="all"><br>
<p>This report only reflects days where 23 1/2 hours or more of data is available.</p>
<p><b>The DSS SAN SLA is based on 1 minute data samples</b>.  The first set of data for a day is the 1 minute sample data.</p>
<p>I also collect 15 second sample data.  I include this only for statistical comparison.</p>
<p>The official SLA is based on the 1 minute data.</p>
<br clear="all"><br>
EOF

##
##  make the text report header
##

printf "%s SAN Service Time SLA Report from %s to %s\n\n" $ServerName $StartTime $EndTime > $ReportFile
printf "This report only reflects days where 23 1/2 hours or more of data is available.\n\n" >> $ReportFile
printf "Sampling interval is 1 minute\n\n" >> $ReportFile


##
##  find the full date ranges that include all the data
##

FullRangeBeginTime="`echo $StartTime | cut -c1-8`0000"
FullRangeBeginEpoch=`${ProgPrefix}/ToEpoch $FullRangeBeginTime`
FullRangeBeginTimeShort=`${ProgPrefix}/FromEpoch $FullRangeBeginEpoch | awk '{ print $2 }'`

DougeeEpoch=`echo $EndEpoch + 86400 | bc`
DougeeTime=`${ProgPrefix}/FromEpoch $DougeeEpoch -s`

FullRangeEndTime="`echo $DougeeTime | cut -c1-8`0000"
FullRangeEndEpoch=`${ProgPrefix}/ToEpoch $FullRangeEndTime`
FullRangeEndTimeShort=`${ProgPrefix}/FromEpoch $FullRangeEndEpoch | awk '{ print $2 }'`

##  echo "FullRangeBeginTime: $FullRangeBeginTime"
##  echo "FullRangeEndTime:   $FullRangeEndTime"
##  echo "FullRangeBeginTime: $FullRangeBeginTime"
##  echo "FullRangeEndEpoch:  $FullRangeEndEpoch"

##
##  calculate the daily ranges
##

TempBeginEpoch=`${ProgPrefix}/ToEpoch $FullRangeBeginTime`
TempEndEpoch=`echo $TempBeginEpoch + 86400 | bc`

##  echo "TempBeginEpoch: $TempBeginEpoch"
##  echo "TempEndEpoch:   $TempEndEpoch"

rm -f tmp_SLAsserv_ranges 2>/dev/null

echo "$TempBeginEpoch $TempEndEpoch" > tmp_SLAsserv_ranges
NumRanges=1

TempBeginEpoch=$TempEndEpoch
while [ $TempBeginEpoch -lt $FullRangeEndEpoch ]
do
  TempEndEpoch=`echo $TempBeginEpoch + 86400 | bc`
  echo "$TempBeginEpoch $TempEndEpoch" >> tmp_SLAsserv_ranges

  TempBeginEpoch=$TempEndEpoch
  NumRanges=`echo "$NumRanges + 1" | bc`
done  ##  end of loop on epoch time

##
##  range debug block
##

##  echo
##  echo "NumRanges: $NumRanges"
##  exec 4<tmp_SLAsserv_ranges
##  TMPRangeNum=1
##  while read -u4 A B
##  do
##    TMPBegin=`${ProgPrefix}/FromEpoch $A`
##    TMPEnd=`${ProgPrefix}/FromEpoch $B`
##    printf "  %2s : %s --> %s\n" $TMPRangeNum "$TMPBegin" "$TMPEnd"
##    TMPRangeNum=`echo $TMPRangeNum + 1 | bc`  
##  done
##  exec 4<&-
##  echo

##
##  print the date range
##

printf "<h3 align=\"center\">Overall data range is from %s to %s</h3>\n" $FullRangeBeginTimeShort $FullRangeEndTimeShort >> ${WebDir}/index.html

printf "\nOverall data range is from %s to %s\n\n\n" $FullRangeBeginTimeShort $FullRangeEndTimeShort >> $ReportFile

echo "<br clear=\"all\"><br>" >> ${WebDir}/index.html

echo
echo "Calculating Service Time SLA percentage for $NumRanges ranges..."

rm -f ${PlotDataDir}/overview-${ServerName}-${FullRangeBeginEpoch}_${FullRangeEndEpoch}.dat 2>/dev/null
touch ${PlotDataDir}/overview-${ServerName}-${FullRangeBeginEpoch}_${FullRangeEndEpoch}.dat 2>/dev/null

exec 4<tmp_SLAsserv_ranges
while read -u4 MakeDataEpochBegin MakeDataEpochEnd
do
  printf "  %s (%s) %s %s" $ServerName $ServerID $MakeDataEpochBegin $MakeDataEpochEnd

  StartEpoch=$MakeDataEpochBegin
  EndEpoch=$MakeDataEpochEnd
  StartTime=`${ProgPrefix}/FromEpoch $StartEpoch -s`
  EndTime=`${ProgPrefix}/FromEpoch $EndEpoch -s `
  StartTimeLong=`${ProgPrefix}/FromEpoch $StartEpoch`
  EndTimeLong=`${ProgPrefix}/FromEpoch $EndEpoch`

  Stats_Calc_SAN_SLA_15

  StartEpoch=`echo "$MakeDataEpochBegin - 30" | bc`
  EndEpoch=`echo "$MakeDataEpochEnd + 30" | bc `
  StartTime=`${ProgPrefix}/FromEpoch $StartEpoch -s`
  EndTime=`${ProgPrefix}/FromEpoch $EndEpoch -s `
  StartTimeLong=`${ProgPrefix}/FromEpoch $StartEpoch`
  EndTimeLong=`${ProgPrefix}/FromEpoch $EndEpoch`

  Stats_Calc_SAN_SLA

  ##  printf " %s (%s) - %s (%s)\n" $CalcSANSLA_PctDay $CalcSANSLA15_PctDay $CalcSANSLA_PctUnder25 $CalcSANSLA15_PctUnder25
  printf " %5.2f (%5.2f) - %5.2f (%5.2f)\n" $CalcSANSLA_PctDay $CalcSANSLA15_PctDay $CalcSANSLA_PctUnder25 $CalcSANSLA15_PctUnder25

  ##
  ##  update HTML if there is a full day of data
  ##

  if [ $CalcSANSLA_PctDay -gt 23.5 ]
  then

    ##  printf "<p>24 hours starting at midnight %s:</p>\n" "`${ProgPrefix}/FromEpoch $StartEpoch | awk '{ print $2 }'`" >> ${WebDir}/index.html
    printf "<p>24 hours starting at midnight %s:</p>\n" "`${ProgPrefix}/FromEpoch $MakeDataEpochBegin | awk '{ print $2 }'`" >> ${WebDir}/index.html
    printf "24 hours starting at midnight %s:\n" "`${ProgPrefix}/FromEpoch $MakeDataEpochBegin | awk '{ print $2 }'`" >> $ReportFile
    printf "<blockquote>\n<p>" >> ${WebDir}/index.html
    printf "There were %s SAN requests with %s serviced under 25ms and %s serviced slower.\n" $CalcSANSLA_TotalNonZero $CalcSANSLA_TotalUnder25 $CalcSANSLA_TotalOver25 >> ${WebDir}/index.html
    printf "  <br>Percentage under 25ms was <b>%s</b> at 1 minute sample for <b>%s</b> measured hours.\n" $CalcSANSLA_PctUnder25 $CalcSANSLA_PctDay >> ${WebDir}/index.html

    printf "    There were %s SAN requests with %s serviced under 25ms and %s serviced slower.\n" $CalcSANSLA_TotalNonZero $CalcSANSLA_TotalUnder25 $CalcSANSLA_TotalOver25 >> $ReportFile
    printf "    Percentage under 25ms was %s at 1 minute sample for %s measured hours.\n\n" $CalcSANSLA_PctUnder25 $CalcSANSLA_PctDay >> $ReportFile


    printf "  <br><br>Percentage under 25ms was <b>%s</b> at 15 second sample for %s requests.\n" $CalcSANSLA15_PctUnder25 $CalcSANSLA15_TotalNonZero >> ${WebDir}/index.html
    printf "</p>\n</blockquote>\n" >> ${WebDir}/index.html

    ##
    ##  save data to be graphed
    ##

    ##  printf "%s %s %s %s %s %s\n" $StartTime $CalcSANSLA_TotalNonZero $CalcSANSLA_TotalUnder25 $CalcSANSLA_TotalOver25 $CalcSANSLA_PctUnder25 $CalcSANSLA15_PctUnder25 >> ${PlotDataDir}/overview-${ServerName}-${FullRangeBeginEpoch}_${FullRangeEndEpoch}.dat
    printf "%s %s %s %s %s %s\n" `${ProgPrefix}/FromEpoch $MakeDataEpochBegin -s` $CalcSANSLA_TotalNonZero $CalcSANSLA_TotalUnder25 $CalcSANSLA_TotalOver25 $CalcSANSLA_PctUnder25 $CalcSANSLA15_PctUnder25 >> ${PlotDataDir}/overview-${ServerName}-${FullRangeBeginEpoch}_${FullRangeEndEpoch}.dat

  fi  ##  if measured time is more than 23.5 hours


done
exec 4<&-

##
##  create the two summary plots - Counts and Percents
##

GFileBase="${ServerName}_${StartTime}-${EndTime}_SANSLAsserv"
PlotScript="${GFileBase}.gplot"
rm -f ${WorkDir}/$PlotScript 2>/dev/null
touch ${WorkDir}/$PlotScript 2>/dev/null

echo "set term png size 2048,1024" >> ${WorkDir}/$PlotScript
echo "set output '${GFileBase}-Requests.png'" >> ${WorkDir}/$PlotScript
echo "set autoscale" >> ${WorkDir}/$PlotScript
echo "set xtic auto" >> ${WorkDir}/$PlotScript
echo "set ytic auto" >> ${WorkDir}/$PlotScript
echo "unset xtic" >> ${WorkDir}/$PlotScript
echo >> ${WorkDir}/$PlotScript
echo "set style line 1 lc rgb 'red' lw 2 pt 1" >> ${WorkDir}/$PlotScript
echo "set style line 2 lc rgb 'blue' lw 2 pt 1" >> ${WorkDir}/$PlotScript
echo "set style line 3 lc rgb '#202080' lw 2 pt 1" >> ${WorkDir}/$PlotScript
echo >> ${WorkDir}/$PlotScript
echo "set title '${ServerName} - $FullRangeBeginTimeShort to $FullRangeEndTimeShort - SAN Requests and Service Times Counts'" >> ${WorkDir}/$PlotScript
echo >> ${WorkDir}/$PlotScript
echo "plot '${PlotDataDir}/overview-${ServerName}-${FullRangeBeginEpoch}_${FullRangeEndEpoch}.dat' using 2 title 'SAN Requests' with linespoint linestyle 2, \\" >> ${WorkDir}/$PlotScript
echo "    '${PlotDataDir}/overview-${ServerName}-${FullRangeBeginEpoch}_${FullRangeEndEpoch}.dat' using 3 title 'Under 25' with linespoint linestyle 3, \\" >> ${WorkDir}/$PlotScript
echo "    '${PlotDataDir}/overview-${ServerName}-${FullRangeBeginEpoch}_${FullRangeEndEpoch}.dat' using 4 title 'Over 25' with linespoint linestyle 1" >> ${WorkDir}/$PlotScript
echo >> ${WorkDir}/$PlotScript
echo >> ${WorkDir}/$PlotScript
echo "reset" >> ${WorkDir}/$PlotScript
echo "set term png size 2048,1024" >> ${WorkDir}/$PlotScript
echo "set output '${GFileBase}-Percent.png'" >> ${WorkDir}/$PlotScript
echo "set autoscale" >> ${WorkDir}/$PlotScript
echo "set xtic auto" >> ${WorkDir}/$PlotScript
echo "set ytic auto" >> ${WorkDir}/$PlotScript
echo "unset xtic" >> ${WorkDir}/$PlotScript
echo >> ${WorkDir}/$PlotScript
echo "set style line 1 lc rgb '#a02020' lw 2 pt 1" >> ${WorkDir}/$PlotScript
echo "set style line 2 lc rgb '#d02020' lw 2 pt 1" >> ${WorkDir}/$PlotScript
echo >> ${WorkDir}/$PlotScript
echo "set yrange [0:105]" >> ${WorkDir}/$PlotScript
echo >> ${WorkDir}/$PlotScript
echo "set title '${ServerName} - $FullRangeBeginTimeShort to $FullRangeEndTimeShort - SAN SLA Percentage'" >> ${WorkDir}/$PlotScript
echo >> ${WorkDir}/$PlotScript
echo "plot '${PlotDataDir}/overview-${ServerName}-${FullRangeBeginEpoch}_${FullRangeEndEpoch}.dat' using 5 title 'SLA Percent' with linespoint linestyle 1, \\" >> ${WorkDir}/$PlotScript
echo "     99 title '99% Target' with lines linestyle 2" >> ${WorkDir}/$PlotScript

##
##  create the images, finish the web page
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
(
  cd $WorkDir
  for PNGFile in ${ServerName}*.png
  do
    mv ${PNGFile} ${WebDir}/
  done
)

##
##  create the data table for excel weenies
##

echo
echo "Creating data tables..."

##
##  SLA data table
##

printf "\n%s SLA Summary:\n\n" $ServerName >> $ReportFile


echo "<br clear=\"all\">" >> ${WebDir}/index.html
echo "<hr align=\"center\">" >> ${WebDir}/index.html
echo "<br><br>" >> ${WebDir}/index.html
echo "<table align=\"center\" border=2>" >> ${WebDir}/index.html
##  echo "<tr><th>Date</th><th>Total Requests</th><th>Requests Under 25</th><th>Requests Over 25</th><th>SLA Met Percent<br>1 minute</th><th>SLA Met Percent<br>15 seconds</th></tr>" >> ${WebDir}/index.html
echo "<tr><th>Start Date</th><th>Total Requests</th><th>Requests < 25</th><th>Requests > 25</th><th>SLA&nbsp;&nbsp;Met&nbsp;&nbsp;&#37;<br>1 minute</th><th>SLA&nbsp;&nbsp;Met&nbsp;&nbsp;&#37;<br>15 seconds</th></tr>" >> ${WebDir}/index.html
exec 4<${PlotDataDir}/overview-${ServerName}-${FullRangeBeginEpoch}_${FullRangeEndEpoch}.dat
while read -u4 DTDate DTTotal DTUnder25 DTOver25 DTPercent DTPercent15
do
  echo "<tr><td align=\"right\">${DTDate}</td><td align=\"right\">${DTTotal}</td><td align=\"right\">${DTUnder25}</td><td align=\"right\">${DTOver25}</td><td align=\"right\">${DTPercent}</td><td align=\"right\">${DTPercent15}</td></tr>" >> ${WebDir}/index.html
  printf "    %20s %10s\%\n" $DTDate $DTPercent >> $ReportFile
done  ##  while reading data file
exec 4<&-
echo "</table>" >> ${WebDir}/index.html
echo "<br><br>" >> ${WebDir}/index.html
echo "<hr class=\"small\" align=\"center\">" >> ${WebDir}/index.html
echo "<br clear=\"all\"><br>" >> ${WebDir}/index.html

printf "\n" >> $ReportFile

##
##  server HBA to FED table
##

printf "\n%s Array and HBA information:\n\n" $ServerName >> $ReportFile

echo "<table align=\"center\" border=2>" >> ${WebDir}/index.html
echo "<tr><th>Server</th><th>Array(s)</th><th>HBA to Port Map</th></tr>" >> ${WebDir}/index.html

echo "<tr>" >> ${WebDir}/index.html
echo "<td align=\"left\">${ServerName}</td>" >> ${WebDir}/index.html
##  Array(s)
echo "<td align=\"center\">"  >> ${WebDir}/index.html
for ArrayNum in `${ProgPrefix}/NewQuery fsr "select distinct arraynum from disk where server = ${ServerID}"`
do
  echo "${ArrayNum}<br>" >> ${WebDir}/index.html
  printf "    Array: %s\n" $ArrayNum >> $ReportFile
done
echo "</td>" >> ${WebDir}/index.html
##  HBAs
printf "\n" >> $ReportFile
echo "<td align=\"right\">" >> ${WebDir}/index.html
for HBA in `${ProgPrefix}/CSVQuery fsr "select distinct hostwwn, portwwn from portmap where server = ${ServerID} order by hostwwn"`
do
  HBAnbsp=`echo $HBA | sed s/\,/'\&nbsp;'/ | sed s/\,$//`
  echo $HBA | sed s/\,/\ / | sed s/\,$// | read HBAprint FEDprint
  ##  HBAnbsp=`echo $HBA | sed s/\,/'-->'/ | sed s/\,$//`
  echo "${HBAnbsp}<br>" >> ${WebDir}/index.html
  printf "    HBA to FED: %s %s\n" $HBAprint $FEDprint >> $ReportFile
done
echo "</td>" >> ${WebDir}/index.html
echo "</tr>" >> ${WebDir}/index.html

echo "</table>" >> ${WebDir}/index.html

echo "<br><br>" >> ${WebDir}/index.html
echo "<hr align=\"center\">" >> ${WebDir}/index.html
echo "<br clear=\"all\">" >> ${WebDir}/index.html

printf "\nPlease note that sometimes array serial numbers will be derived from internal disks and will be bogus.  Apologies for the inconvenience.\n" >> $ReportFile

##
##  close the index.html
##

ReportLinkFile=`basename $ReportFile`

cat >> ${WebDir}/index.html <<EOF
<br clear="all">
<p>Graphs (1 minute sample data):</p>
<ul>
<li><a href="${GFileBase}-Requests.png">SAN Requests and Service Time Counts</a></p>
<li><a href="${GFileBase}-Percent.png">SAN SLA Percentage</a></p>
</ul>
<br clear="all">
<p>Link to text report suitable for including in a Problem Ticket to DSS-SAN is <a href="${ReportLinkFile}">HERE</a>.</p>
</body>
</html>
EOF

##
##  clean up and go home
##

rm -rf $WorkDir
