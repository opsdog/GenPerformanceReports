#!/bin/ksh
##
##  run overview graphs for mystery PSFIN02 backup split failures
##

##
##  full days
##

../Graph-SingServ-Overview.ksh cppsi00a0004 201505270000 201505280000

##
##  backup failure span - 0430 to 0600
##

##  failure 201505280515

../Graph-SingServ-Overview.ksh cppsi00a0004 201505280430 201505280600
