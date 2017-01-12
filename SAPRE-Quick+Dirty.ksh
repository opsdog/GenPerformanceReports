#!/bin/ksh
##
##  quick and dirty script to generate the CPU loading of the 3 SAPRE
##  UAT servers
##

. ./MkplotFunctions.ksh


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

##  local variables

TimeRange=0

if [ ! -z "$1" ]
then
  TimeRange=1
  StartEpoch=`ToEpoch $1`
  EndEpoch=`ToEpoch $2`
  echo
  echo "Time range specified from $1 (${StartEpoch}) to $2 (${EndEpoch})"
fi

##
##  let's roll
##

echo
echo "Gererating data files..."

for ServerID in 481 482 483 484 485 486
do

  echo
  echo "  CPU Set 1..."
  for cpu in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15
  do
    if [ $TimeRange = 0 ]
    then
      ${ProgPrefix}/NewQuery fsr "select esttime, usr, sys, iowait from linux_mpstat where serverid = ${ServerID} and cpu = ${cpu} order by esttime" > _tmp_dougee_${ServerID}_${cpu}.csv
    else
      ${ProgPrefix}/NewQuery fsr "select esttime, usr, sys, iowait from linux_mpstat where serverid = ${ServerID} and cpu = ${cpu} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > _tmp_dougee_${ServerID}_${cpu}.csv
    fi
  done  ##  for cpu set

  echo "  CPU Set 2..."
  for cpu in 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
  do
    if [ $TimeRange = 0 ]
    then
      ${ProgPrefix}/NewQuery fsr "select esttime, usr, sys, iowait from linux_mpstat where serverid = ${ServerID} and cpu = ${cpu} order by esttime" > _tmp_dougee_${ServerID}_${cpu}.csv
    else
      ${ProgPrefix}/NewQuery fsr "select esttime, usr, sys, iowait from linux_mpstat where serverid = ${ServerID} and cpu = ${cpu} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > _tmp_dougee_${ServerID}_${cpu}.csv
    fi
  done  ##  for cpu set

  echo "  CPU Set 3..."
  for cpu in 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
  do
    if [ $TimeRange = 0 ]
    then
      ${ProgPrefix}/NewQuery fsr "select esttime, usr, sys, iowait from linux_mpstat where serverid = ${ServerID} and cpu = ${cpu} order by esttime" > _tmp_dougee_${ServerID}_${cpu}.csv
    else
      ${ProgPrefix}/NewQuery fsr "select esttime, usr, sys, iowait from linux_mpstat where serverid = ${ServerID} and cpu = ${cpu} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > _tmp_dougee_${ServerID}_${cpu}.csv
    fi
  done  ##  for cpu set

  echo "  CPU Set 4..."
  for cpu in 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
  do
    if [ $TimeRange = 0 ]
    then
      ${ProgPrefix}/NewQuery fsr "select esttime, usr, sys, iowait from linux_mpstat where serverid = ${ServerID} and cpu = ${cpu} order by esttime" > _tmp_dougee_${ServerID}_${cpu}.csv
    else
      ${ProgPrefix}/NewQuery fsr "select esttime, usr, sys, iowait from linux_mpstat where serverid = ${ServerID} and cpu = ${cpu} and esttime between ${StartEpoch} and ${EndEpoch} order by esttime" > _tmp_dougee_${ServerID}_${cpu}.csv
    fi
  done  ##  for cpu set

  echo "  CPU count..."

  rm -f _tmp_dougee_num_${ServerID}.csv
  touch _tmp_dougee_num_${ServerID}.csv
  ServerName=`${ProgPrefix}/NewQuery fsr "select name from server where id = ${ServerID}"`

  ##  this is not quick  :-(
  ##  for esttime in `${ProgPrefix}/NewQuery fsr "select distinct esttime from linux_mpstat where serverid = ${ServerID} order by esttime"`
  ##  do
    ##  ${ProgPrefix}/NewQuery fsr "select esttime, count(cpu) from linux_mpstat where serverid = ${ServerID} and esttime = ${esttime} and ( usr != 0.0 or sys != 0.0 or iowait != 0.0 )" >> _tmp_dougee_num_${ServerID}.csv
  ##  done  ##  for each esttime

  ##  or slightly less slow...

  ##  ./Lin-NumCPUbyServer $ServerName >> _tmp_dougee_num_${ServerID}.csv

done ##  for each serverid


##############################################################################
##############################################################################
##
##  now we have datafiles - let's generate the plot scripts
##
##############################################################################
##############################################################################

echo
echo "Generating plot scripts..."

##################################################
##
##  cupra01a0006 - 481 - 64 CPUs
##
##################################################

##  USR time

echo
echo "  cupra01a0006 usr all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cupra01a0006_usr.gplot
echo "set output 'cupra01a0006_usrALL.png'" >> _tmp_cupra01a0006_usr.gplot
echo "set autoscale" >> _tmp_cupra01a0006_usr.gplot
echo "set xtic auto" >> _tmp_cupra01a0006_usr.gplot
echo "set ytic auto" >> _tmp_cupra01a0006_usr.gplot
echo "unset xtic"  >> _tmp_cupra01a0006_usr.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cupra01a0006_usr.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cupra01a0006_usr.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cupra01a0006_usr.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cupra01a0006_usr.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cupra01a0006_usr.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cupra01a0006_usr.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cupra01a0006_usr.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cupra01a0006_usr.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cupra01a0006_usr.gplot
echo "set yrange [0:100]" >> _tmp_cupra01a0006_usr.gplot

##  set the title

cat _tmp_dougee_481* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_481* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cupra01a0006 - $StartHuman to $EndHuman - User CPU for all CPUs'" >> _tmp_cupra01a0006_usr.gplot


cat _tmp_dougee_481* | awk '{ print $2 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_481* | awk '{ print $2 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cupra01a0006_usr.gplot
for datafile in _tmp_dougee_481*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:2 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cupra01a0006_usr.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cupra01a0006_usr.gplot


##  SYS time

echo
echo "  cupra01a0006 sys all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cupra01a0006_sys.gplot
echo "set output 'cupra01a0006_sysALL.png'" >> _tmp_cupra01a0006_sys.gplot
echo "set autoscale" >> _tmp_cupra01a0006_sys.gplot
echo "set xtic auto" >> _tmp_cupra01a0006_sys.gplot
echo "set ytic auto" >> _tmp_cupra01a0006_sys.gplot
echo "unset xtic"  >> _tmp_cupra01a0006_sys.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cupra01a0006_sys.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cupra01a0006_sys.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cupra01a0006_sys.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cupra01a0006_sys.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cupra01a0006_sys.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cupra01a0006_sys.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cupra01a0006_sys.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cupra01a0006_sys.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cupra01a0006_sys.gplot
echo "set yrange [0:100]" >> _tmp_cupra01a0006_sys.gplot

##  set the title

cat _tmp_dougee_481* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_481* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cupra01a0006 - $StartHuman to $EndHuman - System CPU for all CPUs'" >> _tmp_cupra01a0006_sys.gplot

cat _tmp_dougee_481* | awk '{ print $3 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_481* | awk '{ print $3 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cupra01a0006_sys.gplot
for datafile in _tmp_dougee_481*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:3 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cupra01a0006_sys.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cupra01a0006_sys.gplot

##  IOWAIT time

echo
echo "  cupra01a0006 iowait all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cupra01a0006_iow.gplot
echo "set output 'cupra01a0006_iowALL.png'" >> _tmp_cupra01a0006_iow.gplot
echo "set autoscale" >> _tmp_cupra01a0006_iow.gplot
echo "set xtic auto" >> _tmp_cupra01a0006_iow.gplot
echo "set ytic auto" >> _tmp_cupra01a0006_iow.gplot
echo "unset xtic"  >> _tmp_cupra01a0006_iow.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cupra01a0006_iow.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cupra01a0006_iow.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cupra01a0006_iow.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cupra01a0006_iow.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cupra01a0006_iow.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cupra01a0006_iow.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cupra01a0006_iow.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cupra01a0006_iow.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cupra01a0006_iow.gplot
echo "set yrange [0:100]" >> _tmp_cupra01a0006_iow.gplot

##  set the title

cat _tmp_dougee_481* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_481* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cupra01a0006 - $StartHuman to $EndHuman - IO wait CPU for all CPUs'" >> _tmp_cupra01a0006_iow.gplot

cat _tmp_dougee_481* | awk '{ print $4 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_481* | awk '{ print $4 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cupra01a0006_iow.gplot
for datafile in _tmp_dougee_481*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:4 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cupra01a0006_iow.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cupra01a0006_iow.gplot


##################################################
##
##  cupra02a0006 - 482 - 64 CPUs
##
##################################################

##  USR time

echo
echo "  cupra02a0006 usr all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cupra02a0006_usr.gplot
echo "set output 'cupra02a0006_usrALL.png'" >> _tmp_cupra02a0006_usr.gplot
echo "set autoscale" >> _tmp_cupra02a0006_usr.gplot
echo "set xtic auto" >> _tmp_cupra02a0006_usr.gplot
echo "set ytic auto" >> _tmp_cupra02a0006_usr.gplot
echo "unset xtic"  >> _tmp_cupra02a0006_usr.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cupra02a0006_usr.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cupra02a0006_usr.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cupra02a0006_usr.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cupra02a0006_usr.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cupra02a0006_usr.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cupra02a0006_usr.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cupra02a0006_usr.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cupra02a0006_usr.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cupra02a0006_usr.gplot
echo "set yrange [0:100]" >> _tmp_cupra02a0006_usr.gplot

##  set the title

cat _tmp_dougee_482* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_482* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cupra02a0006 - $StartHuman to $EndHuman - User CPU for all CPUs'" >> _tmp_cupra02a0006_usr.gplot

cat _tmp_dougee_482* | awk '{ print $2 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_482* | awk '{ print $2 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cupra02a0006_usr.gplot
for datafile in _tmp_dougee_482*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:2 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cupra02a0006_usr.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cupra02a0006_usr.gplot


##  SYS time

echo
echo "  cupra02a0006 sys all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cupra02a0006_sys.gplot
echo "set output 'cupra02a0006_sysALL.png'" >> _tmp_cupra02a0006_sys.gplot
echo "set autoscale" >> _tmp_cupra02a0006_sys.gplot
echo "set xtic auto" >> _tmp_cupra02a0006_sys.gplot
echo "set ytic auto" >> _tmp_cupra02a0006_sys.gplot
echo "unset xtic"  >> _tmp_cupra02a0006_sys.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cupra02a0006_sys.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cupra02a0006_sys.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cupra02a0006_sys.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cupra02a0006_sys.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cupra02a0006_sys.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cupra02a0006_sys.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cupra02a0006_sys.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cupra02a0006_sys.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cupra02a0006_sys.gplot
echo "set yrange [0:100]" >> _tmp_cupra02a0006_sys.gplot

##  set the title

cat _tmp_dougee_482* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_482* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cupra02a0006 - $StartHuman to $EndHuman - System CPU for all CPUs'" >> _tmp_cupra02a0006_sys.gplot

cat _tmp_dougee_482* | awk '{ print $3 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_482* | awk '{ print $3 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cupra02a0006_sys.gplot
for datafile in _tmp_dougee_482*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:3 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cupra02a0006_sys.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cupra02a0006_sys.gplot

##  IOWAIT time

echo
echo "  cupra02a0006 iowait all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cupra02a0006_iow.gplot
echo "set output 'cupra02a0006_iowALL.png'" >> _tmp_cupra02a0006_iow.gplot
echo "set autoscale" >> _tmp_cupra02a0006_iow.gplot
echo "set xtic auto" >> _tmp_cupra02a0006_iow.gplot
echo "set ytic auto" >> _tmp_cupra02a0006_iow.gplot
echo "unset xtic"  >> _tmp_cupra02a0006_iow.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cupra02a0006_iow.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cupra02a0006_iow.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cupra02a0006_iow.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cupra02a0006_iow.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cupra02a0006_iow.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cupra02a0006_iow.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cupra02a0006_iow.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cupra02a0006_iow.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cupra02a0006_iow.gplot
echo "set yrange [0:100]" >> _tmp_cupra02a0006_iow.gplot

##  set the title

cat _tmp_dougee_482* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_482* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cupra02a0006 - $StartHuman to $EndHuman - IO wait CPU for all CPUs'" >> _tmp_cupra02a0006_iow.gplot

cat _tmp_dougee_482* | awk '{ print $4 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_482* | awk '{ print $4 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cupra02a0006_iow.gplot
for datafile in _tmp_dougee_482*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:4 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cupra02a0006_iow.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cupra02a0006_iow.gplot


##################################################
##
##  cuprd00a0045 - 483 - 64 CPUs
##
##################################################

##  USR time

echo
echo "  cuprd00a0045 usr all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cuprd00a0045_usr.gplot
echo "set output 'cuprd00a0045_usrALL.png'" >> _tmp_cuprd00a0045_usr.gplot
echo "set autoscale" >> _tmp_cuprd00a0045_usr.gplot
echo "set xtic auto" >> _tmp_cuprd00a0045_usr.gplot
echo "set ytic auto" >> _tmp_cuprd00a0045_usr.gplot
echo "unset xtic"  >> _tmp_cuprd00a0045_usr.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cuprd00a0045_usr.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cuprd00a0045_usr.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cuprd00a0045_usr.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cuprd00a0045_usr.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cuprd00a0045_usr.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cuprd00a0045_usr.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cuprd00a0045_usr.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cuprd00a0045_usr.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cuprd00a0045_usr.gplot
echo "set yrange [0:100]" >> _tmp_cuprd00a0045_usr.gplot

##  set the title

cat _tmp_dougee_483* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_483* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cuprd00a0045 - $StartHuman to $EndHuman - User CPU for all CPUs'" >> _tmp_cuprd00a0045_usr.gplot

cat _tmp_dougee_483* | awk '{ print $2 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_483* | awk '{ print $2 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cuprd00a0045_usr.gplot
for datafile in _tmp_dougee_483*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:2 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cuprd00a0045_usr.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cuprd00a0045_usr.gplot


##  SYS time

echo
echo "  cuprd00a0045 sys all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cuprd00a0045_sys.gplot
echo "set output 'cuprd00a0045_sysALL.png'" >> _tmp_cuprd00a0045_sys.gplot
echo "set autoscale" >> _tmp_cuprd00a0045_sys.gplot
echo "set xtic auto" >> _tmp_cuprd00a0045_sys.gplot
echo "set ytic auto" >> _tmp_cuprd00a0045_sys.gplot
echo "unset xtic"  >> _tmp_cuprd00a0045_sys.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cuprd00a0045_sys.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cuprd00a0045_sys.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cuprd00a0045_sys.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cuprd00a0045_sys.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cuprd00a0045_sys.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cuprd00a0045_sys.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cuprd00a0045_sys.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cuprd00a0045_sys.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cuprd00a0045_sys.gplot
echo "set yrange [0:100]" >> _tmp_cuprd00a0045_sys.gplot

##  set the title

cat _tmp_dougee_483* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_483* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cuprd00a0045 - $StartHuman to $EndHuman - System CPU for all CPUs'" >> _tmp_cuprd00a0045_sys.gplot

cat _tmp_dougee_483* | awk '{ print $3 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_483* | awk '{ print $3 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cuprd00a0045_sys.gplot
for datafile in _tmp_dougee_483*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:3 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cuprd00a0045_sys.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cuprd00a0045_sys.gplot

##  IOWAIT time

echo
echo "  cuprd00a0045 iowait all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cuprd00a0045_iow.gplot
echo "set output 'cuprd00a0045_iowALL.png'" >> _tmp_cuprd00a0045_iow.gplot
echo "set autoscale" >> _tmp_cuprd00a0045_iow.gplot
echo "set xtic auto" >> _tmp_cuprd00a0045_iow.gplot
echo "set ytic auto" >> _tmp_cuprd00a0045_iow.gplot
echo "unset xtic"  >> _tmp_cuprd00a0045_iow.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cuprd00a0045_iow.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cuprd00a0045_iow.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cuprd00a0045_iow.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cuprd00a0045_iow.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cuprd00a0045_iow.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cuprd00a0045_iow.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cuprd00a0045_iow.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cuprd00a0045_iow.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cuprd00a0045_iow.gplot
echo "set yrange [0:100]" >> _tmp_cuprd00a0045_iow.gplot

##  set the title

cat _tmp_dougee_483* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_483* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cuprd00a0045 - $StartHuman to $EndHuman - IO wait CPU for all CPUs'" >> _tmp_cuprd00a0045_iow.gplot

cat _tmp_dougee_483* | awk '{ print $4 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_483* | awk '{ print $4 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cuprd00a0045_iow.gplot
for datafile in _tmp_dougee_483*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:4 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cuprd00a0045_iow.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cuprd00a0045_iow.gplot


##################################################
##
##  cppra01a0006 - 484 - 64 CPUs
##
##################################################

##  USR time

echo
echo "  cppra01a0006 usr all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cppra01a0006_usr.gplot
echo "set output 'cppra01a0006_usrALL.png'" >> _tmp_cppra01a0006_usr.gplot
echo "set autoscale" >> _tmp_cppra01a0006_usr.gplot
echo "set xtic auto" >> _tmp_cppra01a0006_usr.gplot
echo "set ytic auto" >> _tmp_cppra01a0006_usr.gplot
echo "unset xtic"  >> _tmp_cppra01a0006_usr.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cppra01a0006_usr.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cppra01a0006_usr.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cppra01a0006_usr.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cppra01a0006_usr.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cppra01a0006_usr.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cppra01a0006_usr.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cppra01a0006_usr.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cppra01a0006_usr.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cppra01a0006_usr.gplot
echo "set yrange [0:100]" >> _tmp_cppra01a0006_usr.gplot

##  set the title

cat _tmp_dougee_484* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_484* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cppra01a0006 - $StartHuman to $EndHuman - User CPU for all CPUs'" >> _tmp_cppra01a0006_usr.gplot

cat _tmp_dougee_484* | awk '{ print $2 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_484* | awk '{ print $2 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cppra01a0006_usr.gplot
for datafile in _tmp_dougee_484*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:2 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cppra01a0006_usr.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cppra01a0006_usr.gplot


##  SYS time

echo
echo "  cppra01a0006 sys all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cppra01a0006_sys.gplot
echo "set output 'cppra01a0006_sysALL.png'" >> _tmp_cppra01a0006_sys.gplot
echo "set autoscale" >> _tmp_cppra01a0006_sys.gplot
echo "set xtic auto" >> _tmp_cppra01a0006_sys.gplot
echo "set ytic auto" >> _tmp_cppra01a0006_sys.gplot
echo "unset xtic"  >> _tmp_cppra01a0006_sys.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cppra01a0006_sys.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cppra01a0006_sys.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cppra01a0006_sys.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cppra01a0006_sys.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cppra01a0006_sys.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cppra01a0006_sys.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cppra01a0006_sys.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cppra01a0006_sys.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cppra01a0006_sys.gplot
echo "set yrange [0:100]" >> _tmp_cppra01a0006_sys.gplot

##  set the title

cat _tmp_dougee_484* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_484* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cppra01a0006 - $StartHuman to $EndHuman - System CPU for all CPUs'" >> _tmp_cppra01a0006_sys.gplot

cat _tmp_dougee_484* | awk '{ print $3 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_484* | awk '{ print $3 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cppra01a0006_sys.gplot
for datafile in _tmp_dougee_484*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:3 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cppra01a0006_sys.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cppra01a0006_sys.gplot

##  IOWAIT time

echo
echo "  cppra01a0006 iowait all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cppra01a0006_iow.gplot
echo "set output 'cppra01a0006_iowALL.png'" >> _tmp_cppra01a0006_iow.gplot
echo "set autoscale" >> _tmp_cppra01a0006_iow.gplot
echo "set xtic auto" >> _tmp_cppra01a0006_iow.gplot
echo "set ytic auto" >> _tmp_cppra01a0006_iow.gplot
echo "unset xtic"  >> _tmp_cppra01a0006_iow.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cppra01a0006_iow.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cppra01a0006_iow.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cppra01a0006_iow.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cppra01a0006_iow.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cppra01a0006_iow.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cppra01a0006_iow.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cppra01a0006_iow.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cppra01a0006_iow.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cppra01a0006_iow.gplot
echo "set yrange [0:100]" >> _tmp_cppra01a0006_iow.gplot

##  set the title

cat _tmp_dougee_484* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_484* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cppra01a0006 - $StartHuman to $EndHuman - IO wait CPU for all CPUs'" >> _tmp_cppra01a0006_iow.gplot

cat _tmp_dougee_484* | awk '{ print $4 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_484* | awk '{ print $4 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cppra01a0006_iow.gplot
for datafile in _tmp_dougee_484*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:4 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cppra01a0006_iow.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cppra01a0006_iow.gplot


##################################################
##
##  cppra02a0006 - 485 - 64 CPUs
##
##################################################

##  USR time

echo
echo "  cppra02a0006 usr all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cppra02a0006_usr.gplot
echo "set output 'cppra02a0006_usrALL.png'" >> _tmp_cppra02a0006_usr.gplot
echo "set autoscale" >> _tmp_cppra02a0006_usr.gplot
echo "set xtic auto" >> _tmp_cppra02a0006_usr.gplot
echo "set ytic auto" >> _tmp_cppra02a0006_usr.gplot
echo "unset xtic"  >> _tmp_cppra02a0006_usr.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cppra02a0006_usr.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cppra02a0006_usr.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cppra02a0006_usr.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cppra02a0006_usr.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cppra02a0006_usr.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cppra02a0006_usr.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cppra02a0006_usr.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cppra02a0006_usr.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cppra02a0006_usr.gplot
echo "set yrange [0:100]" >> _tmp_cppra02a0006_usr.gplot

##  set the title

cat _tmp_dougee_485* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_485* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cppra02a0006 - $StartHuman to $EndHuman - User CPU for all CPUs'" >> _tmp_cppra02a0006_usr.gplot

cat _tmp_dougee_485* | awk '{ print $2 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_485* | awk '{ print $2 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cppra02a0006_usr.gplot
for datafile in _tmp_dougee_485*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:2 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cppra02a0006_usr.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cppra02a0006_usr.gplot


##  SYS time

echo
echo "  cppra02a0006 sys all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cppra02a0006_sys.gplot
echo "set output 'cppra02a0006_sysALL.png'" >> _tmp_cppra02a0006_sys.gplot
echo "set autoscale" >> _tmp_cppra02a0006_sys.gplot
echo "set xtic auto" >> _tmp_cppra02a0006_sys.gplot
echo "set ytic auto" >> _tmp_cppra02a0006_sys.gplot
echo "unset xtic"  >> _tmp_cppra02a0006_sys.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cppra02a0006_sys.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cppra02a0006_sys.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cppra02a0006_sys.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cppra02a0006_sys.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cppra02a0006_sys.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cppra02a0006_sys.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cppra02a0006_sys.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cppra02a0006_sys.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cppra02a0006_sys.gplot
echo "set yrange [0:100]" >> _tmp_cppra02a0006_sys.gplot

##  set the title

cat _tmp_dougee_485* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_485* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cppra02a0006 - $StartHuman to $EndHuman - System CPU for all CPUs'" >> _tmp_cppra02a0006_sys.gplot

cat _tmp_dougee_485* | awk '{ print $3 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_485* | awk '{ print $3 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cppra02a0006_sys.gplot
for datafile in _tmp_dougee_485*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:3 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cppra02a0006_sys.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cppra02a0006_sys.gplot

##  IOWAIT time

echo
echo "  cppra02a0006 iowait all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cppra02a0006_iow.gplot
echo "set output 'cppra02a0006_iowALL.png'" >> _tmp_cppra02a0006_iow.gplot
echo "set autoscale" >> _tmp_cppra02a0006_iow.gplot
echo "set xtic auto" >> _tmp_cppra02a0006_iow.gplot
echo "set ytic auto" >> _tmp_cppra02a0006_iow.gplot
echo "unset xtic"  >> _tmp_cppra02a0006_iow.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cppra02a0006_iow.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cppra02a0006_iow.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cppra02a0006_iow.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cppra02a0006_iow.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cppra02a0006_iow.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cppra02a0006_iow.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cppra02a0006_iow.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cppra02a0006_iow.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cppra02a0006_iow.gplot
echo "set yrange [0:100]" >> _tmp_cppra02a0006_iow.gplot

##  set the title

cat _tmp_dougee_485* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_485* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cppra02a0006 - $StartHuman to $EndHuman - IO wait CPU for all CPUs'" >> _tmp_cppra02a0006_iow.gplot

cat _tmp_dougee_485* | awk '{ print $4 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_485* | awk '{ print $4 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cppra02a0006_iow.gplot
for datafile in _tmp_dougee_485*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:4 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cppra02a0006_iow.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cppra02a0006_iow.gplot


##################################################
##
##  cpprd00a0841 - 486 - 64 CPUs
##
##################################################

##  USR time

echo
echo "  cpprd00a0841 usr all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cpprd00a0841_usr.gplot
echo "set output 'cpprd00a0841_usrALL.png'" >> _tmp_cpprd00a0841_usr.gplot
echo "set autoscale" >> _tmp_cpprd00a0841_usr.gplot
echo "set xtic auto" >> _tmp_cpprd00a0841_usr.gplot
echo "set ytic auto" >> _tmp_cpprd00a0841_usr.gplot
echo "unset xtic"  >> _tmp_cpprd00a0841_usr.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cpprd00a0841_usr.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cpprd00a0841_usr.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cpprd00a0841_usr.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cpprd00a0841_usr.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cpprd00a0841_usr.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cpprd00a0841_usr.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cpprd00a0841_usr.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cpprd00a0841_usr.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cpprd00a0841_usr.gplot
echo "set yrange [0:100]" >> _tmp_cpprd00a0841_usr.gplot

##  set the title

cat _tmp_dougee_486* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_486* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cpprd00a0841 - $StartHuman to $EndHuman - User CPU for all CPUs'" >> _tmp_cpprd00a0841_usr.gplot

cat _tmp_dougee_486* | awk '{ print $2 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_486* | awk '{ print $2 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cpprd00a0841_usr.gplot
for datafile in _tmp_dougee_486*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:2 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cpprd00a0841_usr.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cpprd00a0841_usr.gplot


##  SYS time

echo
echo "  cpprd00a0841 sys all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cpprd00a0841_sys.gplot
echo "set output 'cpprd00a0841_sysALL.png'" >> _tmp_cpprd00a0841_sys.gplot
echo "set autoscale" >> _tmp_cpprd00a0841_sys.gplot
echo "set xtic auto" >> _tmp_cpprd00a0841_sys.gplot
echo "set ytic auto" >> _tmp_cpprd00a0841_sys.gplot
echo "unset xtic"  >> _tmp_cpprd00a0841_sys.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cpprd00a0841_sys.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cpprd00a0841_sys.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cpprd00a0841_sys.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cpprd00a0841_sys.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cpprd00a0841_sys.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cpprd00a0841_sys.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cpprd00a0841_sys.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cpprd00a0841_sys.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cpprd00a0841_sys.gplot
echo "set yrange [0:100]" >> _tmp_cpprd00a0841_sys.gplot

##  set the title

cat _tmp_dougee_486* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_486* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cpprd00a0841 - $StartHuman to $EndHuman - System CPU for all CPUs'" >> _tmp_cpprd00a0841_sys.gplot

cat _tmp_dougee_486* | awk '{ print $3 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_486* | awk '{ print $3 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cpprd00a0841_sys.gplot
for datafile in _tmp_dougee_486*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:3 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cpprd00a0841_sys.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cpprd00a0841_sys.gplot

##  IOWAIT time

echo
echo "  cpprd00a0841 iowait all cpus..."

PlotIndex=1

echo "set term png size 4096,2048" > _tmp_cpprd00a0841_iow.gplot
echo "set output 'cpprd00a0841_iowALL.png'" >> _tmp_cpprd00a0841_iow.gplot
echo "set autoscale" >> _tmp_cpprd00a0841_iow.gplot
echo "set xtic auto" >> _tmp_cpprd00a0841_iow.gplot
echo "set ytic auto" >> _tmp_cpprd00a0841_iow.gplot
echo "unset xtic"  >> _tmp_cpprd00a0841_iow.gplot
echo "set style line 1 lc rgb \"red\" lw 2 pt 1" >> _tmp_cpprd00a0841_iow.gplot
echo "set style line 2 lc rgb \"blue\" lw 2 pt 1" >> _tmp_cpprd00a0841_iow.gplot
echo "set style line 3 lc rgb \"#22ff22\" lw 2 pt 1" >> _tmp_cpprd00a0841_iow.gplot
echo "set style line 3 lc rgb \"#22aa22\" lw 2 pt 1" >> _tmp_cpprd00a0841_iow.gplot
echo "set style line 4 lc rgb \"magenta\" lw 2 pt 1" >> _tmp_cpprd00a0841_iow.gplot
echo "set style line 5 lc rgb \"plum\" lw 2 pt 1" >> _tmp_cpprd00a0841_iow.gplot
echo "set style line 6 lc rgb \"orange\" lw 2 pt 1" >> _tmp_cpprd00a0841_iow.gplot
echo "set style line 7 lc rgb \"purple\" lw 2 pt 1" >> _tmp_cpprd00a0841_iow.gplot
echo "set style line 8 lc rgb \"brown\" lw 2 pt 1" >> _tmp_cpprd00a0841_iow.gplot
echo "set yrange [0:100]" >> _tmp_cpprd00a0841_iow.gplot

##  set the title

cat _tmp_dougee_486* | awk '{ print $1 }' | sort -un | head -1 | read StartEpoch
cat _tmp_dougee_486* | awk '{ print $1 }' | sort -un | tail -1 | read EndEpoch
FromEpoch $StartEpoch -s | read StartHuman
FromEpoch $EndEpoch -s   | read EndHuman
echo "    from $StartHuman to $EndHuman"
echo "set title 'cpprd00a0841 - $StartHuman to $EndHuman - IO wait CPU for all CPUs'" >> _tmp_cpprd00a0841_iow.gplot

cat _tmp_dougee_486* | awk '{ print $4 }' | sort -un | head -1 | read MinY
cat _tmp_dougee_486* | awk '{ print $4 }' | sort -un | tail -1 | read MaxY
echo "    from $MinY to $MaxY"

printf "plot " >> _tmp_cpprd00a0841_iow.gplot
for datafile in _tmp_dougee_486*.csv
do
  ##  echo "    adding $datafile"
  CPUnumber=`expr $PlotIndex - 1`
  printf "\t'%s' using 1:4 title '${CPUnumber}' with linespoints linestyle %s, \\\\\n" $datafile $PlotIndex >> _tmp_cpprd00a0841_iow.gplot
  PlotIndex=`expr $PlotIndex + 1`
done  ##  for each datafile
echo >> _tmp_cpprd00a0841_iow.gplot


