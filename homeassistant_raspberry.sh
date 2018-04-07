# evn
# ====================
PATH_HA_RUN=~/ha

# path
# ====================
mkdir -p $PATH_HA_RUN
mkdir -p ${PATH_HA_RUN}/share/data
mkdir -p ${PATH_HA_RUN}/share/tmp


# docker
# ====================

# deps
apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common -y

# install
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
echo "deb [arch=armhf] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install docker-ce -y
#usermod -aG docker $USER

# config
echo '
{
  "registry-mirrors": ["https://registry.docker-cn.com"]
}
' > /etc/docker/daemon.json


# python
# ===================
mkdir -p ~/.pip
echo '
[global]
trusted-host=mirrors.aliyun.com
index-url=http://mirrors.aliyun.com/pypi/simple
' > ~/.pip/pip.conf

# homeassistant
# ===================

# deps
apt-get install bash socat jq -y

# main
#docker pull homeassistant/armhf-homeassistant:latest
#docker pull homeassistant/armhf-hassio-supervisor:latest
curl -sL https://raw.githubusercontent.com/home-assistant/hassio-build/master/install/hassio_install | bash -s -- -d $PATH_HA_RUN -m raspberrypi3
# journalctl -fu hassio-supervisor.service



