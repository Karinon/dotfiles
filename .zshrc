# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/afast/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

#ZSH_THEME="dieter"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git fzf-tab zsh-autosuggestions cmd-status dircycle copypath sudo thefuck z fast-syntax-highlighting zsh-history-substring-search conda-zsh-completion)

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--height=50% --min-height=5 --color=light --layout=reverse --border'
#export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#  --color fg:240,bg:230,hl:33,fg+:241,bg+:221,hl+:33
#  --color info:33,prompt:33,pointer:166,marker:166,spinner:33'
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' fzf-min-height 10

alias nvim=$HOME/Programme/nvim.appimage
alias vim=nvim

source $ZSH/oh-my-zsh.sh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export BAT_THEME='GitHub'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/afast/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/afast/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/afast/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/afast/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export ORACLE_HOME=/home/afast/Programme/instantclient_19_6
export OCI_LIB_DIR=/home/afast/Programme/instantclient_19_6
export OCI_INC_DIR=/home/afast/Programme/instantclient_19_6/sdk/include

alias stext='grep -rinI --exclude-dir={.svn,node_modules,.git,ui-dist,serve-dist}'
alias bingrep='grep --byte-offset --only-matching --text'
alias killnode='kill -9 $(ss -ltpn | grep 3500 | awk "{print $6}" | sed "s/.*,pid=\(.*\),.*/\1/")'
alias dtop=lazydocker
export LD_LIBRARY_PATH=/usr/local/lib:/home/afast/Programme/instantclient_19_6/:$LD_LIBRARY_PATH

export PATH=/home/afast/Programme/node-v20.12.2-linux-x64/bin:/home/afast/Programme/jdk-15.0.2/bin:$HOME/.fzf/bin:$PATH
# export PATH=/home/afast/Programme/node-v16.15.1-linux-x64/bin:/home/afast/Programme/jdk-15.0.2/bin:$HOME/.fzf/bin:$PATH

mtext() {
  stext -oP ".{0,50}$1.{0,50}"
}

killdev() {
 pkill -f "OracleIdeLauncher"
}

hexvim() {
  nvim <(xxd $1)
}

alias vimdiff='nvim -d'

hexvimdiff() {
  vimdiff <(xxd $1) <(xxd $2)
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


list_env() {
  local var
  var=$(printenv | cut -d= -f1 | sort | fzf --preview 'printenv {}' ) && echo "$var=${(P)var}"
}

export PATH=$PATH:$HOME/minio-binaries/:$HOME/Programme/bin

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/afast/minio-binaries/mc mc



#ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#forward-char}")
#ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#vi-forward-char}")
#
## Add forward-char widgets to PARTIAL_ACCEPT
#ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char)
#ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(vi-forward-char)
#
## Add custom widget to complete partial if cursor is at end of buffer
#autosuggest_partial_wordwise () {   
#if [[ $CURSOR -lt ${#BUFFER} && $KEYMAP != vicmd ||
#      $CURSOR -lt $((${#BUFFER} - 1)) ]]; then
## if cursor is at end of buffer invoke forward-word widget
#    zle forward-word
#else
## if cursor is not at end of buffer invoke forward-char widget
#    zle forward-char
#fi
#}
#zle -N autosuggest_partial_wordwise 
#bindkey "${terminfo[kcuf1]}" autosuggest_partial_wordwise

# Add autosuggest_partial_wordwise to IGNORE
#ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(autosuggest_partial_wordwise)
#
#ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#forward-char}")
#ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#vi-forward-char}")
#
## Add "forward-char" widgets to "PARTIAL_ACCEPT".
#ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char)
#ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(vi-forward-char)
#
## Add a custom widget to complete partially.
#autosuggest_partial_charwise() {
#    zle forward-char
#}
#
#zle -N autosuggest_partial_charwise 
#bindkey "${terminfo[kcuf1]}" autosuggest_partial_charwise
#
## Add "autosuggest_partial_charwise" to "IGNORE".
#ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(autosuggest_partial_charwise)


bindkey '^N' forward-word
bindkey '^P' backward-word
bindkey '^F' autosuggest-accept


# shellcheck disable=SC2034,SC2153,SC2086,SC2155

# Above line is because shellcheck doesn't support zsh, per
# https://github.com/koalaman/shellcheck/wiki/SC1071, and the ignore: param in
# ludeeus/action-shellcheck only supports _directories_, not _files_. So
# instead, we manually add any error the shellcheck step finds in the file to
# the above line ...

# Source this in your ~/.zshrc
autoload -U add-zsh-hook

export ATUIN_SESSION=$(atuin uuid)
export ATUIN_HISTORY="atuin history list"

_atuin_preexec() {
    local id
    id=$(atuin history start -- "$1")
    export ATUIN_HISTORY_ID="$id"
}

_atuin_precmd() {
    local EXIT="$?"

    [[ -z "${ATUIN_HISTORY_ID:-}" ]] && return

    (RUST_LOG=error atuin history end --exit $EXIT -- $ATUIN_HISTORY_ID &) >/dev/null 2>&1
}

_atuin_search() {
    emulate -L zsh
    zle -I

    # Switch to cursor mode, then back to application
    echoti rmkx
    # swap stderr and stdout, so that the tui stuff works
    # TODO: not this
    # shellcheck disable=SC2048
    output=$(RUST_LOG=error atuin search $* -i -- $BUFFER 3>&1 1>&2 2>&3)
    echoti smkx

    if [[ -n $output ]]; then
        RBUFFER=""
        LBUFFER=$output
    fi

    zle reset-prompt
}

_atuin_up_search() {
    _atuin_search --shell-up-key-binding
}

add-zsh-hook preexec _atuin_preexec
add-zsh-hook precmd _atuin_precmd

zle -N _atuin_search_widget _atuin_search
zle -N _atuin_up_search_widget _atuin_up_search

bindkey '^r' _atuin_search_widget

setopt NO_HUP
setopt nocheckjobs

bindkey '^[[A' _atuin_up_search_widget
#bindkey '^[OA' _atuin_up_search_widget
#

grim() {
    local search_string="$1"
    local result

    result=$(rg -i -l "$search_string" | fzf --preview "echo {} && rg -i -C 5 --line-number --color always \"$search_string\" {}")

    if [[ -n "$result" ]]; then
        vim "$result"
    fi
}

#ssh() {
#    # Save the current tmux window name
#    #original_name=$(tmux display-message -p "#{window_name}")
#
#    # Extract the connect string (the last argument to ssh)
#    connect_string="${@: -1}"
#
#    # Extract just the server name (remove the user@ part if present)
#    server_name=$(echo "$connect_string" | sed 's/.*@//')
#
#    # Rename the tmux window with the server name
#    tmux rename-window "🖥 $server_name"
#
#    # Run the ssh command
#    command ssh "$@"
#
#    # Rename the window back to its original name after ssh ends
#    tmux setw automatic-rename
#    #tmux rename-window "$original_name"
#    #tmux rename-window "🖥 $*"
#    #command ssh "$@"
#}

alias n='function _vimnewest() { suffix="$1"; if [ -n "$suffix" ]; then vim "$(ls -pt | rg -v / | rg "$suffix$" | head -1)"; else vim "$(ls -pt | rg -v / | head -1)"; fi; }; _vimnewest'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

eval "$(atuin init zsh --disable-up-arrow)"

# pnpm
export PNPM_HOME="/home/afast/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
