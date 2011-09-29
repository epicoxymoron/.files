# epicoxymoron's theme
# parts inherited from muse, prose, dieter, and others

### UTILITY FUNCTIONS ###
	# show the colors available to the prompt
	function show_colors {
		for i in {1..255}
			do echo "[38;05;${i}mcolor = $i"
		done
	}

### GIT ###
	# Determines whether you're in a git repo or not
	function is_git() {
		if git rev-parse --git-dir > /dev/null 2>&1; then
			echo 1
		fi
	}

	# Formats prompt string for current git branch
	function git_prompt_branch() {
	  echo "$ZSH_THEME_GIT_PROMPT_BRANCH_BEFORE$(current_branch)$ZSH_THEME_GIT_PROMPT_BRANCH_AFTER"
	}

### MERCURIAL ###
	# Determines whether you're in an hg repo or not
	function is_hg() {
		if hg root &> /dev/null ; then
			echo 1
		fi
	}

	# Gets the name of the branch you're in
	function hg_branch() {
		echo $( hg branch 2> /dev/null)
	}
	
	# Formats the abbreviated sha hash of the latest commit
	function hg_prompt_short_sha() {
		sha=$( hg log --template "{node}" 2> /dev/null)
		echo "$ZSH_THEME_HG_PROMPT_SHA_PREFIX${sha[1,8]}$ZSH_THEME_HG_PROMPT_SHA_SUFFIX"
	}

	# determine if the hg repo is dirty or clean
	function parse_hg_dirty () {
		if [[ -n $( hg status 2> /dev/null) ]]; then
			echo "$ZSH_THEME_HG_PROMPT_DIRTY"
		else
			echo "$ZSH_THEME_HG_PROMPT_CLEAN"
		fi
	}

	# get the status of the working tree
	function hg_prompt_status() {
		INDEX=$( hg status 2> /dev/null)
		STATUS=""
		if $(echo "$INDEX" | grep '^? ' &> /dev/null); then
			STATUS="$ZSH_THEME_HG_PROMPT_UNTRACKED$STATUS"
		fi
		if $(echo "$INDEX" | grep '^A ' &> /dev/null); then
			STATUS="$ZSH_THEME_HG_PROMPT_ADDED$STATUS"
		fi
		if $(echo "$INDEX" | grep '^M ' &> /dev/null); then
			STATUS="$ZSH_THEME_HG_PROMPT_MODIFIED$STATUS"
		fi
		if $(echo "$INDEX" | grep '^R ' &> /dev/null); then
			STATUS="$ZSH_THEME_HG_PROMPT_DELETED$STATUS"
		fi
		if [[ -n $INDEX ]]; then
			STATUS="$ZSH_THEME_HG_PROMPT_DIRTY$STATUS"
		else
			STATUS="$ZSH_THEME_HG_PROMPT_CLEAN$STATUS"
		fi
		echo $STATUS
	}


# setting up some colors for later use
RED="$fg[red]"
YELLOW="$fg[yellow]"
GREEN="$fg[green]"
WHITE="$fg[white]"
YELLOW="$fg[yellow]"
PURPLE="[38;05;92m"
ORANGE="[38;05;208m"

# host part
host="%{$ORANGE%}%m%{$reset_color%}"

PS4='$(date "+%s.%N ($LINENO) + ")'

# user part, color coded by privileges
local user="%(!.%{$fg[red]%}.%{$fg[green]%})%n%{$reset_color%}"

ZSH_THEME_REPO_NAME_COLOR=
ZSH_THEME_SVN_PROMPT_PREFIX=
ZSH_THEME_SVN_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_SVN_PROMPT_DIRTY="%{$RED%}✹"
ZSH_THEME_SVN_PROMPT_CLEAN="%{$GREEN%}✹"

ZSH_THEME_GIT_PROMPT_PREFIX=
ZSH_THEME_GIT_PROMPT_SUFFIX=
ZSH_THEME_GIT_PROMPT_AHEAD=
ZSH_THEME_GIT_PROMPT_DIRTY="%{$RED%}✭%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$GREEN%}✭%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=
ZSH_THEME_GIT_PROMPT_SHA_AFTER=
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$RED%}M%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$RED%}D%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$YELLOW%}R%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$YELLOW%}M%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$GREEN%}A%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$WHITE%}T%{$reset_color%}"

ZSH_THEME_HG_PROMPT_PREFIX=
ZSH_THEME_HG_PROMPT_SUFFIX=
ZSH_THEME_HG_PROMPT_DIRTY="%{$RED%}✭%{$reset_color%}"
ZSH_THEME_HG_PROMPT_CLEAN="%{$GREEN%}✭%{$reset_color%}"
ZSH_THEME_HG_PROMPT_UNTRACKED="%{$WHITE%}T%{$reset_color%}"
ZSH_THEME_HG_PROMPT_ADDED="%{$GREEN%}A%{$reset_color%}"
ZSH_THEME_HG_PROMPT_MODIFIED="%{$YELLOW%}M%{$reset_color%}"
ZSH_THEME_HG_PROMPT_DELETE="%{$RED%}D%{$reset_color%}"

#git_prompt_long_sha
#git_prompt_short_sha
#git_prompt_status
#git_prompt_ahead
#git_prompt_info
#svn_prompt_info
#svn_get_repo_name
#svn_get_rev_nr

function vcs_prompt() {
	separator="%{$YELLOW%}::%{$reset_color%} "
	if [ $(is_git) ]
	then
		echo -n " %{$PURPLE%}[git"
		if [[ ! -z "$(current_branch)" ]]; then
			echo -n ":$(current_branch)"
		fi
		echo -n ":$(git_prompt_short_sha)"
		echo -n ":$(parse_git_dirty)"
		echo -n "$(git_prompt_status)"
		echo -n "%{$PURPLE%}]"
		echo "
$separator"
	elif [ $(is_hg) ]
	then
		echo -n " %{$PURPLE%}[hg"
		echo -n ":$(hg_branch)"
		echo -n ":$(hg_prompt_short_sha)"
		echo -n ":$(hg_prompt_status)"
		echo -n "%{$PURPLE%}]"
		echo "
$separator"
	elif [ $(in_svn) ]
	then
		echo -n " %{$PURPLE%}[svn"
		echo -n ":r$(svn_get_rev_nr)"
		echo -n ":$(svn_dirty)"
		echo -n "%{$PURPLE%}]"
		echo "
$separator"
	else
		echo " $separator"
	fi
}

function date() {
	echo $(php -r 'echo microtime();')
}

PROMPT='${user}@${host} %{$fg[cyan]%}%2~%{$reset_color%}$(vcs_prompt)'

# elaborate exitcode on the right when >0
return_code_enabled="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
return_code_disabled=
return_code=$return_code_enabled

RPS1='${return_code}'

function accept-line-or-clear-warning () {
	if [[ -z $BUFFER ]]; then
		return_code=$return_code_disabled
	else
		return_code=$return_code_enabled
	fi
	zle accept-line
}

zle -N accept-line-or-clear-warning
bindkey '^M' accept-line-or-clear-warning
