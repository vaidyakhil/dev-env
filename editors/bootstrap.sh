#!/bin/bash

#===============================================================================
# Bootstrap Module: Editors (VSCode, Cursor)
#===============================================================================
#
# This module sets up editor configurations by symlinking custom keybindings
# and tasks files.
#
# Required functions (module interface):
#   - show_help   : Display help for this module
#   - bootstrap   : Run the bootstrap logic
#
#===============================================================================

MODULE_NAME="editors"

# macOS config paths
VSCODE_CONFIG="$HOME/Library/Application Support/Code/User"
CURSOR_CONFIG="$HOME/Library/Application Support/Cursor/User"

#-------------------------------------------------------------------------------
# Module Interface
#-------------------------------------------------------------------------------

show_help() {
    echo "  ${MODULE_NAME}:"
    echo "    Symlinks custom keybindings.json and tasks.json for VSCode and Cursor."
    echo "    Configs are read from: \$SCRIPT_DIR/editors/{vscode,cursor}/"
}

bootstrap() {
    log_section "Editors"
    setup_editor "vscode" "code" "$VSCODE_CONFIG"
    setup_editor "cursor" "cursor" "$CURSOR_CONFIG"
}

#-------------------------------------------------------------------------------
# Internal Functions
#-------------------------------------------------------------------------------

setup_editor() {
    local editor=$1 binary=$2 config_path=$3
    local module_dir="$SCRIPT_DIR/editors"

    log_info "Setting up $editor..."

    if ! command_exists "$binary"; then
        log_warning "$editor not installed (binary '$binary' not found). Skipping."
        return 0
    fi
    log_success "$editor is installed"

    local custom_keybindings="$module_dir/$editor/keybindings.json"
    local custom_tasks="$module_dir/$editor/tasks.json"

    if [[ ! -f "$custom_keybindings" && ! -f "$custom_tasks" ]]; then
        log_warning "No custom configurations found for $editor. Skipping."
        return 0
    fi

    # Backup existing configs
    local backup_path="$BACKUP_DIR/editors/$editor"
    backup_file "$config_path/keybindings.json" "$backup_path/keybindings.json.backup"
    backup_file "$config_path/tasks.json" "$backup_path/tasks.json.backup"

    # Create symlinks
    [[ -f "$custom_keybindings" ]] && create_symlink "$custom_keybindings" "$config_path/keybindings.json" "keybindings.json"
    [[ -f "$custom_tasks" ]] && create_symlink "$custom_tasks" "$config_path/tasks.json" "tasks.json"

    log_success "$editor setup completed!"
}

