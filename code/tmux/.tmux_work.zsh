#!/bin/zsh

firefox --new-tab "https://app.slack.com/client/T025ARX9E/D19PXDVCJ" --new-tab "https://mail.google.com/mail/u/0/#inbox" & disown

tmux new -s work -n admin -d
tmux send-keys -t work 'cd ~/workspace/admin && clear' C-m
tmux split-window -v
tmux send-keys -t work 'cd ~/workspace/admin && clear' C-m
tmux send-keys -t work 'bin/start' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/admin && clear' C-m
tmux resize-pane -D 7
tmux select-pane -t 1

tmux new-window -t work -n estetix
tmux send-keys -t work 'cd ~/workspace/estetix && clear' C-m
tmux split-window -v
tmux send-keys -t work 'cd ~/workspace/estetix && clear' C-m
tmux send-keys -t work 'bin/start' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/estetix && clear' C-m
tmux resize-pane -D 7
tmux select-pane -t 1

tmux new-window -t work -n crisalix
tmux send-keys -t work 'cd ~/workspace/crisalix && clear' C-m
tmux split-window -v
tmux send-keys -t work 'cd ~/workspace/crisalix && clear' C-m
tmux send-keys -t work 'rs -p 3005' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/crisalix && clear' C-m
tmux resize-pane -D 7
tmux select-pane -t 1

tmux new-window -t work -n sso
tmux send-keys -t work 'cd ~/workspace/SSO && clear' C-m
tmux split-window -v
tmux send-keys -t work 'cd ~/workspace/SSO && clear' C-m
tmux send-keys -t work 'rs -p 3007' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/SSO && clear' C-m
tmux resize-pane -D 7
tmux select-pane -t 1

tmux new-window -t work -n my
tmux send-keys -t work 'cd ~/workspace/my && clear' C-m
tmux split-window -v
tmux send-keys -t work 'cd ~/workspace/my && clear' C-m
tmux send-keys -t work 'bin/start' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/my && clear' C-m
tmux resize-pane -D 7
tmux select-pane -t 1

tmux new-window -t work
tmux send-keys -t work 'cd ~/workspace/core-app && clear' c-m
tmux split-window -v
tmux send-keys -t work 'cd ~/workspace/core-app && clear' c-m
tmux send-keys -t work 'bin/start' c-m
tmux resize-pane -D 7
tmux select-pane -t 1

# Create new window splitted in 4
tmux new-window -t work -n utilities\; \split-window -v \; \split-window -h \; \select-pane -t 1 \; \split-window -h
tmux select-pane -t 1
tmux send-keys -t work 'clear' c-m
tmux send-keys -t work 'myip'
tmux select-pane -t 2
tmux send-keys -t work 'tuiplayer --shuffle ~/Música' c-m
tmux select-pane -t 3
tmux send-keys -t work 'clear' c-m
tmux send-keys -t work 'neofetch --cpu_temp "C" --color_blocks "off"'
tmux select-pane -t 4
tmux send-keys -t work 'clear' c-m
tmux send-keys -t work 'task list' c-m

tmux select-window -t work:1
tmux attach -t work
