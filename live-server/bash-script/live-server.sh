#!/bin/bash

FILE=$1
DIR=$(dirname "$FILE")
NAME=$(basename "$FILE")

 
brave "http://localhost:5001/$NAME" &
exec node /home/snatbep/Dev/Projectos/Tools/live-server/http-server.js 5001 "$FILE" 

