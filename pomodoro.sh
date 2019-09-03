#!/bin/bash

# Author: Ana Areias <ana.areias at gmail.com>
# Pomodoro Timer and Logger


# quit option and log with elapsed time
sigquit() {
	# replace t with elapsed time
	t=$((SECONDS/60))
	check_log_exists
	log_project
	exit
}

trap 'echo " Quitting..."; sigquit' INT 


# check if log file already exists and if not create with headers
check_log_exists() {
	if [ ! -f log.csv ]; then
		# if not create headers
		echo "time,project,description,date" > "${BASH_SOURCE%/*}/log.csv"
	fi
}


# save to log file 
log_project() {
	
	# prompt for project and don't allow empty
	read -p 'Project: ' proj
	while [ ! -n "$proj" ]; do
	    echo "Project field cannot be empty!"
	    read -p 'Project: ' proj
	done   
	# prompt description 
	read -p 'Description: ' task

	echo "$t,$proj,$task,$(date)" >> "${BASH_SOURCE%/*}/log.csv"
}


run_timer() {
    # user argument for t
	t=${1:-25}
	TIMER=$((t))

	# set timer
	echo "Setting pomodoro timer for $t minutes"
	sleep $TIMER 

	# alert timer ended
	xmessage -center "Time's up!"
	
	check_log_exists
	
	log_project
}

#run
run_timer $1


