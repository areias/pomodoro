# Pomodoro timer and logger

Simple shell script that sets a timer for a user-specified amount of minutes (default is 25 mins) and at the end of that period allows user to log which project and what tasks where acomplished during that period to a csv log file.

For default duration of 25 minutes, use:
`$ pomo` 

For user-specified 10 minutes duration, use:
`$ pomo 10`

`ctrl+c` will quit the timer and prompt to log your task with the elapsed time.


## Create the alias pomo
Add to .bashrc file a reference to script
`$ alias pomo='bash /home/areias/Dropbox/DataScience/Pomodoro/pomodoro.sh'`


## Additional features to implement
* default 25 mins
* pop up over everything once timer is up 
* option to pause timer
* timer count down to remaining minutes
* option to quit mid-timer and log elapsed time with tasks
* report option that generates total time worked per project 
* run as background process 


