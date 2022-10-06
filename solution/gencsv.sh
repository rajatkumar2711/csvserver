#!/bin/bash
if [ -f "inputFile" ]; then
  rm -rf inputFile
fi
for ((i=0 ; i < $1 ; i++))
do
   echo "$i, $RANDOM" >> inputFile
done
