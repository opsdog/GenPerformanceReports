#!/bin/ksh
##
##  generate the various plot sets
##

##  #####################################################################
##  #####################################################################
##
##  all data available by server
##
##    requires data from both pingtime and netstat for full report
##
##  #####################################################################
##  #####################################################################

##
##  prod2 a to bcp1 a - the RCPs
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01a0002 rrpsd01a0002 201603250000 201603300000  ##  all avail data

##
##  prod2 a to bcp1 e - the RCPs
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603250000 201603300000  ##  all avail data

##
##  prod2 a to bcp1 i - the RCPs
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603250000 201603300000  ##  all avail data


##
##  prod2 a to prod-rep a - the volume replication
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rppsd00a0001 201603250000 201603300000  ##  all avail data


##
##  prodrep a to prod2 e - the volume replication
./Net-PingVSPacket.ksh rppsd00a0001 rppsd02e0002 rppsd02a0002 201603250000 201603300000  ##  all avail data


exit



##  #####################################################################
##  #####################################################################
##
##  full days - R cluster - rppsd01a0002
##
##  #####################################################################
##  #####################################################################


##  #####################################################################
##  #####################################################################
##
##  full days - R cluster - rppsd02a0002
##
##  #####################################################################
##  #####################################################################

##
##  to rrpsd01e0100 - the rcp copies - original
##

  ##  primary databases moved here - 201509something
  ##  running grp1 on igb0
  ##  running grp1 on igb2 - 20151204
  ##  back to running grp1 on igb0 - 20151211
  ##  temp back to alternating rcp's - 20151217 - lower latency, higher times
  ##  routing change put in place - 201601232300
  ##  TCP window kernel table put in place - 201601162300

./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602160000 201602170000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602170000 201602180000
  ##  bug fix put in place on rrpsd01a0002 - 201602172300
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602180000 201602190000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602190000 201602200000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602200000 201602210000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602210000 201602220000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602220000 201602230000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602230000 201602240000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602240000 201602250000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602250000 201602260000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602260000 201602270000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602270000 201602280000
  ##  bug fix put in place on all PROD - 201602272300
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602280000 201602290000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201602290000 201603010000

./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603010000 201603020000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603020000 201603030000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603030000 201603040000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603040000 201603050000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603050000 201603060000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603060000 201603070000

./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603070000 201603080000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603080000 201603090000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603090000 201603100000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603100000 201603110000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603110000 201603120000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603120000 201603130000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603130000 201603140000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603140000 201603150000
  ##  added i interfaces
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603150000 201603160000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603160000 201603170000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603170000 201603180000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603180000 201603190000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603190000 201603200000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603200000 201603210000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603210000 201603220000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603220000 201603230000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603230000 201603240000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603240000 201603250000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603250000 201603260000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603260000 201603270000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603270000 201603280000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603280000 201603290000
  ##  rcp moved to i interface
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603290000 201603300000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01e0002 rrpsd01a0002 201603300000 201603310000

##
##  to rrpsd01i0100 - the rcp copies - new
##

./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603150000 201603160000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603160000 201603170000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603170000 201603180000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603180000 201603190000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603190000 201603200000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603200000 201603210000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603210000 201603220000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603220000 201603230000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603230000 201603240000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603240000 201603250000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603250000 201603260000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603260000 201603270000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603270000 201603280000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603280000 201603290000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603290000 201603300000
./Net-PingVSPacket.ksh rppsd02a0002 rrpsd01i0002 rrpsd01a0002 201603300000 201603310000



exit



##
##  to rppsd00a0001 - volume replication
##

  ##  primary databases moved here - 201509something
  ##  running grp1 on igb0
  ##  running grp1 on igb2 - 20151204
  ##  back to running grp1 on igb0 - 20151211
  ##  temp back to alternating rcp's - 20151217 - lower latency, higher times
  ##  routing change put in place - 201601232300
  ##  TCP window kernel table put in place - 201601162300

./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602160000 201602170000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602170000 201602180000
  ##  bug fix put in place on rrpsd01a0002 - 201602172300
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602180000 201602190000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602190000 201602200000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602200000 201602210000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602210000 201602220000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602220000 201602230000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602230000 201602240000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602240000 201602250000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602250000 201602260000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602260000 201602270000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602270000 201602280000
  ##  bug fix put in place on all PROD - 201602272300
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602280000 201602290000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201602290000 201603010000

./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201603010000 201603020000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201603020000 201603030000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201603030000 201603040000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201603040000 201603050000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201603050000 201603060000
./Net-PingVSPacket.ksh rppsd02a0002 rppsd00a0001 rrpsd01a0002 201603060000 201603070000


##  #####################################################################
##  #####################################################################
##
##  morning rcp of logs to BCP - 6AM to at least 2PM
##
##  #####################################################################
##  #####################################################################


##  #####################################################################
##  #####################################################################
##
##  something odd happens on rppsd02 between 3:30 and ~4:15
##
##  #####################################################################
##  #####################################################################


