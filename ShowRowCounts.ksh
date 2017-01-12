#!/bin/ksh
##
##  script to show the row counts of the performance tables
##

if [ -d /Volumes/External300/DBProgs/RacePics ]
then
  ProgPrefix="/Volumes/External300/DBProgs/RacePics"
else
  ProgPrefix="/Users/douggreenwald/RacePics"
fi


RowTotal=0

for Table in aiodetail aiosyscall aioveritas asmmap colldate disk diskgroup diskpaths iocalc iocalc_tape iocalc_acfs iocalcnfs ioerrcalc iostat iostaterrs iostat58 iostat58errs mpstat netstat nicstat nic plex portmap procbycpu procbymem server ssd throttle vdisk vmemfail vmstat vxcache vxcalc vxcalc_dm vxfsstat vxstat zfsmap linux_iocalc linux_iostat linux_iostat58 linux_netstat linux_vmstat pingtime
do
  Count=`${ProgPrefix}/NewQuery fsr "select count(*) from ${Table}" 2>/dev/null`
  printf "  %-18s %12d\n" $Table $Count
  printf "%12d" $Count | read fCount
  RowTotal=`expr $RowTotal + $fCount`
done  ##  for each table

printf "\nTotal: %26d\n" $RowTotal
