# Setup fzf
# ---------
if [[ ! "$PATH" == */home/grace/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/grace/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/grace/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/grace/.fzf/shell/key-bindings.zsh"
