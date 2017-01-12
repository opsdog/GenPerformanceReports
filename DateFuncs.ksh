##
##  functions to manipulate the dates found in the input files
##

TZ=":/usr/share/zoneinfo/EST5EDT"
export TZ


vxstat_to_epoch()
{
  #echo "vxstat_to_epoch:  enter kk${Global_vxstat_date}kk"
  echo $Global_vxstat_date | read Junk Monthstr Day Timestr Year
  #echo "vxstat_to_epoch:    $Monthstr $Day $Timestr $Year"
  Hour=`echo $Timestr | awk -F \: '{ print $1 }'`
  Minute=`echo $Timestr | awk -F \: '{ print $2 }'`
  Second=`echo $Timestr | awk -F \: '{ print $3 }'`
  #echo "vxstat_to_epoch:    $Hour $Minute $Second"
  case $Monthstr in
    Jan )  Month=01 ;;
    Feb )  Month=02 ;;
    Mar )  Month=03 ;;
    Apr )  Month=04 ;;
    May )  Month=05 ;;
    Jun )  Month=06 ;;
    Jul )  Month=07 ;;
    Aug )  Month=08 ;;
    Sep )  Month=09 ;;
    Oct )  Month=10 ;;
    Nov )  Month=11 ;;
    Dec )  Month=12 ;;
  esac
  #echo "vxstat_to_epoch:    ${Year}${Month}${Day}${Hour}${Minute}${Second}"
  DateString="${Year}${Month}${Day}${Hour}${Minute}${Second}"
  #echo "vxstat_to_epoch:    DateString == $DateString"
  Global_vxstat_epoch=`${WorkDir}/ToEpoch $DateString`
  #echo "vxstat_to_epoch:  exit ($Global_vxstat_epoch)"
}

cm_to_dougee()
{
  ## echo "cm_to_dougee:  enter kk${Global_cm_date}kk"
  echo $Global_cm_date | read cmDateString cmTimeString
  ## echo "cm_to_dougee:  $cmDateString $cmTimeString"
  Day=`echo $cmDateString | awk -F\- '{ print $1 }'`
  MonthString=`echo $cmDateString | awk -F\- '{ print $2 }'`
  Year=`echo $cmDateString | awk -F\- '{ print $3 }'`
  ## echo "cm_to_dougee:  $MonthString $Day $Year"
  Hour=`echo $cmTimeString | awk -F\: '{ print $1 }'`
  Minute=`echo $cmTimeString | awk -F\: '{ print $2 }'`
  Second=`echo $cmTimeString | awk -F\: '{ print $3 }'`
  ## echo "cm_to_dougee:  $Hour $Minute $Second"
  case $MonthString in
    JAN )  Month=01 ;;
    FEB )  Month=02 ;;
    MAR )  Month=03 ;;
    APR )  Month=04 ;;
    MAY )  Month=05 ;;
    JUN )  Month=06 ;;
    JUL )  Month=07 ;;
    AUG )  Month=08 ;;
    SEP )  Month=09 ;;
    OCT )  Month=10 ;;
    NOV )  Month=11 ;;
    DEC )  Month=12 ;;
  esac
  ## echo "cm_to_dougee:  ${Year} ${Month} ${Day} ${Hour} ${Minute} ${Second}"

  echo "${Year}${Month}${Day}${Hour}${Minute}${Second}"

}
