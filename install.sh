#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"
CONFIG=~/.config
CONFIG_DIRS=(alacritty bspwm dunst polybar rofi sxhkd)
DEPENDENCIES="x11-misc/sddm" \
             "gui-libs/display-manager-init" \
             "x11-terms/alacritty" \
             "x11-wm/bspwm" \
             "x11-misc/dunst" \
             "x11-misc/polybar" \
             "x11-misc/rofi" \
             "x11-misc/sxhkd" \
             "media-gfx/feh" \
             "x11-apps/setxkbmap" \
             "media-fonts/fontawesome" \
             "media-fonts/cascadia-code"

create_link() {
    ln -s $1 $2
}

create_link_config() {
    create_link "$DIR/.config/$1" "$CONFIG/$1"
}

sudo emerge -a $DEPENDENCIES

# Setup display manager
sudo cp $DIR/sddm.conf /etc/
sudo mkdir -p /etc/sddm/scripts
sudo cp $DIR/Xsetup /etc/sddm/scripts/
sudo chmod a+x /etc/sddm/scripts/*
sudo sed -i -e "s/xdm/sddm/" /etc/conf.d/display-manager
sudo rc-update add display-manager default

# Install config
mkdir -p $CONFIG
for CONFIG_DIR in ${CONFIG_DIRS[@]}
do
    create_link_config $CONFIG_DIR
done

create_link "$DIR"/.bashrc ~/.bashrc
