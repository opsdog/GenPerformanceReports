#!/bin/ksh
##
##  clean up old files
##

/bin/rm -rf Net1-*

for FileBase in png gplot dat tar
do
  echo "====== $FileBase ======"
  find . -name "*.${FileBase}" -exec /bin/rm -f {} \;
done
