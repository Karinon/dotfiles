#!/bin/zsh
HOME=/home/afast
window_id=$(wmctrl -l | grep "[N]VIM DESKTOP" | cut -d' ' -f1)
if [ -n "$window_id" ]; then
  NVR=$HOME/miniconda3/bin/nvr
	$NVR --remote $@
  xdotool windowactivate "$window_id" 
else
  source $HOME/.zshrc
  NVIM=$HOME/Programme/nvim.appimage
  ICON=$HOME/Programme/shellscripte/nvim-icon.png
  SOCKET=/tmp/nvimsocket
	# If not running, start nvim-qt with a server and an argument
  wmctrl -r :ACTIVE: -b toggle,maximized_vert,maximized_horz
	xseticon -id $WINDOWID $ICON
	$NVIM -c "set titlestring=NVIM\ DESKTOP\ \-\ %t" --listen $SOCKET $@
fi
