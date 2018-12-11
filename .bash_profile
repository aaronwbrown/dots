# Nav Alias
#
# Folders
alias root='cd ~'

# Workflow
alias gh='history | grep '                                            # pipes bash history into grep for command entry USAGE: gh redis

#NGINX
alias ngconf='sudo webstorm /usr/local/etc/nginx/nginx.conf'            # opens nginx conf in ide
alias ngstart='sudo nginx'                                              # starts nginx
alias ngstop='sudo nginx -s stop'                                      # stops nginx

# Workflow Functions
git_delete () {
    git branch | grep $1 | xargs git branch -D
}
gri () {
    git rebase -i HEAD~$1
}
rmrfy () {
    git co $1 && rm -rf && yarn && yb
}

# User profiles
export DOCKER_ID_USER="aaronwbrown"
# My bash profile :)
# System stuff
alias cp='cp -iv'                                                     # Preferred 'cp' implementation
alias mv='mv -iv'                                                     # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                                               # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                                                 # Preferred 'ls' implementation
alias less='less -FSRXc'                                              # Preferred 'less' implementation
cd() { builtin cd "$@"; ll; }                                         # Always list directory contents upon 'cd'
alias cd..='cd ../'                                                   # Go back 1 directory level (for fast typers)
alias ..='cd ../'                                                     # Go back 1 directory level
alias ...='cd ../../'                                                 # Go back 2 directory levels
alias .3='cd ../../../'                                               # Go back 3 directory levels
alias .4='cd ../../../../'                                            # Go back 4 directory levels
alias .5='cd ../../../../../'                                         # Go back 5 directory levels
alias .6='cd ../../../../../../'                                      # Go back 6 directory levels
alias f='open -a Finder ./'                                           # f:            Opens current directory in Ma$
alias ~="cd ~"                                                        # ~:            Go Home
alias c='clear'                                                       # c:            Clear terminal display
alias which='type -all'                                               # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'                                   # path:         Echo all executable Paths
alias show_options='shopt'                                            # Show_options: display bash options settings
alias fix_stty='stty sane'                                            # fix_stty:     Restore terminal settings whe$
alias cic='set completion-ignore-case On'                             # cic:          Make tab-completion case-inse$
mcd () { mkdir -p "$1" && cd "$1"; }                                  # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }                               # trash:        Moves a file to the MacOS tra$
ql () { qlmanage -p "$*" >& /dev/null; }                              # ql:           Opens any file in MacOS Quick$
alias DT='tee ~/Desktop/terminalOut.txt'                              # DT:           Pipe content to file on MacOS$

#DOCKER STUFF
alias de="env | grep DOCKER_"                                         # Get docker environment detail
function dm-env() {                                                   # Set docker eval environment
  eval "$(docker-machine env "${1:-default}")"
}
alias dm-list="docker-machine ls"                                     # List docker machines
function docker-clean() {                                             # Remove all images
  docker rmi -f $(docker images -q -a -f dangling=true)
}
function docker-stop-containers() {                                   # Stop all containers
  docker stop $(docker ps -a -q)
}
function docker-clean-containers() {                                  # Remove all containers
  docker rm $(docker ps -a -q)
}
function docker-rm() {                                                # Remove container
  docker rm "${}"
}
alias dcb="docker-compose build"                                      # Docker compose build
alias dcu="docker-compose up"                                         # Docker compose up
alias dcd="docker-compose down"                                       # Docker compose down
alias dcda="docker-compose down --rmi all --volumes"                  # Stop and remove all images, containers, and volumes
alias dil="docker images"                                             # Get list of docker images
alias dcl="docker ps -a"                                              # Get list of all containers

### PROMPT
# increase the history file size to 20,000 lines
export HISTSIZE=20000
# append all commands to the history file, don't overwrite it at the start of every new session
shopt -s histappend
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Configure colors, if available.
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    c_reset='\[\e[0m\]'
    c_user='\[\e[0;32m\]'
    c_path='\[\e[1;34m\]'
    c_git_clean='\[\e[0;37m\]'
    c_git_staged='\[\e[0;32m\]'
    c_git_unstaged='\[\e[0;31m\]'
else
    c_reset=
    c_user=
    c_path=
    c_git_clean=
    c_git_staged=
    c_git_unstaged=
fi
# Add the titlebar information when it is supported.
case $TERM in
xterm*|rxvt*)
    TITLEBAR='\[\e]0;\u@\h: \w\a\]';
    ;;
*)
    TITLEBAR="";
    ;;
esac

# Function to assemble the Git parsingart of our prompt.
git_prompt ()
{
    GIT_DIR=`git rev-parse --git-dir 2>/dev/null`
    if [ -z "$GIT_DIR" ]; then
        return 0
    fi
    GIT_HEAD=`cat $GIT_DIR/HEAD`
    GIT_BRANCH=${GIT_HEAD##*/}
    if [ ${#GIT_BRANCH} -eq 40 ]; then
        GIT_BRANCH="(no branch)"
    fi
    STATUS=`git status --porcelain`
    if [ -z "$STATUS" ]; then
        git_color="${c_git_clean}"
    else
        echo -e "$STATUS" | grep -q '^ [A-Z\?]'
        if [ $? -eq 0 ]; then
            git_color="${c_git_unstaged}"
        else
            git_color="${c_git_staged}"
        fi
    fi
    echo "[$git_color$GIT_BRANCH$c_reset]"
}

# git autocomplete with bash-completion

source /usr/local/git/contrib/completion/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='[\u@mbp \w$(__git_ps1)]\$ '

# Thy holy prompt.
#PROMPT_COMMAND="$PROMPT_COMMAND PS1=\"${TITLEBAR}${c_user}\u${c_reset}@${c_user}\h${c_reset}:${c_path}\w${c_reset}\$(git_prompt)\$ \" ;"
PROMPT_COMMAND="$PROMPT_COMMAND PS1=\"\n${TITLEBAR}${c_user}\u${c_reset}@${c_user}\h${c_reset}:${c_path}\w${c_reset}\$(git_prompt)\$ \" ;"
# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'
