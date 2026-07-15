
#!/bin/bash

FILE=$1

current_directory=$(pwd)
diferencia="${FILE#$current_directory}"

brave "http://localhost:5001$diferencia" &
exec node /home/snatbep/Dev/Projectos/Tools/live-server/http-server.js 5001 "$FILE"
