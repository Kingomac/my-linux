#!/bin/bash

opciones=()
opciones+=("docker" "Gestor de contenedores Docker y Docker Compose" "off")
function install_docker {
    # Add Docker's official GPG key:
    sudo apt install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    if [ -z $VERSION_CODENAME ]; then
        VERSION_CODENAME=$UBUNTU_CODENAME
    fi

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update

    # Install packages
    sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Add user to docker group
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker

    # Enable Docker in systemd
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
}

opciones+=("vscode" "Visual Studio Code - Editor de código de referencia" "on")
function install_vscode {
    sudo apt install software-properties-common apt-transport-https wget -y
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt install code -y
}

opciones+=("git" "Control de versiones distribuido" "on")
function install_git {
    sudo apt install git -y
}

opciones+=("alacritty" "Terminal de referencia" "off")
function install_alacritty {
    sudo add-apt-repository ppa:aslatter/ppa -y
    sudo apt update
    sudo apt install alacritty -y
}

opciones+=("typora" "Editor de documentos Markdown" "off")
function install_typora {
    wget -qO - https://typoraio.cn/linux/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/typora.asc

    # add Typora's repository
    sudo add-apt-repository 'deb https://typora.io/linux ./'
    sudo apt-get update

    # install typora
    sudo apt-get install typora
}

opciones+=("discord" "Aplicación de comunicación esencial (deb)" "on")
function install_discord {
    wget "https://discord.com/api/download?platform=linux&format=deb"
    sudo dpkg -i discord-*.deb
    rm discord-*.deb
}

opciones+=("mpv" "Reproductor de vídeo MPV" "off")
function install_mpv {
   sudo apt install mpv -y
}

opciones+=("anime4klow" "Filtro de vídeo Anime4K para el reproductor MPV (lower-end GPU)" "off")
function install_anime4k {
    sudo apt install unzip wget -y
    mkdir -p ~/.config/mpv/shaders
    wget -P ~/.config/mpv/shaders https://github.com/bloc97/Anime4K/releases/download/v4.0.1/Anime4K_v4.0.zip
    unzip ~/.config/mpv/shaders/Anime4K_v4.0.zip -d ~/.config/mpv/shaders
    rm ~/.config/mpv/shaders/Anime4K_v4.0.zip
}

function install_anime4klow {
    install_anime4k
    tee ~/.config/mpv/input.conf << EOF
# Optimized shaders for lower-end GPU: Mode A (Fast)
glsl-shaders="~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"⏎ ~/.c/mpv  cat input.conf                                      dom 04 feb 2024 10:20:00
# Optimized shaders for lower-end GPU:
CTRL+1 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A (Fast)"
CTRL+2 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B (Fast)"
CTRL+3 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C (Fast)"
CTRL+4 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_Restore_CNN_S.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A+A (Fast)"
CTRL+5 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_S.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B+B (Fast)"
CTRL+6 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_S.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C+A (Fast)"
EOF
}

opciones+=("anime4khigh" "Filtro de vídeo Anime4K para el reproductor MPV (higher-end GPU)" "off")
function install_anime4khigh {
   install_anime4k
    tee ~/.config/mpv/input.conf << EOF
CTRL+1 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode A (HQ)"
CTRL+2 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode B (HQ)"
CTRL+3 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode C (HQ)"
CTRL+4 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode A+A (HQ)"
CTRL+5 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode B+B (HQ)"
CTRL+6 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode C+A (HQ)"

CTRL+0 no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"
EOF
}

opciones+=("spotify" "Streaming de música Spotify (flatpak)" "off")
function install_spotify {
   
}

opciones+=("spicetify" "Personalización de Spotify" "off")
function install_spicetify {
   
}

opciones+=("virtualbox" "Virtualización con VirtualBox" "off")
function install_virtualbox {
   
}

opciones+=("dnieremote" "DNI electrónico en Linux" "off")
function install_dnieremote {
   
}

opciones+=("autofirma" "Firma electrónica en Linux" "off")
function install_autofirma {
   
}

opciones+=("gimp" "Editor de imágenes GIMP" "off")
function install_gimp {
   
}

opciones+=("firefox" "Navegador web Firefox" "off")
function install_firefox {
   
}

opciones+=("chrome" "Navegador web Google Chrome" "off")
function install_chrome {
   
}

opciones+=("brave" "Navegador web Brave" "off")
function install_brave {
   
}


set seleccionados (dialog --stdout --title "Instalador de programas" --checklist "Seleccione los componentes que desea instalar:" 90 90 90 $opciones)
echo $seleccionados

clear
echo "Se requiere permisos de superusuario para instalar los programas, por favor ingrese tu contraseña"
echo "Actualizando listas de paquetes"
sudo apt update
echo "Actualizando paquetes"
sudo apt upgrade -y
echo "Instalando paquetes seleccionados"

for opcion in $seleccionados
do
    echo "************************************"
    echo "Instalando $opcion"
    install_$opcion
done