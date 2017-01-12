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
##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608101600 201608101800
##  ./GenPRB-SAN.ksh cppsd01a0101 10 `./ToEpoch 201608101600` `./ToEpoch 201608101800`

##  8/15 around 9PM
##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608152000 201608152200
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

##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608171430 201608171700

##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608171700 201608171830

##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608171800 201608180200

##  interesting timeframe of last batch run
##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608172240 201608172340

##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608180000 201608190000
##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608190000 201608200000
##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608200000 201608210000
##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608210000 201608220000
##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608220000 201608230000
##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608230000 201608240000


##  full data period - previous SAN ports
##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608081100 201608231300

##
##  moved to new SAN ports - 201608231300
##

##  full days
##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608240000 201608250000
##  ./Graph-SingServ-Overview.ksh cppsd01a0101 201608250000 201608260000
./Graph-SingServ-Overview.ksh cppsd01a0101 201608260000 201608270000
./Graph-SingServ-Overview.ksh cppsd01a0101 201608270000 201608280000
./Graph-SingServ-Overview.ksh cppsd01a0101 201608280000 201608290000
./Graph-SingServ-Overview.ksh cppsd01a0101 201608290000 201608300000



##  full data period - new SAN ports
./Graph-SingServ-Overview.ksh cppsd01a0101 201608231300 201608291400



exit  ##  dougee
