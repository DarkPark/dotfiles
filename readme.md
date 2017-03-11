dotfiles
========

## Deployment ##

```bash
sudo apt update
sudo apt upgrade
sudo apt install acpid mc htop git curl bash-completion whois nmap tmux
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
cd
ln -s .dotfiles/.bash_aliases .bash_aliases
ln -s .dotfiles/.bash_profile .bash_profile
ln -s .dotfiles/.inputrc .inputrc
ln -s .dotfiles/.vimrc .vimrc
ln -s .dotfiles/.tmux.conf .tmux.conf
```


## swappiness ##

```bash
echo "vm.swappiness = 5" | sudo tee /etc/sysctl.d/60-swappiness.conf
```


## max user watches ##

```bash
echo "fs.inotify.max_user_watches = 524288" | sudo tee /etc/sysctl.d/60-watches.conf
```

cp /etc/hostname /root/.dotfiles/etc/
cp /etc/hosts /root/.dotfiles/etc/

sudo ln -sr ./etc/sysctl.d/60-swappiness.conf /etc/sysctl.d/60-swappiness.conf
sudo ln -sr ./etc/sysctl.d/60-watches.conf /etc/sysctl.d/60-watches.conf

sudo rm /etc/hostname
sudo ln -sr ./etc/hostname /etc/hostname
sudo rm /etc/hosts
sudo ln -sr ./etc/hosts /etc/hosts


Reload settings from config files without rebooting the box:

```bash
sudo sysctl --system
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

Partitions:

* `/dev/sda1` - [EFI system partition](https://en.wikipedia.org/wiki/EFI_system_partition) (fat32, boot, esp, 512Mb)
* `/dev/sda2` - boot partition (ext4, 512Mb)
* `/dev/sda3` - LUKS partition

Fill the device with random data:

```bash
sudo dd if=/dev/urandom of=/dev/sda3 bs=1M status=progress
```

Alternative disk random filling approach:

```bash
sudo cryptsetup luksFormat /dev/sda3
sudo cryptsetup luksOpen /dev/sda3 crypto
sudo dd if=/dev/zero of=/dev/mapper/crypto bs=8M status=progress
```

Init crypto partition:

```bash
sudo cryptsetup --key-size=512 --hash=sha256 --iter-time=3000 luksFormat /dev/sda3
```

Open partition:

```bash
sudo cryptsetup luksOpen /dev/sda3 crypto
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
sudo lvm lvcreate --size 20G crypto --name root
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

Install operating system, do not reboot and then finalize setup:

```bash
sudo mount /dev/mapper/crypto-root /mnt
sudo mount /dev/sde1 /mnt/boot
sudo mount -o bind /dev /mnt/dev
sudo mount -t proc proc /mnt/proc
sudo mount -t sysfs sys /mnt/sys
sudo chroot /mnt /bin/bash
echo "crypto UUID=`blkid -s UUID -o value /dev/sda3` none luks,discard" >> /etc/crypttab
update-initramfs -u -k all
exit
```

Immutable bit:

```bash
chattr -R +i /etc/passwd /etc/shadow /etc/group /etc/apt /bin /sbin /usr/bin /usr/sbin /usr/lib
chattr -R -i /etc/passwd /etc/shadow /etc/group /etc/apt /bin /sbin /usr/bin /usr/sbin /usr/lib
```
