#!/bin/ksh
##
##  clean up old files
##

/bin/rm -rf SLA-*

for FileBase in png gplot dat tar
do
  echo "====== $FileBase ======"
  find . -name "*.${FileBase}" -exec /bin/rm -f {} \;
done
