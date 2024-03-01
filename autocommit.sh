#!/bin/bash

# https://docs.vorondesign.com/community/howto/EricZimmerman/BackupConfigToGithub.html

# Path to your config folder you want to backup
config_folder=~/printer_data/config
# Path to your Klipper folder, by default that is '~/klipper'
klipper_folder=~/klipper
# Path to your Moonraker folder, by default that is '~/moonraker'
moonraker_folder=~/moonraker
# Path to your Mainsail folder, by default that is '~/mainsail'
mainsail_folder=~/mainsail
# Path to your Fluidd folder, by default that is '~/fluidd'
#fluidd_folder=~/fluidd

# The branch of the repository that you want to save your config
branch=main

grab_version() {
    if [ ! -z "$klipper_folder" ]; then
        klipper_commit=$(git -C "$klipper_folder" rev-parse --short=7 HEAD)
        m1="Klipper on commit: $klipper_commit"
    fi
    if [ ! -z "$moonraker_folder" ]; then
        moonraker_commit=$(git -C "$moonraker_folder" rev-parse --short=7 HEAD)
        m2="Moonraker on commit: $moonraker_commit"
    fi
    if [ ! -z "$mainsail_folder" ]; then
        mainsail_ver=$(head -n 1 $mainsail_folder/.version)
        m3="Mainsail version: $mainsail_ver"
    fi
    if [ ! -z "$fluidd_folder" ]; then
        fluidd_ver=$(head -n 1 $fluidd_folder/.version)
        m4="Fluidd version: $fluidd_ver"
    fi
    script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    repo_ver=$(git -C "$script_dir" rev-parse --short=7 HEAD)
    m5="klipper-config version: $repo_ver"
}

push_config() {
    git -C "$config_folder" pull origin $branch --no-rebase
    git -C "$config_folder" add .
    current_date=$(date +"%Y-%m-%d %T")
    git -C "$config_folder" commit \
        -m "Autocommit from $current_date" \
        -m "$m1" \
        -m "$m2" \
        -m "$m3" \
        -m "$m4" \
        -m "$m5"
    git -C "$config_folder" push origin $branch
}

grab_version
push_config
