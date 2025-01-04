bindkey '^[[1;9D' backward-kill-word      # ⌥+Delete (delete word to the left)
# bindkey '^[[1;10D' kill-word              # ⌥+Shift+Delete (delete word to the right)

# Move to the start/end of the line
bindkey '^[[1;5D' beginning-of-line  # Ctrl+←
bindkey '^[[1;5C' end-of-line        # Ctrl+→

# Delete all text to the left/right
bindkey '^[[3;5~' backward-kill-line   # Ctrl+Delete
bindkey '^[[3;6~' kill-line            # Ctrl+Shift+Delete
