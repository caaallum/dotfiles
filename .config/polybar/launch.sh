#!/usr/bin/env bash

killall -q polybar

if type "xrandr"; then
  for m in $(xrandr -q | grep -w connected | cut -d " " -f1); do
    MONITOR=$m polybar --reload topbar &
  done
else
  polybar --reload topbar &
fi
