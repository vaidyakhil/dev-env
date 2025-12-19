export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export PATH="/Applications/Android Studio.app/Contents/jbr/Contents/Home/bin:$PATH"

export ANDROID_HOME="$HOME/android_sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"

# flashlight
export PATH="$HOME/.flashlight/bin:$PATH"
-
# custom java installations
# JAVA_17_ANDROID_FLAMINGO="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
JAVA_17__OPEN_JDK="/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home"
export JAVA_HOME=$JAVA_17__OPEN_JDK

# ensure to have `/bin` after JAVA_HOME
export PATH="$JAVA_HOME/bin:$PATH"

# maestro
export PATH=$PATH:$HOME/.maestro/bin

# gcloud does not work well with versions greater than certain version of python-3
# so forcing it to use system python instead of user installed  python3
# export CLOUDSDK_PYTHON="/usr/bin/python3"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/akhil.vaidya/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/akhil.vaidya/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/akhil.vaidya/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/akhil.vaidya/google-cloud-sdk/completion.zsh.inc'; fi

# ------------------
#region jarvis-experimentation

# export PATH="$HOME/personal/command-line-assistant/jarvis.sh:$PATH"
# export PATH="$HOME/bin:$PATH"
export PATH="$HOME/personal/command-line-assistant/bin:$PATH"
# alias jarvis="chmod +x ~/personal/command-line-assistant/jarvis.sh && source ~/personal/command-line-assistant/jarvis.sh"

#endregion jarvis-experimentation
# ------------------