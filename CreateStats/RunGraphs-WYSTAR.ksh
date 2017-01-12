#!/bin/ksh
##
##  run overview graphs for the WYSTAR Prod clusters
##
##  seems to take a perf hit early morning
##

## #############################################################################
## #############################################################################
##
##  primary server set
##
##    prod cluster:  rppsd01a0002 and rppsd02a0002
##    bcp  cluster:  rrpsd01a0002 and rrpsd02a0002
##    prod replica:  rppsd00a0001
##    bcp  replica:  rrpsd00a0001
##
## #############################################################################
## #############################################################################

##
##  prod1
##

##  full days

##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511200000 201511210000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511210000 201511220000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511220000 201511230000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511230000 201511240000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511240000 201511250000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511250000 201511260000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511260000 201511270000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511270000 201511280000

##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512110000 201512120000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512120000 201512130000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512130000 201512140000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512140000 201512150000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512150000 201512160000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512160000 201512170000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512170000 201512180000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512180000 201512190000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512190000 201512200000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512200000 201512210000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512210000 201512220000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512220000 201512230000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512230000 201512240000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512240000 201512250000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512250000 201512260000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512260000 201512270000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512270000 201512280000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512280000 201512290000

  ##  routing change put in place - 201601232300

  ##  bug fix put in place on rrpsd01a0002 - 201602172300


##  midnight to 4AM - sybase blocking issue ?

##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511210000 201511210400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511220000 201511220400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511230000 201511230400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511240000 201511240400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511250000 201511250400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511260000 201511260400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511270000 201511270400

##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512120000 201512120400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512130000 201512130400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512140000 201512140400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512150000 201512150400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512160000 201512160400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512170000 201512170400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512180000 201512180400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512190000 201512190400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512200000 201512200400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512210000 201512210400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512220000 201512220400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512230000 201512230400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512240000 201512240400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512250000 201512250400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512260000 201512260400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512270000 201512270400
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512280000 201512280400

##  high network latency - 0600 to 1500

##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511210600 201511211500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511220600 201511221500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511230600 201511231500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511240600 201511241500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511250600 201511251500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511260600 201511261500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201511270600 201511271500

##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512120600 201512121500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512130600 201512131500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512140600 201512141500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512150600 201512151500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512160600 201512161500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512170600 201512171500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512180600 201512181500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512190600 201512191500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512200600 201512201500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512210600 201512211500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512220600 201512221500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512230600 201512231500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512240600 201512241500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512250600 201512251500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512260600 201512261500
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512270600 201512271500

  ##  routing change put in place - 201601232300

  ##  bug fix put in place on rrpsd01a0002 - 201602172300


##  3AM network hiccup

##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512120315 201512120430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512130315 201512130430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512140315 201512140430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512150315 201512150430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512160315 201512160430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512170315 201512170430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512180315 201512180430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512190315 201512190430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512200315 201512200430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512210315 201512210430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512220315 201512220430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512230315 201512230430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512240315 201512240430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512250315 201512250430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512260315 201512260430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512270315 201512270430
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201512280315 201512280430

##
##  prod2
##

##  full days

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511200000 201511210000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511210000 201511220000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511220000 201511230000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511230000 201511240000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511240000 201511250000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511250000 201511260000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511260000 201511270000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511270000 201511280000

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512110000 201512120000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512120000 201512130000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512130000 201512140000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512140000 201512150000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512150000 201512160000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512160000 201512170000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512170000 201512180000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512180000 201512190000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512190000 201512200000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512200000 201512210000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512210000 201512220000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512220000 201512230000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512230000 201512240000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512240000 201512250000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512250000 201512260000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512260000 201512270000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512270000 201512280000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512280000 201512290000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512290000 201512300000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512300000 201512310000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512310000 201601010000

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601010000 201601020000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601020000 201601030000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601030000 201601040000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601040000 201601050000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601050000 201601060000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601060000 201601070000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601070000 201601080000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601080000 201601090000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601090000 201601100000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601100000 201601110000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601110000 201601120000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601120000 201601130000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601130000 201601140000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601140000 201601150000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601150000 201601160000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601160000 201601170000
  ##  TCP window kernel table put in place - 201601162300
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601170000 201601180000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601180000 201601190000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601190000 201601200000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601200000 201601210000

  ##  routing change put in place - 201601232300

  ##  bug fix put in place on rrpsd01a0002 - 201602172300

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603020000 201603030000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603030000 201603040000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603040000 201603050000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603050000 201603060000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603060000 201603070000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603070000 201603080000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603080000 201603090000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603090000 201603100000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603100000 201603110000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603110000 201603120000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603120000 201603130000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603130000 201603140000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603140000 201603150000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603150000 201603160000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603160000 201603170000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603170000 201603180000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603180000 201603190000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603190000 201603200000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603200000 201603210000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603210000 201603220000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603220000 201603230000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603230000 201603240000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603240000 201603250000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603250000 201603260000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603260000 201603270000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603270000 201603280000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603280000 201603290000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603290000 201603300000
  ##  rcp jobs moved to i interfaces
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603300000 201603310000

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605080000 201605090000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605090000 201605100000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605100000 201605110000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605110000 201605120000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605120000 201605130000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605130000 201605140000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605140000 201605150000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605150000 201605160000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605160000 201605170000

####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606030000 201606040000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606040000 201606050000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606050000 201606060000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606060000 201606070000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606070000 201606080000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606080000 201606090000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606090000 201606100000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606100000 201606110000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606110000 201606120000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606120000 201606130000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606130000 201606140000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606140000 201606150000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606150000 201606160000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606160000 201606170000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606170000 201606180000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606180000 201606190000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606190000 201606200000
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606200000 201606210000


##  exit  ##  dougee


##  midnight to 4AM - sybase blocking issue ?

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511210000 201511210400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511220000 201511220400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511230000 201511230400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511240000 201511240400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511250000 201511250400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511260000 201511260400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511270000 201511270400

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512120000 201512120400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512130000 201512130400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512140000 201512140400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512150000 201512150400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512160000 201512160400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512170000 201512170400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512180000 201512180400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512190000 201512190400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512200000 201512200400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512210000 201512210400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512220000 201512220400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512230000 201512230400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512240000 201512240400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512250000 201512250400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512260000 201512260400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512270000 201512270400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512280000 201512280400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512290000 201512290400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512300000 201512300400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512310000 201512310400

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601010000 201601010400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601020000 201601020400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601030000 201601030400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601040000 201601040400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601050000 201601050400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601060000 201601060400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601070000 201601070400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601080000 201601080400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601090000 201601090400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601100000 201601100400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601110000 201601110400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601120000 201601120400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601130000 201601130400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601140000 201601140400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601150000 201601150400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601160000 201601160400
  ##  TCP window kernel table put in place - 201601162300
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601170000 201601170400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601180000 201601180400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601190000 201601190400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601200000 201601200400

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603080000 201603080400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603280000 201603280400

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605100000 201605100400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605110000 201605110400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605120000 201605120400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605130000 201605130400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605140000 201605140400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605150000 201605150400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605160000 201605160400

####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606030000 201606030400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606040000 201606040400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606050000 201606050400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606060000 201606060400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606070000 201606070400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606080000 201606080400
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606090000 201606090400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606100000 201606100400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606110000 201606110400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606120000 201606120400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606130000 201606130400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606140000 201606140400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606150000 201606150400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606160000 201606160400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606170000 201606170400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606180000 201606180400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606190000 201606190400
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606200000 201606200400


##  exit  ##  dougee


##  high network latency - 0600 to 1500

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511210600 201511211500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511220600 201511221500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511230600 201511231500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511240600 201511241500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511250600 201511251500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511260600 201511261500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201511270600 201511271500

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512120600 201512121500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512130600 201512131500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512140600 201512141500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512150600 201512151500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512160600 201512161500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512170600 201512171500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512180600 201512181500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512190600 201512191500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512200600 201512201500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512210600 201512211500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512220600 201512221500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512230600 201512231500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512240600 201512241500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512250600 201512251500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512260600 201512261500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512270600 201512271500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512280600 201512281500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512290600 201512291500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512300600 201512301500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512310600 201512311500

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601010600 201601011500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601020600 201601021500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601030600 201601031500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601040600 201601041500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601050600 201601051500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601060600 201601061500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601070600 201601071500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601080600 201601081500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601090600 201601091500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601100600 201601101500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601110600 201601111500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601120600 201601121500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601130600 201601131500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601140600 201601141500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601150600 201601151500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601160600 201601161500
  ##  TCP window kernel table put in place - 201601162300
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601170600 201601171500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601180600 201601181500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601190600 201601191500

  ##  routing change put in place - 201601232300

  ##  bug fix put in place on rrpsd01a0002 - 201602172300

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603010600 201603011500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603020600 201603021500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603030600 201603031500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603040600 201603041500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603050600 201603051500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603060600 201603061500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603070600 201603071500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603080600 201603081500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603090600 201603091500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603100600 201603101500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603110600 201603111500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603120600 201603121500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603130600 201603131500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603140600 201603141500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603150600 201603151500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603160600 201603161500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603170600 201603171500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603180600 201603181500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603190600 201603191500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603200600 201603201500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603210600 201603211500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603220600 201603221500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603230600 201603231500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603240600 201603241500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603250600 201603251500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603260600 201603261500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603270600 201603271500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603280600 201603281500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603290600 201603291500
  ##  rcp jobs moved to i interfaces
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603300600 201603301500

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605100600 201605101500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605110600 201605111500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605120600 201605121500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605130600 201605131500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605140600 201605141500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605150600 201605151500

####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606030600 201606031500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606040600 201606041500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606050600 201606051500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606060600 201606061500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606070600 201606071500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606080600 201606081500
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606090600 201606091500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606100600 201606101500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606110600 201606111500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606120600 201606121500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606130600 201606131500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606140600 201606141500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606150600 201606151500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606160600 201606161500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606170600 201606171500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606180600 201606181500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606190600 201606191500
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606200600 201606201500


##  exit  ##  dougee

##  3AM network hiccup

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512120315 201512120430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512130315 201512130430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512140315 201512140430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512150315 201512150430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512160315 201512160430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512170315 201512170430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512180315 201512180430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512190315 201512190430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512200315 201512200430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512210315 201512210430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512220315 201512220430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512230315 201512230430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512240315 201512240430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512250315 201512250430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512260315 201512260430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512270315 201512270430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512280315 201512280430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512290315 201512290430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512300315 201512300430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201512310315 201512310430

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601010315 201601010430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601020315 201601020430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601030315 201601030430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601040315 201601040430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601050315 201601050430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601060315 201601060430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601070315 201601070430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601080315 201601080430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601090315 201601090430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601100315 201601100430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601110315 201601110430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601120315 201601120430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601130315 201601130430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601140315 201601140430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601150315 201601150430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601160315 201601160430
  ##  TCP window kernel table put in place - 201601162300
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601170315 201601170430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601180315 201601180430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601190315 201601190430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201601200315 201601200430

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603010315 201603010430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603020315 201603020430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603030315 201603030430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603040315 201603040430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603050315 201603050430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603060315 201603060430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603070315 201603070430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603080315 201603080430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603090315 201603090430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603100315 201603100430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603110315 201603110430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603120315 201603120430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603130315 201603130430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603140315 201603140430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603150315 201603150430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603160315 201603160430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603170315 201603170430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603180315 201603180430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603190315 201603190430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603200315 201603200430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603210315 201603210430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603220315 201603220430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603230315 201603230430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603240315 201603240430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603250315 201603250430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603260315 201603260430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603270315 201603270430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603280315 201603280430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603290315 201603290430
  ##  rcp jobs moved to i interfaces
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201603300315 201603300430

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605100315 201605100430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605110315 201605110430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605120315 201605120430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605130315 201605130430

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605140315 201605140430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605150315 201605150430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201605160315 201605160430

####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606030315 201606030430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606040315 201606040430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606050315 201606050430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606060315 201606060430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606070315 201606070430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606080315 201606080430
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606090315 201606090430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606100315 201606100430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606110315 201606110430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606120315 201606120430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606130315 201606130430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606140315 201606140430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606150315 201606150430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606160315 201606160430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606170315 201606170430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606180315 201606180430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606190315 201606190430
####  ../Graph-SingServ-Overview.ksh rppsd02a0002 201606200315 201606200430


##  exit  ##  dougee


##
##  bcp1
##

##  full days

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201603080000 201603090000

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201603280000 201603290000

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605090000 201605100000
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605100000 201605110000
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605110000 201605120000
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605120000 201605130000
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605130000 201605140000
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605140000 201605150000
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605150000 201605160000
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605160000 201605170000

../Graph-SingServ-Overview.ksh rrpsd01a0002 201611020000 201611030000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611030000 201611040000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611040000 201611050000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611050000 201611060000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611060000 201611070000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611070000 201611080000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611080000 201611090000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611090000 201611100000

../Graph-SingServ-Overview.ksh rrpsd01a0002 201611100000 201611110000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611110000 201611120000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611120000 201611130000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611130000 201611140000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611140000 201611150000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611150000 201611160000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611160000 201611170000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611170000 201611180000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611180000 201611190000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611190000 201611200000

../Graph-SingServ-Overview.ksh rrpsd01a0002 201611200000 201611210000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611210000 201611220000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611220000 201611230000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611230000 201611240000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611240000 201611250000
../Graph-SingServ-Overview.ksh rrpsd01a0002 201611250000 201611260000



exit  ##  dougee


##  midnight to 4AM - sybase blocking issue ?

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201603080000 201603080400

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201603280000 201603280400

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605100000 201605100400
##  /Graph-SingServ-Overview.ksh rrpsd01a0002 201605110000 201605110400
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605120000 201605120400
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605130000 201605130400

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605140000 201605140400
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605150000 201605150400
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605160000 201605160400


##  exit  ##  dougee


##  high network latency - 0600 to 1500

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201603080600 201603081500

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201603280600 201603281500

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605100600 201605101500
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605110600 201605111500
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605120600 201605121500
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605130600 201605131500

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605140600 201605141500
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605150600 201605151500


##  exit  ##  dougee


##  3AM network hiccup

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201603080315 201603080430

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201603280315 201603280430

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605100315 201605100430
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605110315 201605110430
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605120315 201605120430
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605130315 201605130430

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605140315 201605140430
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605150315 201605150430
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201605160315 201605160430


##  exit  ##  dougee

##
##  bcp 2
##



##  exit  ##  dougee


##
##  prod replica
##

##  full days

##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605090000 201605100000
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605100000 201605110000
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605110000 201605120000
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605120000 201605130000
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605130000 201605140000
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605140000 201605150000
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605150000 201605160000
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605160000 201605170000


##  exit  ##  dougee


##  midnight to 4AM - sybase blocking issue ?

##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605100000 201605100400
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605110000 201605110400
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605120000 201605120400
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605130000 201605130400
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605140000 201605140400
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605150000 201605150400
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605160000 201605160400


##  exit  ##  dougee


##  high network latency - 0600 to 1500

##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605100600 201605101500
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605110600 201605111500
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605120600 201605121500
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605130600 201605131500
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605140600 201605141500
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605150600 201605151500

##  3AM network hiccup

##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605100315 201605100430
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605110315 201605110430
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605120315 201605120430
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605130315 201605130430
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605140315 201605140430
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605150315 201605150430
##  ../Graph-SingServ-Overview.ksh rppsd00a0001 201605160315 201605160430


##  exit  ##  dougee


## #############################################################################
## #############################################################################
##
##  secondary server set
##
##    prod cluster:  appsd01a0001 and appsd02a0001
##    bcp  cluster:  arpsd01a0001 and arpsd02a0001
##    prod replica:  appsd00a0001
##    bcp  replica:  arpsd00a0001
##
## #############################################################################
## #############################################################################

##
##  prod1
##

##  full days

##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511200000 201511210000
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511210000 201511220000
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511220000 201511230000
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511230000 201511240000
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511240000 201511250000
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511250000 201511260000
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511260000 201511270000
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511270000 201511280000

##  midnight to 4AM

##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511210000 201511210400
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511220000 201511220400
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511230000 201511230400
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511240000 201511240400
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511250000 201511250400
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511260000 201511260400
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201511270000 201511270400

##
##  prod2
##

##  full days

##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511200000 201511210000
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511210000 201511220000
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511220000 201511230000
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511230000 201511240000
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511240000 201511250000
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511250000 201511260000
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511260000 201511270000
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511270000 201511280000

##  midnight to 4AM

##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511210000 201511210400
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511220000 201511220400
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511230000 201511230400
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511240000 201511240400
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511250000 201511250400
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511260000 201511260400
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201511270000 201511270400


## #############################################################################
## #############################################################################
##
##   check perf for the dump/load days
##
## #############################################################################
## #############################################################################

##  ../Graph-SingServ-Overview.ksh appsd01a0001 201607290000 201607300000
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201607300000 201607310000
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201607310000 201608010000
##  ../Graph-SingServ-Overview.ksh appsd01a0001 201608010000 201608020000

##  ../Graph-SingServ-Overview.ksh appsd02a0001 201607290000 201607300000
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201607300000 201607310000
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201607310000 201608010000
##  ../Graph-SingServ-Overview.ksh appsd02a0001 201608010000 201608020000

##  ../Graph-SingServ-Overview.ksh arpsd01a0001 201607290000 201607300000
##  ../Graph-SingServ-Overview.ksh arpsd01a0001 201607300000 201607310000
##  ../Graph-SingServ-Overview.ksh arpsd01a0001 201607310000 201608010000
##  ../Graph-SingServ-Overview.ksh arpsd01a0001 201608010000 201608020000

##  ../Graph-SingServ-Overview.ksh arpsd02a0001 201607290000 201607300000
##  ../Graph-SingServ-Overview.ksh arpsd02a0001 201607300000 201607310000
##  ../Graph-SingServ-Overview.ksh arpsd02a0001 201607310000 201608010000
##  ../Graph-SingServ-Overview.ksh arpsd02a0001 201608010000 201608020000

##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201607290000 201607300000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201607300000 201607310000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201607310000 201608010000
##  ../Graph-SingServ-Overview.ksh rppsd01a0002 201608010000 201608020000

##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201607290000 201607300000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201607300000 201607310000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201607310000 201608010000
##  ../Graph-SingServ-Overview.ksh rppsd02a0002 201608010000 201608020000

##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201607290000 201607300000
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201607300000 201607310000
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201607310000 201608010000
##  ../Graph-SingServ-Overview.ksh rrpsd01a0002 201608010000 201608020000

##  ../Graph-SingServ-Overview.ksh rrpsd02a0002 201607290000 201607300000
##  ../Graph-SingServ-Overview.ksh rrpsd02a0002 201607300000 201607310000
##  ../Graph-SingServ-Overview.ksh rrpsd02a0002 201607310000 201608010000
##  ../Graph-SingServ-Overview.ksh rrpsd02a0002 201608010000 201608020000



