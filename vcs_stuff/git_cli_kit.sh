# this utility maintains functions that can be used in ~/.gitconfig aliases
# does not pollute main ~/.zshrc file
# how to use:
# source ~/.git_helpers.sh && open_new_pr $1

# useful properties of CWD git repostitory
# before using call `set_local_repo_configs`
LOCAL_REPOSITORY_HOST=""
LOCAL_REPOSITORY_OWNER=""
LOCAL_REPOSITORY=""

# makes assumption that there is a remote by the name of `origin`
set_local_repo_configs () {
	SSH_URL=$(git config --local --get remote.origin.url)
	
	LOCAL_REPOSITORY_HOST=$(awk -F'git@|:|/|.git' '{print $2}' <<< $SSH_URL)
	LOCAL_REPOSITORY_OWNER=$(awk -F'git@|:|/|.git' '{print $3}' <<< $SSH_URL)
	
	# contains .git appended at the end
	dirty_repo_name=$(awk -F '/' '{print $2}' <<< $SSH_URL)
	LOCAL_REPOSITORY=$(awk -F'.' '{print $1}' <<< $dirty_repo_name)
}

open_new_pr () {
	set_local_repo_configs

	new_pr_url="https://$LOCAL_REPOSITORY_HOST/$LOCAL_REPOSITORY_OWNER/$LOCAL_REPOSITORY/compare";

	if [ $1 ]; then
		new_pr_url="$new_pr_url/$1...$(git cur)?expand=1";
	else
		new_pr_url="$new_pr_url/$(git cur)?expand=1";
	fi;	

	# --background does not work as of now
    # --profile-directory="Default" makes sure to use work profile on chrome
	/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --profile-directory="Default" $new_pr_url
}


# requires `gh` cli and user should be logged in 
run_experimental_workflow () {

	# push new changes to remote first
	echo "Pushing to remote: $(git cur)"
	git push

	# $* ensures all command line args are getting passed
	gh workflow run .github/workflows/experimental_workflow.yml --ref=$(git cur) $*; 

	_temp_gh_exp_run_id=""
	tries_left=10
	while [[ "$_temp_gh_exp_run_id" = "" ]] && [[ $tries_left -ge 0 ]]; do

		# it takes some time for the run to appear as queued
	    sleep 1

	    # filter runs for current branch and status queued
	    # assuming only single result will be returned, we read 7th column
	    # values like 7th column might be specific to this workflow's name
	    _temp_gh_exp_run_id=$(gh run list --workflow=experimental_workflow.yml --status=queued --branch=$(git cur) | awk -F '\t' 'FNR == 1 { print $7}')

	    ((tries_left--))
	done
	
	set_local_repo_configs
	new_workflow_run_url="https://$LOCAL_REPOSITORY_HOST/$LOCAL_REPOSITORY_OWNER/$LOCAL_REPOSITORY/actions/runs/$_temp_gh_exp_run_id";
	echo "Workflow Run URl: $new_workflow_run_url"
	
	# comment to avoid opening the link in chrome but just log it on terminal
	# --background does not work as of now
	/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --background --args --profile-directory="Default" $new_workflow_run_url
	# gh run view $_temp_gh_exp_run_id --web
}


# update local branch from a remote branch
# if remote branch is not specified, current checked out branch will be used to update
update () {
	remote_branch="invalid-branch"
	if [ "$1" ] && [ "$1" != "-i" ]; then
  		remote_branch="$1"
	elif [ "$(git cur)" ]; then
		remote_branch="$(git cur)";
	else
		echo "Invalid Branch: either pass a valid remote-branch or checkout to a valid branch to update from"
	fi;
	
	if [[ "$*" == *"-i"* ]]; then
		echo "updating-from: $remote_branch [interactive rebase]"
		git pull origin $remote_branch --rebase=interactive
	else
		echo "updating-from: $remote_branch"
		git pull origin $remote_branch
	fi;
}

commit_and_run_experimental_workflow () {
	# experimental commit
	echo "commit message => EXP: $*"
	git cix $1

	run_experimental_workflow
}