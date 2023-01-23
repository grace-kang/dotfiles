export M2_HOME=/usr/local/apache-maven/apache-maven-3.8.2
export M2=$M2_HOME/bin
export MAVEN_OPTS="-Xms256m -Xmx512m"
export PATH=$M2:$PATH 

alias rake='noglob bundled_rake'
alias be='bundle exec'
alias tmux='tmux -2'
alias prtsc='xfce4-screenshooter --region -s ~/screenshots'

alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'

alias sladmin='java -jar ~/saaslink-admin-cli.jar -cfg /keybase/team/saaslink/env/dev_integrations.yml'

alias gco='git checkout'

bindkey -v

eval "$(direnv hook zsh)"

function history-search-end {
integer ocursor=$CURSOR

if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
	# Last widget called set $hbs_pos.
	CURSOR=$hbs_pos
else
	hbs_pos=$CURSOR
fi

if zle .${WIDGET%-end}; then
	# success, go to end of line
	zle .end-of-line
else
	# failure, restore position
	CURSOR=$ocursor
	return 1
fi
}


zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# History Substring Search
source $HOME/.zsh/vendor/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=black,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=black,bold'

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '[%b]'
setopt PROMPT_SUBST

PS1='%F{213}%n%f@%F{147}%m%f:%F{224}%~%f$%F{189}${vcs_info_msg_0_}%f $ '

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
