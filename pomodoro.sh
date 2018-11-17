#!/bin/bash

# Author: Ana Areias <ana.areias at gmail.com>
# Pomodoro Timer and Logger

# user argument for t
t=${1:-25}
TIMER=$((t*60))

# set timer
echo "setting pomodoro timer for $t minutes"
sleep $TIMER 

# user input 
read -p 'project: ' proj
read -p 'description: ' task

# save to log file 
echo "$t, $proj, $task, $(date)" >> "${BASH_SOURCE%/*}/log2.txt"