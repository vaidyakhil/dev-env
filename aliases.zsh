# custom aliases
# e.g alias asd="java -version"

alias adb-reverse="adb reverse tcp:8081  tcp:8081"
alias rmdd="rm -rf ~/Library/Developer/Xcode/DerivedData"
alias studio="open -a /Applications/Android\ Studio.app/Contents/MacOS/studio"
alias rdt="react-devtools"

alias siml="xcrun simctl boot testing_simulator && open -a Simulator"
alias eml="emulator -avd testing_emulator_api_level_35 -no-snapshot -noaudio -no-boot-anim"

# cmd line tools
alias -g ...='../..'
alias -g ....="../../.."
alias -g .....="../../../.."
alias lgrep="source $ZSH/custom/commands.sh && list_dir_and_grep_exp $*"
alias now="echo -n \$(date \"+%d %b %Y [%a, %I:%M %p]\") | tee >(pbcopy)"

# work-personal dev aliases
alias swgit="source $ZSH/custom/vcs_stuff/git_identity_switch.sh && switch_github_identity"
alias gitsw="swgit"
alias pmode="gitsw personal && cd $HOME/personal"
alias wmode="gitsw work && cd $HOME/work"
alias pref="cursor $ZSH/custom"

# projects specific
LUCIFER_PATH=$HOME/work/lucifer
CLONE_LUCIFER_PATH=$HOME/work/clone_lucifer

alias cdl="cd $LUCIFER_PATH"
alias stdl="open -a /Applications/Android\ Studio.app/Contents/MacOS/studio $LUCIFER_PATH/android"
alias xdl="open $LUCIFER_PATH/ios/GrowwApp.xcworkspace"

alias cdcl="cd $CLONE_LUCIFER_PATH"
alias stdcl="open -a /Applications/Android\ Studio.app/Contents/MacOS/studio $CLONE_LUCIFER_PATH/android"
alias xdcl="open $CLONE_LUCIFER_PATH/ios/GrowwApp.xcworkspace"

alias cdpl="$HOME/work/other_groww_repos/code-push-cli/bin/cli.js"

# can add support for android and env later
IOS_SIML_IDENTIFIER="testing_simulator"
APP_IDENTIFIER="com.nextbillion.groww"
alias iop="xcrun simctl terminate $IOS_SIML_IDENTIFIER $APP_IDENTIFIER; xcrun simctl launch $IOS_SIML_IDENTIFIER $APP_IDENTIFIER"

# trying out blocking infinite scrolling websites
alias swfocus="source $ZSH/custom/commands.sh && toggle_focus_dev_mode"
alias focusw="source $ZSH/custom/commands.sh && toggle_focus_dev_mode"