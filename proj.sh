project_options(){

	# create tempfile
	tmpfile=$(mktemp)

	# save list of unique projects
	cut -d, -f 2 log.csv | sort | uniq > '$tmpfile'

	# add delimiters to tempfile
	sed -i "s/^/'/" '$tmpfile'
	sed -i "s/$/'/" '$tmpfile' 

	#all_lines=$(cat $tmpfile)

	# read into array
	readarray -t array < $tmpfile

	pattern=''
	for i in ${array[@]}
	do
		pattern+="$i|"
	done

	echo ${pattern:: -1}

	# menu_from_array (){

	# select item; do
	# # Check the selected menu item number
	# 	if [ 1 -le '$REPLY' ] && [ '$REPLY' -le $# ];

	# 	then
	# 	echo 'The selected operating system is $item'
	# 	break;
	# 	else
	# 	echo 'Wrong selection: Select any number from 1-$#'
	# 	fi
	# 	done
	# }

 # 	menu_from_array '${array[@]}'
	#echo '$options'

	#all_lines=`cat $tmpfile`

	# /*
	# 	options=
	# for line in $all_lines ; 
	# 	do
	#     options+='${line}'
	#     options+=' '
	# 	done
	# */

	# project selection choices
	PS3='Choose a project: '
	select project in '${array[@]}' 'quit'
	do
		case $project in 
			'duh'|'hello dear')
				echo 'yo'
				;;
			'quit')
				break
				;;
		esac
	done


# 	PS3='Please enter your choice: '
# 	options=('Option 1' 'Option 2' 'Option 3' 'Quit')
# 	select opt in '${options[@]}'
# 	do
# 	    case $opt in
# 	        'Option 1'|'Option 2')
# 	            echo 'you chose choice 1'
# 	            ;;
# 	        'Option 3')
# 	            echo 'you chose choice $REPLY which is $opt'
# 	            ;;
# 	        'Quit')
# 	            break
# 	            ;;
# 	        *) echo 'invalid option $REPLY';;
# 	    esac
# done
# 	#echo you picked \($REPLY\)

# 	#cat '$tmpfile'| while read line;
# 	#do
# 	#	echo $line
# 	#done

# 	#wc -l '$tmpfile'

	rm '$tmpfile'
}

project_options
