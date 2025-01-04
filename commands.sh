# this utility maintains functions that can be used in ~/.zshrc aliases
# does not pollute main ~/.zshrc file
# how to use:
# source ~/.zsh_command_helpers.sh && lgrp $1

list_dir_and_grep_exp () {
	if [ -z "$1" ]; then
		echo "\n****\nWARNING:\nls executed;\npass expression to search for or use ls instead;\nno point of using this util without search expression\n****\n"
		ls
		return;
	fi;

	directory_to_list="."
	expression_to_grep="$1"
	if [ -n "$2" ]; then
		directory_to_list="$1"
		expression_to_grep="$2"
	else
		directory_to_list="."
		expression_to_grep="$1"
	fi;
	ls -a $directory_to_list | grep -i $expression_to_grep
}

# this does not work yet
# since updating system files requires
# running as root
# need to figure out a better alternative
toggle_focus_dev_mode () {
	hosts_file_path="/etc/hosts"
	focus_mode_start_id="#region focus-mode"
	focus_mode_end_id="#endregion focus-mode"

	block_distracting_sites_host_file_content="
127.0.0.1 x.com
127.0.0.1 twitter.com
127.0.0.1 www.twitter.com
127.0.0.1 www.x.com
127.0.0.1 instagram.com
127.0.0.1 www.instagram.com
127.0.0.1 news.ycombinator.com
127.0.0.1 nytimes.com
127.0.0.1 youtube.com
"

	focus_hosts_file_content="\n$focus_mode_start_id\n\n$block_distracting_sites_host_file_content\n\n$focus_mode_end_id\n"
	current_file_content=`cat $hosts_file_path`
	if [[ $current_file_content == *"$focus_hosts_file_content"* ]]; then
		# logic to remove substring from original string
		focus_mode_disabled_host_file_content=""

		echo "Current Content\n\n$current_file_content"
		# Note that this ovverides the hosts file content and not just appends content
		# this is dangerous!
		# Hence we are echoing existing content just in case :)
		echo "$focus_hosts_file_content" > $hosts_file_path
		echo "Turned Off Focus Mode"
	else
		echo "$focus_hosts_file_content" >> $hosts_file_path
		echo "Focus Mode On!"
	fi
}