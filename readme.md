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

Manual download and extract:

```bash
wget https://github.com/DarkPark/dotfiles/archive/master.zip
unzip master.zip
mv dotfiles-master ~/.dotfiles
rm master.zip
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

## Kernel /etc/sysctl.conf Hardening ##

```bash
# Turn on execshield
kernel.exec-shield=1
kernel.randomize_va_space=1
# Enable IP spoofing protection
net.ipv4.conf.all.rp_filter=1
# Disable IP source routing
net.ipv4.conf.all.accept_source_route=0
# Ignoring broadcasts request
net.ipv4.icmp_echo_ignore_broadcasts=1
net.ipv4.icmp_ignore_bogus_error_messages=1
# Make sure spoofed packets get logged
net.ipv4.conf.all.log_martians = 1

# Дропаем ICMP-редиректы (против атак типа MITM)
net.ipv4.conf.all.accept_redirects=0
net.ipv6.conf.all.accept_redirects=0
# Включаем механизм TCP syncookies
net.ipv4.tcp_syncookies=1
# Различные твики (защита от спуфинга, увеличение очереди «полуоткрытых» TCP-соединений и так далее)
net.ipv4.tcp_timestamps=0
net.ipv4.tcp_max_syn_backlog=1280
kernel.core_uses_pid=1
```


## Security ##

```bash
sudo rkhunter --update
sudo rkhunter --check --report-warnings-only --skip-keypress
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
* [dm-crypt/Device encryption](https://wiki.archlinux.org/index.php/Dm-crypt/Device_encryption)

Fill the device with random data:

```bash
sudo dd if=/dev/urandom of=/dev/sda bs=1M status=progress
```

Alternative disk random filling approach:

```bash
sudo cryptsetup luksFormat /dev/sda
sudo cryptsetup luksOpen /dev/sda crypto
sudo dd if=/dev/zero of=/dev/mapper/crypto bs=8M status=progress
```

Init crypto partition:

```bash
sudo cryptsetup --key-size=512 --hash=sha256 --iter-time=5000 luksFormat /dev/sda
```

Open partition:

```bash
sudo cryptsetup luksOpen /dev/sda crypto
```

Use the device as physical volume:

```bash
sudo lvm pvcreate /dev/mapper/crypto
```

```bash
sudo lvm vgcreate crypto /dev/mapper/crypto
```

Create the logical volumes:

```bash
sudo lvm lvcreate --size 8G crypto --name swap
sudo lvm lvcreate --size 32G crypto --name root
sudo lvm lvcreate --size 2G crypto --name logs
sudo lvm lvcreate --extents 100%FREE crypto --name home
```

Create file systems and set labels:

```bash
sudo mkswap /dev/mapper/crypto-swap
sudo mkfs.ext4 /dev/mapper/crypto-root
sudo e2label /dev/mapper/crypto-root root
sudo mkfs.ext4 /dev/mapper/crypto-logs
sudo e2label /dev/mapper/crypto-logs logs
sudo mkfs.ext4 /dev/mapper/crypto-home
sudo e2label /dev/mapper/crypto-home home
sync
```

Install operating system and then finalize setup:

```bash
sudo mount /dev/mapper/crypto-root /mnt
sudo mount /dev/sde1 /mnt/boot
sudo mount -o bind /dev /mnt/dev
sudo mount -t proc proc /mnt/proc
sudo mount -t sysfs sys /mnt/sys
sudo chroot /mnt /bin/bash
echo "crypto UUID=`blkid -s UUID -o value /dev/sda` none luks,discard" >> /etc/crypttab
update-initramfs -u -k all
exit
```
