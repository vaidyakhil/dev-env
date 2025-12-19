#!/bin/bash

#===============================================================================
# Bootstrap Script for macOS Development Environment
#===============================================================================
#
# This script orchestrates modular bootstrap steps for setting up a development
# environment. Each module is a separate script that implements:
#
#   - show_help()  : Display module-specific help
#   - bootstrap()  : Run the module's setup logic
#
# Usage:
#   ./bootstrap.sh              # Run all enabled modules
#   ./bootstrap.sh --help       # Show help for all modules
#   ./bootstrap.sh --list       # List available modules
#
# Adding a new bootstrap module:
#   1. Create a folder: <module_name>/
#   2. Create bootstrap script: <module_name>/bootstrap.sh
#   3. Implement show_help() and bootstrap() functions
#   4. Add module to MODULES array below
#
#===============================================================================

set -e

#-------------------------------------------------------------------------------
# Configuration
#-------------------------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/bootstrap_backup"

# Modules to run (order matters)
# Add new modules here as they are created
MODULES=(
    "editors"
    # "git"
    # "shell"
)

#-------------------------------------------------------------------------------
# Utilities: Logging
#-------------------------------------------------------------------------------

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }
log_section() { echo -e "\n${CYAN}━━━ $1 ━━━${NC}\n"; }

#-------------------------------------------------------------------------------
# Utilities: Helpers (available to all modules)
#-------------------------------------------------------------------------------

command_exists() { command -v "$1" >/dev/null 2>&1; }

create_symlink() {
    local source=$1 target=$2 name=$3

    [[ -e "$target" ]] && rm "$target" && log_info "Removed existing $name"
    mkdir -p "$(dirname "$target")"
    ln -s "$source" "$target"
    log_success "Symlinked $name"
}

backup_file() {
    local source=$1 dest=$2
    if [[ -f "$source" ]]; then
        mkdir -p "$(dirname "$dest")"
        cp "$source" "$dest"
        log_success "Backed up $(basename "$source")"
        return 0
    fi
    return 1
}

#-------------------------------------------------------------------------------
# Module Loader
#-------------------------------------------------------------------------------

load_module() {
    local module=$1
    local module_script="$SCRIPT_DIR/$module/bootstrap.sh"

    if [[ ! -f "$module_script" ]]; then
        log_error "Module '$module' not found at: $module_script"
        return 1
    fi

    # Source the module (imports its functions)
    source "$module_script"
}

run_module() {
    local module=$1

    # Clear previous module's functions
    unset -f show_help bootstrap 2>/dev/null || true

    load_module "$module" || return 1

    # Verify module implements required interface
    if ! declare -f bootstrap >/dev/null; then
        log_error "Module '$module' missing required function: bootstrap()"
        return 1
    fi

    # Run the module's bootstrap
    bootstrap
}

show_module_help() {
    local module=$1

    # Clear previous module's functions
    unset -f show_help bootstrap 2>/dev/null || true

    load_module "$module" || return 1

    if declare -f show_help >/dev/null; then
        show_help
    else
        echo "  $module: (no help available)"
    fi
}

#-------------------------------------------------------------------------------
# Main Commands
#-------------------------------------------------------------------------------

cmd_help() {
    echo "Usage: $(basename "$0") [command]"
    echo
    echo "Bootstrap script for macOS development environment setup."
    echo
    echo "Commands:"
    echo "  (none)    Run all enabled bootstrap modules"
    echo "  --help    Show this help message"
    echo "  --list    List available modules"
    echo
    echo "Modules:"
    for module in "${MODULES[@]}"; do
        show_module_help "$module"
    done
    echo
    echo "Backups are stored in: $BACKUP_DIR/"
}

cmd_list() {
    echo "Available modules:"
    for module in "${MODULES[@]}"; do
        local module_script="$SCRIPT_DIR/$module/bootstrap.sh"
        if [[ -f "$module_script" ]]; then
            echo "  ✓ $module"
        else
            echo "  ✗ $module (missing: $module/bootstrap.sh)"
        fi
    done
}

cmd_run() {
    echo
    log_info "Starting bootstrap setup..."
    mkdir -p "$BACKUP_DIR"

    local failed=0
    for module in "${MODULES[@]}"; do
        if ! run_module "$module"; then
            log_error "Module '$module' failed"
            ((failed++))
        fi
    done

    log_section "Summary"
    echo "  Modules run:  ${#MODULES[@]}"
    echo "  Failed:       $failed"
    echo "  Backups:      $BACKUP_DIR/"
    echo

    if [[ $failed -eq 0 ]]; then
        log_success "Bootstrap completed!"
    else
        log_error "Bootstrap completed with $failed error(s)"
        exit 1
    fi
}

#-------------------------------------------------------------------------------
# Entry Point
#-------------------------------------------------------------------------------

main() {
    case "${1:-}" in
        --help|-h)
            cmd_help
            ;;
        --list|-l)
            cmd_list
            ;;
        *)
            cmd_run
            ;;
    esac
}

main "$@"
