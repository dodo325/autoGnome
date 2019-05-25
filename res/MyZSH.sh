# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/dodo/.oh-my-zsh"

ZSH_THEME="powerlevel9k/powerlevel9k"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

export TERM="xterm-256color" 

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time anaconda virtualenv pyenv) #kubecontext docker_machine

POWERLEVEL9K_ANACONDA_BACKGROUND='green'



plugins=(
  git # https://github.com/robbyrussell/oh-my-zsh/wiki/Plugin:git
  django
  cp
  pip
  python
  pep8
  pyenv
  pylint
  sudo
  docker
  vscode
  pylint
  virtualenv
  ubuntu
  themes
  history
  zsh-syntax-highlighting
  web-search
  debian
  tmux
  urltools
)
apt_pref='apt'

ZSH_TMUX_AUTOSTART=false

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_RPROMPT_ON_NEWLINE=true


source $ZSH/oh-my-zsh.sh

#DEFAULT_USER="\ue286"

#prompt_context(){}

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment

export LANG=ru_RU.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias lsp='stat -c "%a %n" *'

alias locip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias myip='curl ipinfo.io/ip'
alias lsip='arp'
killport() { sudo lsof -t -i tcp:"$1" | xargs kill -9 ; }

gtts() { gtts-cli $1 | mpg123 - }


alias d2='source activate Django2'
alias dea='source deactivate'

# mini organaze:

mysort() {
   mkdir pdf; mv *.pdf pdf/;
   mkdir torrent; mv *.torrent torrent/;
   mkdir doc; mv *.doc* doc/;

   mkdir -p img; mv *.png img/;
   mkdir -p img; mv *.jpg img/;
   mkdir -p img; mv *.svg img/; 
   mkdir -p img; mv *.kra img/; 


   mkdir -p exe; mv *.exe exe/;
   mkdir -p deb; mv *.deb deb/;

   mkdir -p deb; mv *.deb deb/;

   mkdir -p zip; mv *.zip zip/;
   mkdir -p zip; mv *.7z zip/;
   mkdir -p zip; mv *.rar zip/;

   mkdir -p music; mv *.mp3 music/;
   
   rm *.crdownload;
   rm Thumbs.db*;
   rm *~;
   find . -empty -type d -delete;

}

# added by Anaconda3 5.3.1 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/dodo/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/dodo/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dodo/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/dodo/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<