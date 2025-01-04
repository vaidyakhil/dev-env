export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export PATH="/Applications/Android Studio.app/Contents/jbr/Contents/Home/bin:$PATH"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$HOME/Library/Android/sdk/emulator:$PATH"

# flashlight
export PATH="$HOME/.flashlight/bin:$PATH"
-
# custom java installations
JAVA_17_ANDROID_FLAMINGO="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
JAVA_11_AZUL="$HOME/Library/Java/JavaVirtualMachines/azul-it 11.0.21/Contents/Home"
JAVA_11_OPEN_LOGIC="$HOME/Library/Java/JavaVirtualMachines/openlogic-openjdk-11.jdk/Contents/Home"
export JAVA_HOME=$JAVA_17_ANDROID_FLAMINGO

# ensure to have `/bin` after JAVA_HOME
export PATH="$JAVA_HOME/bin:$PATH"

# gcloud does not work well with versions greater than certain version of python-3
# so forcing it to use system python instead of user installed  python3
export CLOUDSDK_PYTHON="/usr/bin/python3"

# maestro
export PATH=$PATH:$HOME/.maestro/bin

# ------------------
#region jarvis-experimentation

# export PATH="$HOME/personal/command-line-assistant/jarvis.sh:$PATH"
# export PATH="$HOME/bin:$PATH"
export PATH="$HOME/personal/command-line-assistant/bin:$PATH"
# alias jarvis="chmod +x ~/personal/command-line-assistant/jarvis.sh && source ~/personal/command-line-assistant/jarvis.sh"

#endregion jarvis-experimentation
# ------------------

