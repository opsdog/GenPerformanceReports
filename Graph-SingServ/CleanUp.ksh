#!/bin/ksh
##
##  clean up old files
##

echo "Removing web directories..."
/bin/rm -rf Web-*

for FileBase in png gplot dat tar
do
  echo "Removing ${FileBase}..."
  find . -name "*.${FileBase}" -exec /bin/rm -f {} \;
done
