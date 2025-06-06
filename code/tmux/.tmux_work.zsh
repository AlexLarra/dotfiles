#!/bin/zsh

tmux new -s work -d

tmux send-keys -t work 'cd ~/workspace/admin && clear' C-m
tmux split-window -v
tmux send-keys -t work 'cd ~/workspace/admin && clear' C-m
tmux send-keys -t work 'bin/start' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/admin && clear' C-m
tmux resize-pane -D 7
tmux select-pane -t 1

tmux new-window -t work
tmux send-keys -t work 'cd ~/workspace/estetix && clear' C-m
tmux split-window -v
tmux send-keys -t work 'cd ~/workspace/estetix && clear' C-m
tmux send-keys -t work 'bin/start' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/estetix && clear' C-m
tmux resize-pane -D 7
tmux select-pane -t 1

tmux new-window -t work
tmux send-keys -t work 'cd ~/workspace/crisalix && clear' C-m
tmux split-window -v
tmux send-keys -t work 'cd ~/workspace/crisalix && clear' C-m
tmux send-keys -t work 'rs -p 3005' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/crisalix && clear' C-m
tmux resize-pane -D 7
tmux select-pane -t 1

tmux new-window -t work
tmux send-keys -t work 'cd ~/workspace/SSO && clear' C-m
tmux split-window -v
tmux send-keys -t work 'cd ~/workspace/SSO && clear' C-m
tmux send-keys -t work 'rs -p 3007' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/SSO && clear' C-m
tmux resize-pane -D 7
tmux select-pane -t 1

tmux new-window -t work
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

tmux new-window -t work
tmux send-keys -t work 'cd ~/workspace/infrastructure && clear' c-m
tmux send-keys -t work 'bin/crisalix-cli capistrano crisalix_admin -e staging -t deploy:pending'

# Create new window splitted in 4
tmux new-window -t work -n utilities\; \split-window -v \; \split-window -h \; \select-pane -t 1 \; \split-window -h
tmux select-pane -t 1
tmux send-keys -t work 'clear' c-m
tmux send-keys -t work 'cointop'
tmux select-pane -t 2
tmux send-keys -t work 'cmus' c-m
tmux select-pane -t 3
tmux send-keys -t work 'clear' c-m
tmux send-keys -t work 'neofetch --cpu_temp "C" --color_blocks "off"'
tmux select-pane -t 4
tmux send-keys -t work 'clear' c-m
tmux send-keys -t work 'task list' c-m

tmux select-window -t work:1
tmux attach -t work
