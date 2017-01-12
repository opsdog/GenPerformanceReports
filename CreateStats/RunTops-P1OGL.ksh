#!/bin/ksh
##
##  generate top LUN use for P1OGL for various timeframes
##

## #############################################################################
## #############################################################################
##
##                        heading into year-end 2016
##
## #############################################################################
## #############################################################################

##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611170500 201611171200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611180500 201611181200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611190500 201611191200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611200500 201611201200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611210500 201611211200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611220500 201611221200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611230500 201611231200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611240500 201611241200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611250500 201611251200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611260500 201611261200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611270500 201611271200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611280500 201611281200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611290500 201611291200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201611300500 201611301200

##  ../GenPRB-SAN.ksh cppsd01a0100 15 201612010500 201612011200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201612020500 201612021200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201612030500 201612031200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201612040500 201612041200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201612050500 201612051200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201612060500 201612061200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201612070500 201612071200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201612080500 201612081200
##  ../GenPRB-SAN.ksh cppsd01a0100 15 201612090500 201612091200

##
##  run the disk group perf graphs for the really bad days
##

for DiskGroup in `ls -l DiskGroup-P1OGL-*-201612 2>/dev/null | awk '{ print $NF }'`
do
  echo "Graphing disk group $DiskGroup..."
  ../Graph-DiskGroup.ksh cppsd01a0100 201611300500 201611301200 $DiskGroup  ##  3:27
  ../Graph-DiskGroup.ksh cppsd01a0100 201612020500 201612021200 $DiskGroup  ##  6:24
  ../Graph-DiskGroup.ksh cppsd01a0100 201612060500 201612061200 $DiskGroup  ##  5:03
done

##
##  run the top luns for each category for each bad day
##

for DiskGroup in `ls -l DiskGroup-TopLUNs-P1OGL-*-20161130 2>/dev/null | awk '{ print $NF }'`
do
  echo "Graphing disk group $DiskGroup 20161130..."
  ../Graph-DiskGroup.ksh cppsd01a0100 201611300500 201611301200 $DiskGroup -n
done

for DiskGroup in `ls -l DiskGroup-TopLUNs-P1OGL-*-20161202 2>/dev/null | awk '{ print $NF }'`
do
  echo "Graphing disk group $DiskGroup 20161202..."
  ../Graph-DiskGroup.ksh cppsd01a0100 201612020500 201612021200 $DiskGroup  -n
done

for DiskGroup in `ls -l DiskGroup-TopLUNs-P1OGL-*-20161206 2>/dev/null | awk '{ print $NF }'`
do
  echo "Graphing disk group $DiskGroup 20161206..."
  ../Graph-DiskGroup.ksh cppsd01a0100 201612060500 201612061200 $DiskGroup  -n
done

