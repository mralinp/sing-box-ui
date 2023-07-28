#! /bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color


CORE_LATEST_VERSION_URL="https://github.com/SagerNet/sing-box/releases/download/v1.3.0/sing-box-1.3.0-linux-amd64.tar.gz"
INSTALLATION_PATH="/opt/sagernet"


echo -e "${CYAN}---------------------- (‿ˠ‿) ---------------------- "


if [ "$(id -u)" != "0" ]; then
    echo -e "${RED} Ops! You are not root, this script must be run as root ${NC}"
    exit 1
fi

echo "ICBfX19fICBfICAgICAgICAgICAgIF9fX18gICAgICAgICAgICAgIF8gICBfIF9fXyAKIC8gX19ffChfKV8gX18gICBfXyBffCBfXyApICBfX19fXyAgX18gfCB8IHwgfF8gX3wKIFxfX18gXHwgfCAnXyBcIC8gX2AgfCAgXyBcIC8gXyBcIFwvIC8gfCB8IHwgfHwgfCAKICBfX18pIHwgfCB8IHwgfCAoX3wgfCB8XykgfCAoXykgPiAgPCAgfCB8X3wgfHwgfCAKIHxfX19fL3xffF98IHxffFxfXywgfF9fX18vIFxfX18vXy9cX1wgIFxfX18vfF9fX3wKICAgICAgICAgICAgICAgIHxfX18vICAgICAgICAgICAgICAgICAgICAgICAgICAgICA=" | base64 -d
echo
echo -e "${CYAN}--------------------- BY OzMa ---------------------${NC}"
echo -e "${YELLOW} 1. ${GREEN} Install"
echo -e "${YELLOW} 2. ${GREEN} Update"
echo -e "${YELLOW} 3. ${GREEN} Uninstall (purge)"
echo -e "${GRAY} -------------------"
echo -e "${YELLOW} 4. ${GREEN} Start SingBox-UI"
echo -e "${YELLOW} 5. ${GREEN} Stop SingBox-UI"
echo -e "${YELLOW} 6. ${GREEN} Restart SingBox-UI"
echo -e "${YELLOW} 7. ${GREEN} Status SingBox-UI"
echo -e "${GRAY} -------------------"
echo -e "${YELLOW} 8. ${GREEN} Nothing just hanging around..."

read -p "Enter option number [def: 8]: " choice
echo -e "${MAGENTA} "

Install(){
    echo -e "${GREEN} "
    read -p "Chose a username for administrator [default: admin]: " username
    if [[ $username == ""]]; then
        $username="admin"
    fi

    read -p "Chose a portnumber for SingBox-UI  [default: 8443]: " portnumber
    
    if [[ $portnumber == ""]]; then
        $portnumber="8443"
    fi 
    
    public_ip=$(hostname -I)
    
    echo "Installing singbox-core on $public_ip:$portnumber ...."
    apt update --force-yes
    apt upgrade --force-yes
    apt install socat curl wget
    curl -Lo ${INSTALLATION_PATH}/singbox ${CORE_LATEST_VERSION_URL} && tar -xzf 
    tar -xzf /root/sb
    cp -f /root/sing-box-*/sing-box /root 
    rm -r /root/sb /root/sing-box-* 
    chown root:root /root/sing-box 
    chmod +x /root/sing-box
    curl -Lo /root/sing-box_config.json https://raw.githubusercontent.com/iSegaro/Sing-Box/main/sing-box_config.json
    curl -Lo /etc/systemd/system/sing-box.service https://raw.githubusercontent.com/iSegaro/Sing-Box/main/sing-box.service 
    systemctl daemon-reload
}

case $choice in
    1)
        Install
        ;;
    2)
        echo "Updating singbox-core and singbox-ui..."
        ;;
    esac
done



