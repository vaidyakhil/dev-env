SSH_CONFIG_PATH="$HOME/.ssh/config"

PERSONAL_IDENTITY_PATH="$HOME/.ssh/id_ed25519_personal"
OPTION_PERSONAL_IDENTITY="personal"

WORK_IDENTITY_PATH="$HOME/.ssh/id_ed25519"
OPTION_WORK_IDENTITY="work"

function set_github_identity() {
	sed -i "" "s,IdentityFile .*,IdentityFile $1," ${SSH_CONFIG_PATH}
	ssh-add $1
	echo "git identity switched to: $1";
}

function switch_github_identity() {
	final_identity_path="null"
	if [ "$1" != "" ]
		then
		if [ "$1" = "$OPTION_PERSONAL_IDENTITY" ]
			then
				final_identity_path="$PERSONAL_IDENTITY_PATH"
		elif [ "$1" = "$OPTION_WORK_IDENTITY" ]
			then
				final_identity_path="$WORK_IDENTITY_PATH"
		else
			echo ">>> invalid identity requested"
			return
		fi
	else
		initial_identity_path=`awk '/IdentityFile/ {print $2}' ${SSH_CONFIG_PATH}`
		if [ "$initial_identity_path" = "$PERSONAL_IDENTITY_PATH" ]
			then
			final_identity_path="$WORK_IDENTITY_PATH"
		elif [ "$initial_identity_path" = "$WORK_IDENTITY_PATH" ]
			then
				final_identity_path="$PERSONAL_IDENTITY_PATH"
		else
			echo ">>> error: invalid identity is set; please check in $SSH_CONFIG_PATH"
			return
		fi
	fi

	set_github_identity $final_identity_path
}
		