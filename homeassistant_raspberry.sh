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
echo "------------- install docker ------------"

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
echo '{
  "registry-mirrors": ["https://registry.docker-cn.com"]
}' > /etc/docker/daemon.json


# python
# ===================
echo "------------- config python ------------"

mkdir -p ~/.pip
echo '
[global]
trusted-host=mirrors.aliyun.com
index-url=http://mirrors.aliyun.com/pypi/simple
' > ~/.pip/pip.conf

# homeassistant
# ===================
echo "------------- install homeassistant ------------"

# deps
apt-get install bash socat jq -y

# main
#docker pull homeassistant/armhf-homeassistant:latest
#docker pull homeassistant/armhf-hassio-supervisor:latest
curl -sL https://raw.githubusercontent.com/home-assistant/hassio-build/master/install/hassio_install | bash -s -- -d $PATH_HA_RUN -m raspberrypi3



# config homeassistant for minik
# ====================
echo "------------- config minik ------------"
echo "wait service..."
sleep 30

echo "add minik hassio addons"
curl -vv -l -H "Content-type: application/json" -X POST -d '{"addons_repositories"-addons/repository","https://github.com/able99/minik-hassio-addons"]}' 'http://localhost:8123/api/hassio/supervisor/options'

echo "
welcome to minik base on homeassistant

1. check log
journalctl -fu hassio-supervisor.service

2. websit 
http://ip:8123
"



