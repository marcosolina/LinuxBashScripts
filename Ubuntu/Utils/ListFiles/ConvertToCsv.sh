#!/bin/bash

# sed -i -e 's/\r$//' SCRIPT_FILE

#################################################################
# START of the script
#################################################################


INPUT_FILE_NAME=fileList.txt
OUTPUT_FILE=fileList.csv


FOLDER=""
SKIP="N"

echo "File/Directory Name;Permissions;Hard Links count;Owner;Group;Size (bytes);Last Edit Month; Day; Time" > $OUTPUT_FILE

while IFS= read -r line
do
  lastChar=${line: -1}
  if  [ "$lastChar" = ":" ]
  then
    FOLDER=${line::-1}/
    SKIP="S"
  else
    if  [ "$SKIP" = "Y" ] || [ -z "$line" ] || [[ $line = total* ]]
    then
      SKIP="N"  
    else
      arr=($line)
      
      i=0
      FILE_NAME=""
      for z in "${arr[@]}"
      do
        if (( i > 7 ))
        then
        	FILE_NAME=$FILE_NAME$z" "
        fi
        i=$((i+1))
      done
      
      
      echo "$FOLDER$FILE_NAME;${arr[0]};${arr[1]};${arr[2]};${arr[3]};${arr[4]};${arr[5]};${arr[6]};${arr[7]}" >> $OUTPUT_FILE
    fi  
  fi
done < "$INPUT_FILE_NAME"