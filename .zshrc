setopt PROMPT_SUBST

autoload -U add-zsh-hook

auto_venv() {
    local target_venv=""
    
    # Find .venv in current or parent directories
    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/.venv/bin/activate" ]]; then
            target_venv="$dir/.venv"
            break
        fi
        dir="${dir:h}"
    done
    
    # Handle activation/deactivation
    if [[ -n "$target_venv" ]]; then
        [[ "$VIRTUAL_ENV" != "$target_venv" ]] && source "$target_venv/bin/activate"
    elif [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate 2>/dev/null
    fi
}

add-zsh-hook chpwd _auto_venv
_auto_venv 
