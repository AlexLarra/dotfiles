#!/bin/zsh

tmux new -s work -d

tmux send-keys -t work 'cd ~/workspace/admin && clear' C-m
tmux split-window -v -p 25
tmux send-keys -t work 'cd ~/workspace/admin && clear' C-m
tmux send-keys -t work 'rails s' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/admin && clear' C-m
tmux select-pane -t 1

tmux new-window -t work
tmux send-keys -t work 'cd ~/workspace/estetix && clear' C-m
tmux split-window -v -p 25
tmux send-keys -t work 'cd ~/workspace/estetix && clear' C-m
tmux send-keys -t work 'bin/start' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/estetix && clear' C-m
tmux select-pane -t 1

tmux new-window -t work
tmux send-keys -t work 'cd ~/workspace/crisalix && clear' C-m
tmux split-window -v -p 25
tmux send-keys -t work 'cd ~/workspace/crisalix && clear' C-m
tmux send-keys -t work 'rs -p 3005' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/crisalix && clear' C-m
tmux select-pane -t 1

tmux new-window -t work
tmux send-keys -t work 'cd ~/workspace/SSO && clear' C-m
tmux split-window -v -p 25
tmux send-keys -t work 'cd ~/workspace/SSO && clear' C-m
tmux send-keys -t work 'rs -p 3007' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/SSO && clear' C-m
tmux select-pane -t 1

tmux new-window -t work
tmux send-keys -t work 'cd ~/workspace/my && clear' C-m
tmux split-window -v -p 25
tmux send-keys -t work 'cd ~/workspace/my && clear' C-m
tmux send-keys -t work 'bin/start' C-m
tmux split-window -h -t 2
tmux send-keys -t work 'cd ~/workspace/my && clear' C-m
tmux select-pane -t 1

tmux select-window -t work:1
tmux attach -t work
