if status is-interactive; and not set -q "YAZI_ID" 
    fastfetch
end

set -g fish_greeting ""
set -g fish_key_bindings fish_vi_key_bindings
set -gx EDITOR nvim

abbr -a .. cd ..
abbr -a ... cd ../..

abbr -a ls eza --color=always --group-directories-first --icons
abbr -a ll eza -la --icons --octal-permissions --group-directories-first

abbr -a :q exit
abbr -a v nvim

abbr -a asus ssh nurlan@asus.local
abbr -a mac ssh nurlan@macbook.local
abbr -a mini ssh nurlan@macmini.local
abbr -a rog ssh nurlan@rog.local
abbr -a rpi ssh nurlan@rpi.local
abbr -a work ssh work

abbr -a lg lazygit
abbr -a ga git add
abbr -a gc git commit -m
abbr -a gd git diff -M
abbr -a gl git pull
abbr -a gp git push
abbr -a gs git status
abbr -a gac 'git add . && git commit -m'
abbr -a gst git stash
abbr -a gu 'cd ~/mydotfiles && git pull'

abbr - texlive 'xhost +si:localuser:root && sudo /usr/local/texlive/2026/bin/x86_64-linux/tlmgr --gui && xhost -si:localuser:root'

# Yazi helper
function y
  if test -n "$YAZI_LEVEL" 
    exit
    return 0
  end
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	command rm -f -- "$tmp"
end

# Change Yazi's CWD to PWD on subshell exit
if [ -n "$YAZI_ID" ]
	trap 'ya emit cd "$PWD"' EXIT
end
