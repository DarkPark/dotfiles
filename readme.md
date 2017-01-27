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


## Oracle Java ##

```bash
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
```


## SSH ##

Regenerating weak system SSH host keys (make sense only for RSA and ECDSA):

```bash
sudo ssh-keygen -N '' -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key
sudo ssh-keygen -N '' -t ecdsa -b 521 -f /etc/ssh/ssh_host_ecdsa_key
```

Generate user keys:

```bash
ssh-keygen -N '' -t rsa -b 4096
ssh-keygen -N '' -t ecdsa -b 521
```

Print key fingerprints:

```bash
# system
for file in /etc/ssh/*.pub; do ssh-keygen -lf $file; done
# user
for file in ~/.ssh/*.pub; do ssh-keygen -lf $file; done
```


## Disk encryption ##

* [Self-Encrypting Drives](https://wiki.archlinux.org/index.php/Self-Encrypting_Drives)
* [Drive Trust Alliance](https://github.com/Drive-Trust-Alliance)
* [Use the hardware-based full disk encryption of your TCG Opal SSD with msed](https://vxlabs.com/2015/02/11/use-the-hardware-based-full-disk-encryption-your-tcg-opal-ssd-with-msed/)
* [Guide to Full Disk Encryption with Ubuntu](http://thesimplecomputer.info/full-disk-encryption-with-ubuntu)

Init partition

```bash
sudo cryptsetup --verbose --key-size=512 --hash=sha512 luksFormat /dev/sda
```

Open partition

```bash
sudo cryptsetup luksOpen /dev/sda crypto
```

Fill the resulting device with zeros, using dd and /dev/zero as source:

```bash
sudo dd if=/dev/zero of=/dev/mapper/crypto bs=1M
```

Close the LUKS device and destroy the LUKS header overriding it with random data:

```bash
sudo cryptsetup luksClose crypto
sudo dd if=/dev/urandom of=/dev/sda bs=512 count=20480
```

Use the device as physical volume:

```bash
sudo lvm pvcreate --verbose /dev/mapper/crypto
```

```bash
sudo lvm vgcreate --verbose crypto /dev/mapper/crypto
```

Create the logical volumes

```bash
sudo lvm lvcreate --size 4G crypto --name swap
sudo lvm lvcreate --size 16G crypto --name root
sudo lvm lvcreate --extents 100%FREE crypto --name home
```

Create file systems and set labels:

```bash
sudo mkswap /dev/mapper/crypto-swap
sudo mkfs.ext4 -v /dev/mapper/crypto-root 
sudo e2label /dev/mapper/crypto-root root
sudo mkfs.ext4 -v /dev/mapper/crypto-home 
sudo e2label /dev/mapper/crypto-home home
sync
```
