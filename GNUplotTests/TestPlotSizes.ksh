#!/bin/ksh
##
##  script to test placement of legends on gnuplots of varying sizes
##

. ../MkplotFunctions.ksh

######################################################################
######################################################################
##
##  main
##
######################################################################
######################################################################

# initialize stuff

. ../DateFuncs.ksh

MyEMail="doug.greenwald@gmail.com"

PATH="${PATH}:."

IFSorig="${IFS}"

if [ -d /Volumes/External300/DBProgs/RacePics ]
then
  ProgPrefix="/Volumes/External300/DBProgs/RacePics"
else
  ProgPrefix="/Users/douggreenwald/RacePics"
fi

DBLocation=`${ProgPrefix}/FindDB.ksh`
if [ "$DBLocation" = "notfound" ]
then
  echo "no database - bailing..."
  exit
fi
if [ "$DBLocation" = "localhost" ]
then
  MYSQL="mysql -u root -A"
else
  MYSQL="mysql -h big-mac -u doug -pILikeSex -A"
fi

WorkDir=`pwd`
PlotDataDir=${WorkDir}/GPlotData
ArchiveDir=${WorkDir}/Comp-XXG-20131231-20140107+60

##
##  these are variables used to control various aspects of the plot
##

##  for 640x480

# resX=640
# resY=480

# sizeX=77
# sizeY=96

# LEGENDX=76
# LEGENDY=90
# LEGINCY=06

# legfontName="Georgia Bold"
# legfontSize=12

# TITLEX=46
# TITLEY=96

# titlefontName="Arial"
# titlefontSize=14

##  for 1280x640

# resX=1280
# resY=640

# sizeX=86
# sizeY=96

# LEGENDX=86
# LEGENDY=90
# LEGINCY=06

# legfontName="Georgia Bold"
# legfontSize=14

# TITLEX=49
# TITLEY=962

# titlefontName="Arial"
# titlefontSize=16

##  for 2048x1024

# resX=2048
# resY=1024

# sizeX=91
# sizeY=96

# LEGENDX=915
# LEGENDY=93
# LEGINCY=04

# legfontName="Georgia Bold"
# legfontSize=14

# TITLEX=507
# TITLEY=97

# titlefontName="Arial"
# titlefontSize=20

##  for 4096x2048

# resX=4096
# resY=2048

# sizeX=940
# sizeY=97

# LEGENDX=955
# LEGENDY=95
# LEGINCY=03

# legfontName="Georgia Bold"
# legfontSize=14

# TITLEX=511
# TITLEY=985

# titlefontName="Arial"
# titlefontSize=20

##  for 8192x4096

resX=8192
resY=4096

sizeX=965
sizeY=97

LEGENDX=977
LEGENDY=97
LEGINCY=01

legfontName="Georgia Bold"
legfontSize=14

TITLEX=51
TITLEY=985

titlefontName="Arial"
titlefontSize=40

##  resolution independent

originX="01"
originY="01"

scaleX=1
scaleY=1

GFileBase="TestSize"

##
##  clear old runs
##

echo
echo "Clearing old runs..."

if [ -d $PlotDataDir ]
then
  rm -f ${PlotDataDir}/*.dat 2>/dev/null
else
  mkdir -p $PlotDataDir 2>/dev/null
fi

##
##  create a simple plot file
##

echo "Creating plot script..."

legendX=$LEGENDX
legendY=$LEGENDY
legincY=$LEGINCY

titleX=$TITLEX
titleY=$TITLEY

PlotScript="${GFileBase}.gplot"
rm -f $PlotScript 2>/dev/null

Echo_Header > ${PlotScript}

${ProgPrefix}/NewQuery fsr "select free from vmstat where vmtype = 'S' order by esttime" > ${GFileBase}.dat

minX=0
maxX=`wc -l ${GFileBase}.dat | awk '{ print $1 }'`
minY=`cat ${GFileBase}.dat | sort -un | head -1`
maxY=`cat ${GFileBase}.dat | sort -un | tail -1`

##  use this title to find center of plot area
# echo "set label \"A\" at screen 0.${titleX},0.${titleY} center front textcolor rgb \"black\" font \"${titlefontName},$titlefontSize\"" >> $PlotScript

echo "set label \"Randomly Longish Title Here\" at screen 0.${titleX},0.${titleY} center front textcolor rgb \"black\" font \"${titlefontName},$titlefontSize\"" >> $PlotScript
echo >> $PlotScript

echo "set label \"20140101_XXY\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 1 font \"${legfontName},$legfontSize\"" >> $PlotScript
legendY=`expr $legendY - $legincY`
echo "set label \"20140102_XXY\" at screen 0.${legendX},0.${legendY} front textcolor linestyle 2 font \"${legfontName},$legfontSize\"" >> ${PlotScript}

## echo "set multiplot title 'Randonly Longish Title Here' noenhanced font \"Arial,24\"" >> ${PlotScript}
echo "set multiplot" >> ${PlotScript}
echo >> $PlotScript

echo "set xtics format \"\"" >> $PlotScript
echo >> $PlotScript

echo "set origin 0.${originX},0.${originY}" >> $PlotScript
echo "set size 0.${sizeX},0.${sizeY}" >> $PlotScript
echo "set xrange [${minX}:${maxX}]" >> $PlotScript
echo "set yrange [${minY}:${maxY}]" >> $PlotScript
echo "plot \"${GFileBase}.dat\" title '20140101_XXY' with linespoints linestyle 1" >> $PlotScript

## echo "show margin" >> $PlotScript
