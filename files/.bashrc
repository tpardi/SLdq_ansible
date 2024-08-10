# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias D='convert2lowercase'
alias U='convert2uppercase'
alias hist='showhist'

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi
convert2lowercase () {
        # Take argument
        UPITY=`echo "$1" | tr '[:upper:]' '[:lower:]'`
        echo $UPITY
}
convert2uppercase () {
        LITTLE=`echo "$1" | tr '[:lower:]' '[:upper:]'`
        echo $LITTLE
}
showhist() {
    [ -z "$1" ] && { printf "usage:  hist <search term>\n"; return 1; }
    history | grep "$1"
    return 0
}

# Created by `pipx` on 2024-07-28 19:46:27
export PATH="$PATH:/root/.local/bin:/bin:/SYSADM/scripts"

