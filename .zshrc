
source /root/zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /root/zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

eval "$(starship init zsh)"

function open() {
    if [[ -z "$1" ]]; then
        echo "Usage: open [path]"
        return 1
    fi
    nohup dolphin "$1" > /dev/null 2>&1 &
    disown
}

alias procs='procs -i TCP'
alias ll='lsd -al'
alias nvid='neovide'
alias vim='nvim'
# alias z='zoxide'

#alias vi='nvim'
alias -s go=vim
alias -s gd=vim
alias -s lua=vim
alias -s cpp=vim
alias -s c=vim
alias -s py=vim
alias -s gz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'



alias gpl='git pull'
alias gps='git push'
alias gs='git status'

alias cdg='cd ~/Documents/git'

alias s213='ssh -p 1022 root@vva.zhaolugame.com'
alias s137='ssh root@llcy.zhaolugame.com'
alias s199='ssh zhaolu@192.168.0.199'
alias s103='ssh zhaolu@192.168.0.103'
alias s238='ssh liuzujun@192.168.0.238'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    # echo 'dircolors exist'
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# GITSTATUS_LOG_LEVEL=DEBUG

alias setproxy="export ALL_PROXY=socks5://192.168.0.240:2334; echo 'SET PROXY SUCCESS!!!'"
alias unsetproxy="unset ALL_PROXY; echo 'UNSET PROXY SUCCESS!!!'"


export SHELL=/bin/zsh

export GOROOT=/usr/lib/go
export GOPATH=/home/saicom/go

export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# 引入 zoxide 配置
if [ -f ~/.zoxide.sh ]; then
    . ~/.zoxide.sh
fi



function fzf_make() {
  local makefile="Makefile"  # 默认的 Makefile 文件名
  local targets=()          # 用于存储 Makefile 中的目标

  # 检查当前目录中是否存在 Makefile 文件，如果有则使用之
  if [ -f "$makefile" ]; then
    #targets=($(awk -F':' '/^[a-zA-Z0-9][^:]*:/ {print $1}' "$makefile"))
	targets=($(awk -F'[:=]' '/^[a-zA-Z0-9][^#]*:/ && NF == 2 {gsub(/^[ \t]+|[ \t]+$/, "", $1); print $1}' "$makefile"))
  else
    echo "Makefile not found in the current directory."
    return 1
  fi

  if [ ${#targets[@]} -eq 0 ]; then
    echo "No Makefile targets found in $makefile."
    return 1
  fi

  # 使用 fzf 显示可选的目标并让用户选择
  local selected_target
  selected_target=$(printf "%s\n" "${targets[@]}" | fzf --header="Select a Makefile target:")

  if [ -z "$selected_target" ]; then
    echo "No target selected."
  else
    # 执行用户选择的 Makefile 目标
    make "$selected_target"
  fi
}

function fzf_file() {
    local file
    file=$(fzf --preview "cat {}" --preview-window=top:30%:wrap)

    # 检查用户是否选择了文件
    if [ -n "$file" ]; then
      local absolute_path
      absolute_path=$(realpath "$file")
      if [ -f "$absolute_path" ]; then
          cd "$(dirname "$absolute_path")"
          vim "$(basename "$absolute_path")"
          cd -q
      else
          echo "File not found: $file"
      fi
    else
        echo "No file selected."
    fi
}

function fzf_hist (){
    if [ $#LBUFFER -gt 0 ]; then
        BUFFER=$(history -n | awk '!seen [$0]++' | \
            fzf -e --reverse --no-sort --tac --border=rounded --height=50% --query $LBUFFER)
    else
        BUFFER=$(history -n | awk '!seen [$0]++' | \
            fzf -e --reverse --no-sort --tac --border=rounded --height=50%)
    fi
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N fzf_hist
bindkey '^r' fzf_hist

#broot安装
source /home/saicom/.config/broot/launcher/bash/br

# tmux continuum
#precmd() {
#  if [ -n "$TMUX" ]; then
#    eval "$(tmux show-environment -s)"
#    eval "$($HOME/.tmux/plugins/tmux-continuum/scripts/continuum_save.sh)"
#  fi
#
#  history -a
#}
#
#PROMPT_COMMAND=precmd
