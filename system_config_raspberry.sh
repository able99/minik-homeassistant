# 1. download image https://www.raspberrypi.org/downloads/raspbian/
# 2. download tool https://etcher.io/
# 3. flash image
# 4. touch ssh on /boot
# 5. from '/boot/config.txt' add 'audio_pwm_mode=2' under 'dtparam=audio=on' and add gpu_mem=16  
# 6. boot
# 7. sudo su && cd ~ && curl -sL https://raw.githubusercontent.com/able99/minik-homeassistant/master/system_config_raspberry.sh | sh 


# source
# ========================
echo "------------- config source list for soft ------------"

echo "deb http://mirrors.aliyun.com/raspbian/raspbian/  stretch main non-free contrib
deb-src http://mirrors.aliyun.com/raspbian/raspbian/  stretch main non-free contrib" > /etc/apt/sources.list

#echo "deb http://mirrors.aliyun.com/debian/ stretch main ui" > /etc/apt/sources.list.d/raspi.list

apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y

# config
# ========================
echo "------------- expand flash card ------------"
raspi-config nonint do_expand_rootfs
raspi-config nonint do_hostname minik

# change pi password 
echo "------------- config login user ------------"
echo 'input password for user pi (the default sudo user)'
passwd pi

# config root shell
echo "------------- config ssh for root ------------"
echo 'PermitRootLogin without-password' >> /etc/ssh/sshd_config 

mkdir -p ~/.ssh/
chmod 700 ~/.ssh/
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys 

echo 'input key for root ssh (or just enter without input)'
read SSHKEY
if [ -n "$SSHKEY" ]; then
    echo "$SSHKEY" >> ~/.ssh/authorized_keys
fi

# end
# ========================
echo "------------- config ok and reboot ------------"
reboot