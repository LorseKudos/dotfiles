### ssh-agent(WSL用) ###
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    eval `ssh-agent -k` > /dev/null
fi
