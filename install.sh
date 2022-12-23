#!/bin/sh

DIR="$( cd "$( dirname "$0" )" && pwd )"
CONFIG=~/.config

create_link() {
    ln -s $1 $2
}

create_link_config() {
    create_link "$(DIR)/$1" "$(CONFIG)"
}

mkdir -p $CONFIG

create_link_config "alacritty"
create_link_config "bspwm"
create_link_config "dunst"
create_link_config "polybar"
create_link_config "rofi"
create_link_config "sxhkd"

create_link "$(DIR)"/.bashrc ~/.bashrc

