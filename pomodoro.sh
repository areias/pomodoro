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

	\033[1mPomodoro timer and logger\033[0m

	Usage: pomo [duration] [OPTIONS]

	Runs pomodoro timer with default duration of 
	25 mins or user-specified duration. 

	At conclusion of timer prompts user to log which
	project and what tasks where acomplished to a csv file
	saved to the script's source folder.

	ctrl+c before the timer is up will quit the timer 
	and prompt you to log your task with the elapsed time.

	To create the alias \033[1mpomo\033[0m add this to your .bashrc file:
	alias pomo='bash /home/user/pathto/pomodoro.sh'

	Options:
	\033[1m-t, --timer\033[0m 		Start indefinite timer.
	\033[1m-l, --list\033[0m 		List all projects.
	\033[1m-s, --show\033[0m \033[3mproject\033[0m	Show entries for specific project.	
	\033[1m-w, --weekly\033[0m \033[3mproject\033[0m	Weekly summary for specific project.
	\033[1m-a, --add\033[0m 		Add manual entry to log file.
	\033[1m-h, --help\033[0m		Display usage instructions.
	"
	echo -e "$__usage"

}



list_projects(){
	echo "current projects"
	awk 'NR>1{a[$2];}END{for (i in a)print i | "sort";}' "${BASH_SOURCE%/*}/log.csv"
}


show_entries(){
	if [ ! -n "$1" ]
	then
		echo "must specify proect!"
	else
		echo "entries for $1"
		awk -F"\t" -v val="$1" '$2~ val {print $4", "$1", "$3}' "${BASH_SOURCE%/*}/log.csv"
	fi	
}


weekly_summary(){
	if [ ! -n "$1" ]
	then
		echo "must specify proect!"
	else
		echo "total weekly hours for project $1"
		awk -F"\t" -v inp=$1 '$2==inp{a[$7]+=$1;}END{for(i in a)print "week "i", "a[i]" mins" | "sort" ;}' "${BASH_SOURCE%/*}/log.csv"
	fi
}




run_timer(){

	# allow empty or numbers
	re='^[0-9]+$|^$'
	if ! [[ $1 =~ $re ]]
	then
   		echo "error: not a valid duration. see pomo --help" >&2; exit 1
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


main() {

	case $1 in
		-t|--timer)
	    	echo "Started pomo timer at $(date +%T)"
	    	sleep infinity;;

    	-l|--list)
			list_projects;;

		-s|--show)
			show_entries $2;;

		-a|--add)
			add_entry;;

		-w|--weekly)
			weekly_summary $2;;

		-h|--help)
			help;;
		*)
    		run_timer $1;
	esac
	}

#run
main $1 $2


