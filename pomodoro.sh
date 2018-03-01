#!/bin/bash

# Author: Ana Areias <ama.areias at gmail.com>
# Pomodoro Timer and Logger

t=$1
TIMER=$((t*6))

sleep $TIMER 
frmdata=$(yad --form \
	--image="${BASH_SOURCE%/*}/pomodoro_small.png" \
	--title="Pomodoro logger" \
	--text="You just did $t mins of work!" \
   	--field="Project":CBE \
	 "Bakeoff!Tanzania!Wages" \
   	--field="Task"\
	--on-top)

proj=$(echo $frmdata | awk 'BEGIN {FS="|"} { print $1 }') 
task=$(echo $frmdata | awk 'BEGIN {FS="|"} { print $2 }')

echo "$t, $proj, $task, $(date)" >> "${BASH_SOURCE%/*}/log.txt"




