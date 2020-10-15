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
	if [ ! -f "${BASH_SOURCE%/*}/log.csv" ]; then
		# if not create headers
		echo -e Duration'\t'Project'\t'Description'\t'Date'\t'Time'\t'Weekday'\t'Week'\t'Month'\t'Year> "${BASH_SOURCE%/*}/log.csv"
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

	echo -e $t'\t'$proj'\t'$task'\t'$(date +%D)'\t'$(date +%T)'\t'$(date +%A)'\t'$(date +%V)'\t'$(date +%b)'\t'$(date +%Y) >> "${BASH_SOURCE%/*}/log.csv"
}



# add entry manually
add_entry() {
	
	 
	# prompt for project and don't allow empty
	read -p 'Project: ' proj
	while [ ! -n "$proj" ]; do
	    echo "Project field cannot be empty!"
	    read -p 'Project: ' proj
	done   

	# prompt description 
	read -p 'Description: ' task

	# duration
	read -p 'Duration in minutes: ' dur
		while [ ! -n "$dur" ]; do
	    echo "Duration field cannot be empty!"
	    read -p 'Duration: ' dur
	done   


	# date
	read -p "Enter a date (mm/dd/yy): " user_date
		user_date=$(date -d "$user_date")
		echo "$user_date"

	# set week, weekday, month and year from date

	# set time to 00:00
	echo -e $dur'\t'$proj'\t'$task'\t'$(date -d "$user_date" +%D)'\t'$(date -d "$user_date" +%T)'\t'$(date -d "$user_date" +%A)'\t'$(date -d "$user_date" +%V)'\t'$(date -d "$user_date" +%b)'\t'$(date -d "$user_date" +%Y) >> "${BASH_SOURCE%/*}/log.csv"
	echo "entry added to " ${BASH_SOURCE%/*}/log.csv
}


help(){

	__usage="
	Usage: $(basename $0) [duration] [OPTIONS]

	Runs pomodoro timer with default duration of 25 mins. 

	For a user-specified duration  

	To create the alias pomo add this to your .bashrc file:
		alias pomo='bash /home/user/pathto/pomodoro.sh'

	Options:
		-t, --timer 	Start indefinite timer.
		-l, --list 	List all project titles.
		-s, --show 	Show entries for specific project.	
		-a, --add 	Add manual entry to log file.
		-h, --help	Display usage instructions.
	"
	echo "$__usage"

}


run_timer() {
    # user argument for t

    if [ "$1" = "start" ]
  	then
    	echo "Started pomo timer at $(date +%T)"
    	sleep infinity
    elif [ "$1" = "list" ]
   	then
   		echo "current projects"
   		cut -f2 "${BASH_SOURCE%/*}/log.csv" | sort | uniq #awk '{print tolower($0)}'
	elif [ "$1" = "show" ]
	then
		awk -v val=$2 '$2~ val {print}' "${BASH_SOURCE%/*}/log.csv"
	elif [ "$1" = "add" ]
	then
		add_entry

	elif [ "$1" = "help" ]
	then
		help

	else
    	t=${1:-25}
		TIMER=$((t*60))

		# set timer
		echo "Setting pomodoro timer for $t minutes"
		sleep $TIMER

		# alert timer ended
		xmessage -center "Time's up!"
		
		check_log_exists
		
		log_project
	fi
	}

#run
run_timer $1 $2


