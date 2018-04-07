# 1. download image https://www.raspberrypi.org/downloads/raspbian/
# 2. download image tool https://etcher.io/
# 3. flash
# 4. touch ssh on /boot
# 5. from '/boot/config.txt' add 'audio_pwm_mode=2' under 'dtparam=audio=on'
# 6. boot
# 7. ssh
# 8. sudo su
# 9. curl

# source
# ========================
echo "
deb http://mirrors.aliyun.com/raspbian/raspbian/  stretch main non-free contrib
deb-src http://mirrors.aliyun.com/raspbian/raspbian/  stretch main non-free contrib
" > /etc/apt/sources.list

echo "
deb http://mirrors.aliyun.com/debian/ stretch main ui
" > /etc/apt/sources.list.d/raspi.list

apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y

# config
# ========================
raspi-config nonint do_expand_rootfs
raspi-config nonint do_hostname minik

# change pi password 
echo 'input password for user pi (the default sudo user)'
passwd pi

# config root shell
echo 'PermitRootLogin without-password' >> /etc/ssh/sshd_config 

mkdir -p ~/.ssh/
chmod 700 ~/.ssh/
touch authorized_keys
chmod 600 ~/.ssh/authorized_keys 

echo 'input key for root ssh (or just enter without input)'
read sshkey
if [ -n "$SSHKEY" ]; then
    echo "$SSHKEY" >> ~/.ssh/authorized_keys
fi

# end
# ========================
reboot