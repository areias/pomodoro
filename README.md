# Pomodoro timer and logger


Usage: pomo [duration] [OPTIONS]  

  
Simple shell script that sets a timer for an user-specified amount of minutes (default is 25 mins) and at the end of that period prompts the user to log which project and what tasks where acomplished to a csv log file (saved to the script's source folder).

For default duration of 25 minutes, use:
`$ pomo` 

For user-specified 10 minutes duration, use:
`$ pomo 10`

`ctrl+c` before the timer is up will quit the timer and prompt you to log your task with the elapsed time.


## Create the alias pomo
To be able to use `pomo` as a command shortcut, add to your .bashrc file a reference to the pomodoro.sh script:
`$ alias pomo='bash /home/user/pathto/pomodoro.sh'`





## Options
**-t, --timer** 			Start indefinite timer.  
**-l, --list**				List all projects.  
**-s, --show** *project*	Showgit add  entries for specific project.  	
**-w, --weekly** *project* 	Weekly summary for specific project.  
**-a, --add** 				Add manual entry to log file.  
**-h, --help**				Display usage instructions.  



## Additional features to implement
* ~~default 25 mins~~
* ~~pop up over everything once timer is up~~ 
* ~~option to pause and restart timer~~
* ~~option to quit mid-timer and log elapsed time with tasks~~
* ~~report option that generates summary view with total time worked per project~~
* option to save log file elsewhere 




