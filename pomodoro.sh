#!/bin/bash

# Author: Ana Areias <ana.areias at gmail.com>
# Pomodoro Timer and Logger

# quit option 
sigquit()
{
	elapsed=$((SECONDS/60))
	read -p 'project: ' proj
	read -p 'description: ' task
	echo "$elapsed, $proj, $task, $(date)" >> "${BASH_SOURCE%/*}/log2.txt"
	exit
}

trap 'echo "quitting..."; sigquit' INT 

# user argument for t
t=${1:-25}
TIMER=$((t*60))

# set timer
echo "setting pomodoro timer for $t minutes"
sleep $TIMER 

# aler timer ended
xmessage -center "Time's up!"

# user input 
read -p 'project: ' proj
read -p 'description: ' task

# save to log file 
echo "$t, $proj, $task, $(date)" >> "${BASH_SOURCE%/*}/log2.txt"




