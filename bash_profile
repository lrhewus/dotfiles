# System-wide .bashrc file for interactive bash(1) shells.
if [ -n "$PS1" ]; then PS1='\h:\w \u\$ '; fi
# Make bash check it's window size after a process completes
shopt -s checkwinsize
alias vi=vim
PATH=$PATH:"~/Library/Enthought/Canopy_64bit/User/bin"
PATH=$PATH:"/Users/lisa/bin"
PATH="/usr/local/bin":$PATH
PATH=$PATH:"/usr/local/man"
PATH=$PATH:"/usr/local/sbin"
test -r /sw/bin/init.sh && . /sw/bin/init.sh
function _git_prompt() {
local _branch=`git branch --no-color 2> /dev/null | sed -ne 's/^* //p'`
[[ -z $_branch ]] && return
local _bgcolor
local _color
for s in `git status --porcelain | tr ' ' '.' | cut -c 1-2`; do
    if [ -z "$_color" ]; then
        case "$s" in
            ?D) _color='\e[35m' ;;
        ?M) _color='\e[36m' ;;
    \?\?) _color='\e[33m' ;;
esac
fi
if [ -z "$_bgcolor" ]; then
    case $s in
        A?) _bgcolor='\e[43m' ;;
    D?) _bgcolor='\e[41m' ;;
M?) _bgcolor='\e[44m' ;;
esac
fi
done
# Highligh it we haven't done a git pull today
local now=`date +%s`
local last_pull=0
local fetch_head=$( git rev-parse --show-toplevel )/.git/FETCH_HEAD
[ -e $fetch_head ] && last_pull=`stat -f %m $fetch_head`
age=$(( $now - $last_pull ))
if [ $age -gt 86400 ]; then
    _color='\x1b[5m'$_color
fi
_color=${_color:-'\e[32m'}
#_bgcolor=${_bgcolor:-'\e[42m'}
echo -en "\[\e[0m\]{\[$_bgcolor$_color\]${_branch}\[\e[0m\]}"
}
function prompt
{
    local WHITE="\[\033[1;37m\]"
    local GREEN="\[\033[0;32m\]"
    local CYAN="\[\033[0;36m\]"
    local GRAY="\[\033[0;37m\]"
    local BLUE="\[\033[0;34m\]"
    local VENV=""
    if [ "$VIRTUAL_ENV" ]; then
        VENV="($(basename $VIRTUAL_ENV)) "
    fi
    export PS1="[\h] ${GREEN}\u${CYAN} $(_git_prompt)${CYAN}\w${GRAY}${VENV}$ "
}
PROMPT_COMMAND=prompt
##
# Your previous /Users/lisa/.bash_profile file was backed up as /Users/lisa/.bash_profile.macports-saved_2010-03-28_at_17:56:27
##
# MacPorts Installer addition on 2010-03-28_at_17:56:27: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
export OLD_PATH=$PATH
# Setting PATH for Python 3.3
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.3/bin:${PATH}"
export PATH
# Settings for virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PATH="/usr/local/mysql/bin:$PATH"
# Settings for irssi notifications
irssi_notifier() {
    ssh lisa@us.holligan.net 'echo -n "" > ~/.irssi/fnotify; tail -f ~/.irssi/fnotify' | \
            while read heading message; do
            url=`echo \"$message\" | grep -Eo 'https?://[^ >]+' | head -1`;

            if [ ! "$url" ]; then
                terminal-notifier -title "\"$heading\"" -message "\"$message\"" -activate com.apple.Terminal;
            else
                terminal-notifier -title "\"$heading\"" -message "\"$message\"" -open "\"$url\"";
            fi;
        done
    }

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# startup virtualenv-burrito
if [ -f $HOME/.venvburrito/startup.sh ]; then
    . $HOME/.venvburrito/startup.sh
fi

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH
