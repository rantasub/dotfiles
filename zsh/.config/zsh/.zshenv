# XDG Base Directories
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_CACHE_HOME=~/.cache

# Configuration of programs running without an X session
export LESSHISTFILE=/dev/null
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"
export ELINKS_CONFDIR="${XDG_DATA_HOME}/elinks"
export PASSWORD_STORE_DIR=~/Passwörter

# Standard programs
export EDITOR=nvim
export VISUAL=nvim

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent TTY in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null
