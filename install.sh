#!/bin/sh

DIR="$( cd "$( dirname "$0" )" && pwd )"
CONFIG=~/.config

create_link() {
    ln -s $1 $2
}

create_link_config() {
    create_link "$DIR/.config/$1" "$CONFIG/$1"
}

mkdir -p $CONFIG

CONFIG_DIRS=("alacritty" "bspwm" "dunst" "polybar" "rofi" "sxhkd")

for i in ${CONFIG_DIRS[@]}
do
    echo $i
done

create_link "$DIR"/.bashrc ~/.bashrc

