# custom aliases
# e.g alias asd="java -version"
alias adb-reverse="adb reverse tcp:8081  tcp:8081"
alias rmdd="rm -rf ~/Library/Developer/Xcode/DerivedData"
alias swgit="source $ZSH/custom/vcs_stuff/git_identity_switch.sh && switch_github_identity"
alias gitsw="swgit"
alias studio="open -a /Applications/Android\ Studio.app/Contents/MacOS/studio"
alias lgrep="source $ZSH/custom/commands.sh && list_dir_and_grep_exp $*"
alias swfocus="source $ZSH/custom/commands.sh && toggle_focus_dev_mode"
alias focusw="source $ZSH/custom/commands.sh && toggle_focus_dev_mode"
alias -g ...='../..'
alias -g ....="../../.."
alias -g .....="../../../.."
alias now="echo -n \$(date \"+%d %b %Y [%a, %I:%M %p]\") | tee >(pbcopy)"
alias pmode="gitsw personal && cd $HOME/personal"
alias wmode="gitsw work && cd $HOME/work"
alias nuke-prepare-ios="rm -rf node_modules && yarn; yarn && bundle install && cd ios && bundle exec pod install --clean-install"
alias pref="cursor $ZSH/custom"
alias siml="xcrun simctl boot testing_simulator && open -a Simulator"
alias eml="emulator -avd ui_test_device_api_level_32 -no-snapshot -noaudio -no-boot-anim -verbose"
# not working as of now
alias wd="cd $* && cursor \"$*\""

alias rdt="react-devtools"

# projects specific
LUCIFER_PATH=$HOME/work/lucifer
CLONE_LUCIFER_PATH=$HOME/work/clone_lucifer

alias cdl="cd $LUCIFER_PATH"
alias stdl="open -a /Applications/Android\ Studio.app/Contents/MacOS/studio $LUCIFER_PATH/android"
alias xdl="open $LUCIFER_PATH/ios/GrowwApp.xcworkspace"

alias cdcl="cd $CLONE_LUCIFER_PATH"
alias stdcl="open -a /Applications/Android\ Studio.app/Contents/MacOS/studio $CLONE_LUCIFER_PATH/android"
alias xdcl="open $CLONE_LUCIFER_PATH/ios/GrowwApp.xcworkspace"

alias cdpl="/Users/vaidyakhil/work/other_groww_repos/code-push-cli/bin/cli.js"

# can add support for android and env later
IOS_SIML_IDENTIFIER="testing_simulator"
APP_IDENTIFIER="com.nextbillion.groww"
alias iop="xcrun simctl terminate $IOS_SIML_IDENTIFIER $APP_IDENTIFIER; xcrun simctl launch $IOS_SIML_IDENTIFIER $APP_IDENTIFIER"