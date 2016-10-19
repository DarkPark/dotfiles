dotfiles
========

## Deployment ##

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install mc htop git curl whois nmap tmux
```


Clone

```bash
# for github users
git clone git@github.com:DarkPark/dotfiles.git ~/.dotfiles
# for anybody
git clone https://github.com/DarkPark/dotfiles.git ~/.dotfiles
```


Make symlinks

```bash
ln -s ~/.dotfiles/.inputrc ~/.inputrc
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
```


## swappiness ##

A value from 0 to 100 which controls the degree to which the system favors anonymous memory or the page cache.
A high value improves file-system performance, while aggressively swapping less active processes out of physical memory.
A low value avoids swapping processes out of memory, which usually decreases latency, at the cost of I/O performance.
The default value is 60.

```bash
echo "vm.swappiness = 5" | sudo tee /etc/sysctl.d/60-swappiness.conf
```


## max user watches ##

The inotify API provides a mechanism for monitoring file system events.
Inotify can be used to monitor individual files, or to monitor directories.
When a directory is monitored, inotify will return events for the directory itself, and for files inside the directory.
This options specifies an upper limit on the number of watches that can be created per real user ID.

```bash
echo "fs.inotify.max_user_watches = 524288" | sudo tee /etc/sysctl.d/60-watches.conf
```
