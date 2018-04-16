# 1. curl -sL https://raw.githubusercontent.com/able99/minik-homeassistant/master/homeassistant_raspberry.sh | nohup sh &
# tail -f nohup.out

# evn
# ====================
PATH_HA_RUN=${PATH_HA_RUN:-"~/ha"}
MATHINE=${MATHINE:-"raspberrypi3"}

# path
# ====================
mkdir -p $PATH_HA_RUN
mkdir -p ${PATH_HA_RUN}/share/data
mkdir -p ${PATH_HA_RUN}/share/tmp


# docker
# ====================
echo "------------- install docker ------------"
# install
curl -fsSL https://get.docker.com | bash -s docker
#curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
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
curl -sL https://raw.githubusercontent.com/home-assistant/hassio-build/master/install/hassio_install | bash -s -- -d $PATH_HA_RUN -m $MATHINE



# config homeassistant for minik
# ====================
echo "------------- config minik ------------"

# end
echo "------------- finish ----------------"
cat << EOF
welcome to minik base on homeassistant

1. check log
journalctl -fu hassio-supervisor.service

2. add minik hassio addons
curl -vv -l -H "Content-type: application/json" -X POST -d '{"addons_repositories"-addons/repository","https://github.com/able99/minik-hassio-addons"]}' 'http://localhost:8123/api/hassio/supervisor/options'

3. websit 
http://ip:8123
EOF



