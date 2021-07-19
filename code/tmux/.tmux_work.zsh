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

tmux new-window -t work
tmux send-keys -t work 'cd ~/workspace/core-app && clear' c-m
tmux split-window -v -p 25
tmux send-keys -t work 'cd ~/workspace/core-app && clear' c-m
tmux send-keys -t work 'bin/start' c-m
tmux select-pane -t 1

tmux new-window -t work
tmux send-keys -t work 'cd ~/workspace/infrastructure && clear' c-m
tmux send-keys -t work 'bin/crisalix-cli capistrano estetix -e staging -t deploy:pending'

tmux new-window -t work -n cmus
tmux send-keys -t work 'cmus' c-m

tmux select-window -t work:1
tmux attach -t work
