alias sba='source ~/.bash_aliases'
alias sshSetup='eval `ssh-agent -s` && eval `$(ssh-add -s)` && ssh-add ~/.ssh/athena-ubu-github'
alias python='python3'
alias pip='pip3'
alias nv='nvim'

activate_venv() {
    # Assumes it's run in the directory above the venv direcory
    if [ -d venv ]; then
        sed -i 's/\r$//' ./venv/Scripts/activate
        ./venv/Scripts/activate
    elif [-d ./Scripts]; then
        sed -i 's/\r$//' ./Scripts/activate
        ./Scripts/activate
    fi
}

wh() {
    windows_home='/mnt/c/Users/bryce'
    if [ "$1" = "-p" ];
    then
        echo $windows_home
    else
        cd $windows_home
    fi
}

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

#auto_venv 
#

new_repo() {
    echo "# $1" >> README.md
    git init
    git add README.md
    git commit -m "first commit"
    git branch -M main
    git remote add origin "https://github.com/bkburgess/$1.git"
    git push -u origin main
}

git_setup() {
    git init
    touch README.md
    git branch -M main
    git add . && git commit -m "initial commit"
    git remote add origin https://github.com/bkburgess/$1.git
    git remote set-url origin git@github.com:bkburgess/$1.git
    git push -u origin main
}
