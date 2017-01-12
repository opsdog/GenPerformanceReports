#!/bin/ksh
##
##  run overview graphs for the new solaris SIMCORP servers
##
##  first Solaris 11 servers going into use
##

## #############################################################################
## #############################################################################
##
##  special look at prod for portas
##
##  specific LUNS for 8/10 ?
##    c0t60060E801671A200000171A200000551d0s
##    c0t60060E801671A200000171A200000560d0s
##
##  specific LUN for 8/15 ?
##    c0t60060e801671a200000171a200000549d0s 
##
##  we appear to be wait bound
##
## #############################################################################
## #############################################################################

##  8/10 around 5PM
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608101600 201608101800
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608101600` `./ToEpoch 201608101800`

##  8/15 around 9PM
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608152000 201608152200
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608152000` `./ToEpoch 201608152200`

##  8/17 batch runs
##
##    1SCD2_PROD_PRE_ACH_REDEMPTION_BOX
##            8/17/2016 14:45:00  8/17/2016 16:31:25  1:46:25
##    1SCD2_PROD_REDEMPTION_PRE_BOX
##            8/17/2016 15:13:14  8/17/2016 16:04:08  0:50:54
##    1SCD2_PROD_DTF_ACH_PRE_BOX
##            8/17/2016 16:31:26  8/17/2016 16:47:49  0:16:23
##
##    1SCD2_PROD_PRE_EOD_BOX
##            8/17/2016 17:00:01  8/17/2016 18:13:40  1:13:39
##
##    1SCD2_PROD_EOD_BOX
##            8/17/2016 18:13:41  8/18/2016 01:54:04  7:40:23

##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608171430 201608171700
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608171430` `./ToEpoch 201608171700`

##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608171700 201608171830
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608171700` `./ToEpoch 201608171830`

##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608171800 201608180200
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608171800` `./ToEpoch 201608180200`

##  interesting timeframe of last batch run
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608172240 201608172340
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608172240` `./ToEpoch 201608172340`

##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608180000 201608190000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608190000 201608200000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608200000 201608210000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608210000 201608220000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608220000 201608230000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608230000 201608240000


##  full data period - previous SAN ports
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608081100 201608231300
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608081100` `./ToEpoch 201608231300`

##
##  moved to new SAN ports - 201608231300
##

##  full days
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608240000 201608250000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608250000 201608260000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608260000 201608270000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608270000 201608280000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608280000 201608290000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608281900 201608282000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201608290000 201608300000
../Graph-SingServ-Overview.ksh cppsd01a0101 201608300000 201608310000
../Graph-SingServ-Overview.ksh cppsd01a0101 201608310000 201609010000

##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608240000` `./ToEpoch 201608250000`
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608250000` `./ToEpoch 201608260000`
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608260000` `./ToEpoch 201608270000`
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608270000` `./ToEpoch 201608280000`
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608280000` `./ToEpoch 201608290000`
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608281900` `./ToEpoch 201608282000`
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608290000` `./ToEpoch 201608300000`
./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608300000` `./ToEpoch 201608310000`
./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608310000` `./ToEpoch 201609010000`


##  full data period - new SAN ports
../Graph-SingServ-Overview.ksh cppsd01a0101 201608231300 201608311200
./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608231300` `./ToEpoch 201608311200`



exit  ##  dougee

## #############################################################################
## #############################################################################
##
##  backups - cppsi01a0101
##
## #############################################################################
## #############################################################################

##  look at disk/network rates while kevin doing test transfers to BCP
##  20150527 and 20150528

##  ../Graph-SingServ-Overview.ksh cppsi01a0101 201505250000 201505260000
##  ../Graph-SingServ-Overview.ksh cppsi01a0101 201505260000 201505270000
##  ../Graph-SingServ-Overview.ksh cppsi01a0101 201505270000 201505280000

##
##  rman isn't driving the SAN anywhere near capacity - why?
##

##  ../Graph-SingServ-Overview.ksh cppsi01a0101 201508032300 201508040230

##
##  full days
##

##  ../Graph-SingServ-Overview.ksh cppsi01a0101 201507310000 201508010000

##  ksh fork bomb was active - when??

##  ../Graph-SingServ-Overview.ksh cppsi01a0101 201508010000 201508020000
##  ../Graph-SingServ-Overview.ksh cppsi01a0101 201508020000 201508030000
##  ../Graph-SingServ-Overview.ksh cppsi01a0101 201508030000 201508040000
##  ../Graph-SingServ-Overview.ksh cppsi01a0101 201508040000 201508050000
##  ../Graph-SingServ-Overview.ksh cppsi01a0101 201508050000 201508060000


## #############################################################################
## #############################################################################
##
##  test 1 (SIT) performance sucks - why?
##
## #############################################################################
## #############################################################################

##
##  full days
##

##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201507200000 201507210000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201507210000 201507220000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201507220000 201507230000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201507230000 201507240000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201507240000 201507250000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201507250000 201507260000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201507260000 201507270000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201507270000 201507280000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201507280000 201507290000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201507290000 201507300000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201507300000 201507310000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201507310000 201508010000

##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201508010000 201508020000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201508020000 201508030000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201508030000 201508040000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201508040000 201508050000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201508050000 201508060000

##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201508310000 201509010000

##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509010000 201509020000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509020000 201509030000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509030000 201509040000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509040000 201509050000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509050000 201509060000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509060000 201509070000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509070000 201509080000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509080000 201509090000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509090000 201509100000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509100000 201509110000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509110000 201509120000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509120000 201509130000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509130000 201509140000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509140000 201509150000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509150000 201509160000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509160000 201509170000
##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509170000 201509180000
##  left off here ##  ../Graph-SingServ-Overview.ksh ccpsd01a0101 201509180000 201509190000

## #############################################################################
## #############################################################################
##
##  dev1
##
## #############################################################################
## #############################################################################

##
##  run graphs for cdpsd01a0100 while in build
##

##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502030000 201502040000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502040000 201502050000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502050000 201502060000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502060000 201502070000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502070000 201502080000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502080000 201502090000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502090000 201502100000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502100000 201502110000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502110000 201502120000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502120000 201502130000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502130000 201502140000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502140000 201502150000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502150000 201502160000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502160000 201502170000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502170000 201502180000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502180000 201502190000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502190000 201502200000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502200000 201502210000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502210000 201502220000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502220000 201502230000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502230000 201502240000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502240000 201502250000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502250000 201502260000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502260000 201502270000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502270000 201502280000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201502280000 201503010000

##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503010000 201503020000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503020000 201503030000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503030000 201503040000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503040000 201503050000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503050000 201503060000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503060000 201503070000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503070000 201503080000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503080000 201503090000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503090000 201503100000

  ##  crash day

##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503100000 201503110000

##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503130000 201503140000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503140000 201503150000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503150000 201503160000
##  ../Graph-SingServ-Overview.ksh cdpsd01a0101 201503160000 201503170000


## #############################################################################
## #############################################################################
##
##  prod1
##
## #############################################################################
## #############################################################################

##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201505110000 201505120000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201505120000 201505130000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201505130000 201505140000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201505140000 201505150000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201505150000 201505160000

##  go live 20150516 weekend

##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201505160000 201505170000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201505170000 201505180000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201505180000 201505190000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201505190000 201505200000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201505200000 201505210000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201505210000 201505220000

##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509110000 201509120000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509120000 201509130000
##  no data  ##../Graph-SingServ-Overview.ksh cppsd01a0101 201509130000 201509140000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509140000 201509150000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509150000 201509160000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509160000 201509170000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509170000 201509180000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509180000 201509190000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509190000 201509200000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509200000 201509210000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509210000 201509220000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509220000 201509230000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509230000 201509240000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509240000 201509250000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509250000 201509260000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509260000 201509270000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509270000 201509280000
  ##  left off here
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509280000 201509290000

##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509290000 201509300000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201509300000 201510010000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201510010000 201510020000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201510020000 201510030000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201510030000 201510040000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201510040000 201510050000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201510050000 201510060000

##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201512160000 201512170000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201512170000 201512180000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201512180000 201512190000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201512190000 201512200000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201512200000 201512210000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201512210000 201512220000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201512220000 201512230000
##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201512230000 201512240000


##
##  prod1 - ksh out of control during pre go-live testing
##
##  cool patterns in context switches for all cpus
##

##  ../Graph-SingServ-Overview.ksh cppsd01a0101 201505112230 201505120900

## #############################################################################
## #############################################################################
##
##  UAT1 and UAT2
##
## #############################################################################
## #############################################################################

##  ../Graph-SingServ-Overview.ksh cupsd01a0101 201510200000 201510210000
##  ../Graph-SingServ-Overview.ksh cupsd01a0101 201510210000 201510220000
##  ../Graph-SingServ-Overview.ksh cupsd01a0101 201510220000 201510230000
##  ../Graph-SingServ-Overview.ksh cupsd01a0101 201510230000 201510240000

##  ../Graph-SingServ-Overview.ksh cupsd01a0101 201512160000 201512170000
##  ../Graph-SingServ-Overview.ksh cupsd01a0101 201512170000 201512180000
##  ../Graph-SingServ-Overview.ksh cupsd01a0101 201512180000 201512190000
##  ../Graph-SingServ-Overview.ksh cupsd01a0101 201512190000 201512200000
##  ../Graph-SingServ-Overview.ksh cupsd01a0101 201512200000 201512210000
##  ../Graph-SingServ-Overview.ksh cupsd01a0101 201512210000 201512220000
##  ../Graph-SingServ-Overview.ksh cupsd01a0101 201512220000 201512230000
##  ../Graph-SingServ-Overview.ksh cupsd01a0101 201512230000 201512240000

##  UAT2

##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201510200000 201510210000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201510210000 201510220000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201510220000 201510230000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201510230000 201510240000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201510240000 201510250000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201510250000 201510260000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201510260000 201510270000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201510270000 201510280000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201510280000 201510290000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201510290000 201510300000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201510300000 201510310000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201510310000 201511010000
  ##  really bad weekend for UAT2
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201510310000 201511021500

##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201511010000 201511020000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201511020000 201511030000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201511030000 201511040000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201511040000 201511050000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201511050000 201511060000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201511060000 201511070000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201511070000 201511080000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201511080000 201511090000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201511090000 201511100000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201511100000 201511110000
##  ../Graph-SingServ-Overview.ksh crpsd02a0101 201511110000 201511120000

##  #############################################################################
##  #############################################################################
##
##    backups - lots of tar/cpio locally and then copy to NAS
##
##  #############################################################################
##  #############################################################################

../Graph-SingServ-Overview.ksh crpsi01a0101 201605190000 201605200000
../Graph-SingServ-Overview.ksh crpsi01a0101 201605200000 201605210000
../Graph-SingServ-Overview.ksh crpsi01a0101 201605210000 201605220000
../Graph-SingServ-Overview.ksh crpsi01a0101 201605220000 201605230000
../Graph-SingServ-Overview.ksh crpsi01a0101 201605230000 201605240000
../Graph-SingServ-Overview.ksh crpsi01a0101 201605240000 201605250000
../Graph-SingServ-Overview.ksh crpsi01a0101 201605250000 201605260000
../Graph-SingServ-Overview.ksh crpsi01a0101 201605260000 201605270000
../Graph-SingServ-Overview.ksh crpsi01a0101 201605270000 201605280000
../Graph-SingServ-Overview.ksh crpsi01a0101 201605280000 201605290000
../Graph-SingServ-Overview.ksh crpsi01a0101 201605290000 201605300000
../Graph-SingServ-Overview.ksh crpsi01a0101 201605300000 201605310000
../Graph-SingServ-Overview.ksh crpsi01a0101 201605310000 201606010000

../Graph-SingServ-Overview.ksh crpsi01a0101 201606010000 201606020000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606020000 201606030000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606030000 201606040000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606040000 201606050000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606050000 201606060000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606060000 201606070000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606070000 201606080000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606080000 201606090000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606090000 201606100000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606100000 201606110000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606110000 201606120000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606120000 201606130000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606130000 201606140000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606140000 201606150000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606150000 201606160000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606160000 201606170000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606170000 201606180000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606180000 201606190000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606190000 201606200000
../Graph-SingServ-Overview.ksh crpsi01a0101 201606200000 201606210000
