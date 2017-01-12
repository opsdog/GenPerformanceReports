
##
##  define functions that pull statistics from the database
##

##  #########################################################################
##  #########################################################################
##
##  determine SAN service time SLA for tier 2 based on 15 second intervals
##
##  #########################################################################
##  #########################################################################

Stats_Calc_SAN_SLA_15()
{

  printf " +"

  unset CalcSANSLA15_MinEpoch
  unset CalcSANSLA15_MaxEpoch
  unset CalcSANSLA15_EpochRange
  unset CalcSANSLA15_PctDay
  unset CalcSANSLA15_TotalNonZero
  unset CalcSANSLA15_TotalOver25
  unset CalcSANSLA15_TotalUnder25
  unset CalcSANSLA15_PctUnder25

  ##  debug - make sure we see values from main...

  ##  echo "    Server Name: $ServerName"
  ##  echo "    Start  Time: $StartTime"
  ##  echo "    End    Time: $EndTime"
  ##  echo "    Start Epoch: $StartEpoch"
  ##  echo "    End   Epoch: $EndEpoch"

  ##  pull various statistics from the data

  case $ServerOS in

    SunOS )  
	     CalcSANSLA15_MinEpoch=`${ProgPrefix}/NewQuery fsr "select min(esttime) from iostat where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch}"`
	     CalcSANSLA15_MaxEpoch=`${ProgPrefix}/NewQuery fsr "select max(esttime) from iostat where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch}"`
	     ;;

    Linux )
	     CalcSANSLA15_MinEpoch=`${ProgPrefix}/NewQuery fsr "select min(esttime) from linux_iostat where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch}"`
	     CalcSANSLA15_MaxEpoch=`${ProgPrefix}/NewQuery fsr "select max(esttime) from linux_iostat where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch}"`
	     ;;

    * )      echo "Unsupported OS $ServerOS - bailing..."
	     exit 2
	     ;;

  esac

  if [ "${CalcSANSLA15_MinEpoch}" = "(null)" ]
  then
    CalcSANSLA15_MinEpoch=0
    CalcSANSLA15_MaxEpoch=0
    CalcSANSLA15_EpochRange=0
    CalcSANSLA15_PctDay=0
    CalcSANSLA15_TotalNonZero=0
    CalcSANSLA15_TotalOver25=0
    CalcSANSLA15_TotalUnder25=0
    CalcSANSLA15_PctUnder25=0
    return
  fi

  CalcSANSLA15_EpochRange=`echo "$CalcSANSLA15_MaxEpoch - $CalcSANSLA15_MinEpoch" | bc`
  CalcSANSLA15_PctDay=`echo "scale=4 ; $CalcSANSLA15_EpochRange / 60 / 60" | bc`

  case $ServerOS in

    SunOS )
             CalcSANSLA15_TotalNonZero=`${ProgPrefix}/NewQuery fsr "select count(asvct) from iostat where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch} and asvct > 0.0"`
	     CalcSANSLA15_TotalOver25=`${ProgPrefix}/NewQuery fsr "select count(asvct) from iostat where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch} and asvct >= 25.0"`
	     CalcSANSLA15_TotalUnder25=`${ProgPrefix}/NewQuery fsr "select count(asvct) from iostat where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch} and asvct > 0.0 and asvct < 25.0"`
	     ;;

    Linux )
             CalcSANSLA15_TotalNonZero=`${ProgPrefix}/NewQuery fsr "select count(svctm) from linux_iostat where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch} and svctm > 0.0"`
	     CalcSANSLA15_TotalOver25=`${ProgPrefix}/NewQuery fsr "select count(svctm) from linux_iostat where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch} and svctm >= 25.0"`
	     CalcSANSLA15_TotalUnder25=`${ProgPrefix}/NewQuery fsr "select count(svctm) from linux_iostat where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch} and svctm > 0.0 and svctm < 25.0"`
	     ;;

    * )      echo "Unsupported OS $ServerOS - bailing..."
	     exit 3
	     ;;

  esac


  CalcSANSLA15_PctUnder25=`echo "scale=6; ( $CalcSANSLA15_TotalUnder25 / $CalcSANSLA15_TotalNonZero ) * 100.00" | bc`

  ##  echo "    Epoch Range: $CalcSANSLA15_EpochRange (of 86400)"
  ##  echo "    Measured Hours: $CalcSANSLA15_PctDay"
  ##  echo "    CalcSANSLA15_TotalNonZero: $CalcSANSLA15_TotalNonZero"
  ##  echo "    CalcSANSLA15_TotalOver25 : $CalcSANSLA15_TotalOver25"
  ##  echo "    CalcSANSLA15_TotalUnder25: $CalcSANSLA15_TotalUnder25"
  ##  echo "    CalcSANSLA15_PctUnder25  : $CalcSANSLA15_PctUnder25"
  ##  echo

}  ##  end of function Stats_Calc_SAN_SLA_15

##  #########################################################################
##  #########################################################################
##
##  determine SAN service time SLA for tier 2 based on 1 minute intervals
##
##  this matches the SAN team's measured SLA
##
##  #########################################################################
##  #########################################################################

Stats_Calc_SAN_SLA()
{

  printf " +"

  unset CalcSANSLA_MinEpoch
  unset CalcSANSLA_MaxEpoch
  unset CalcSANSLA_EpochRange
  unset CalcSANSLA_PctDay
  unset CalcSANSLA_TotalNonZero
  unset CalcSANSLA_TotalOver25
  unset CalcSANSLA_TotalUnder25
  unset CalcSANSLA_PctUnder25

  ##  debug - make sure we see values from main...

  ##  echo "    Server Name: $ServerName"
  ##  echo "    Start  Time: $StartTime"
  ##  echo "    End    Time: $EndTime"
  ##  echo "    Start Epoch: $StartEpoch"
  ##  echo "    End   Epoch: $EndEpoch"

  ##  pull various statistics from the data

  case $ServerOS in

    SunOS )  
	     CalcSANSLA_MinEpoch=`${ProgPrefix}/NewQuery fsr "select min(esttime) from iostat58 where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch}"`
	     CalcSANSLA_MaxEpoch=`${ProgPrefix}/NewQuery fsr "select max(esttime) from iostat58 where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch}"`
	     ;;

    Linux )
	     CalcSANSLA_MinEpoch=`${ProgPrefix}/NewQuery fsr "select min(esttime) from linux_iostat58 where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch}"`
	     CalcSANSLA_MaxEpoch=`${ProgPrefix}/NewQuery fsr "select max(esttime) from linux_iostat58 where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch}"`
	     ;;

    * )      echo "Unsupported OS $ServerOS - bailing..."
	     exit 4
	     ;;

  esac

  if [ "${CalcSANSLA_MinEpoch}" = "(null)" ]
  then
    CalcSANSLA_MinEpoch=0
    CalcSANSLA_MaxEpoch=0
    CalcSANSLA_EpochRange=0
    CalcSANSLA_PctDay=0
    CalcSANSLA_TotalNonZero=0
    CalcSANSLA_TotalOver25=0
    CalcSANSLA_TotalUnder25=0
    CalcSANSLA_PctUnder25=0
    return
  fi

  CalcSANSLA_EpochRange=`echo "$CalcSANSLA_MaxEpoch - $CalcSANSLA_MinEpoch" | bc`
  CalcSANSLA_PctDay=`echo "scale=4 ; $CalcSANSLA_EpochRange / 60 / 60" | bc`

  case $ServerOS in

    SunOS )  
             CalcSANSLA_TotalNonZero=`${ProgPrefix}/NewQuery fsr "select count(asvct) from iostat58 where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch} and asvct > 0.0"`
	     CalcSANSLA_TotalOver25=`${ProgPrefix}/NewQuery fsr "select count(asvct) from iostat58 where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch} and asvct >= 25.0"`
	     CalcSANSLA_TotalUnder25=`${ProgPrefix}/NewQuery fsr "select count(asvct) from iostat58 where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch} and asvct > 0.0 and asvct < 25.0"`
	     ;;

    Linux )
             CalcSANSLA_TotalNonZero=`${ProgPrefix}/NewQuery fsr "select count(svctm) from linux_iostat58 where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch} and svctm > 0.0"`
	     CalcSANSLA_TotalOver25=`${ProgPrefix}/NewQuery fsr "select count(svctm) from linux_iostat58 where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch} and svctm >= 25.0"`
	     CalcSANSLA_TotalUnder25=`${ProgPrefix}/NewQuery fsr "select count(svctm) from linux_iostat58 where serverid = ${ServerID} and devtype = 2 and esttime between ${StartEpoch} and ${EndEpoch} and svctm > 0.0 and svctm < 25.0"`
	     ;;

    * )      echo "Unsupported OS $ServerOS - bailing..."
             exit 5
	     ;;

  esac

  CalcSANSLA_PctUnder25=`echo "scale=6; ( $CalcSANSLA_TotalUnder25 / $CalcSANSLA_TotalNonZero ) * 100.00" | bc`

  ##  echo "    Epoch Range: $CalcSANSLA_EpochRange (of 86400)"
  ##  echo "    Measured Hours: $CalcSANSLA_PctDay"
  ##  echo "    CalcSANSLA_TotalNonZero: $CalcSANSLA_TotalNonZero"
  ##  echo "    CalcSANSLA_TotalOver25 : $CalcSANSLA_TotalOver25"
  ##  echo "    CalcSANSLA_TotalUnder25: $CalcSANSLA_TotalUnder25"
  ##  echo "    CalcSANSLA_PctUnder25  : $CalcSANSLA_PctUnder25"
  ##  echo

}  ##  end of function Stats_Calc_SAN_SLA

