#!/bin/bash

prints "[NumixTheme] Check GNOME-shell"

gnome_version=$(gnome-shell --version)
if [[ $gnome_version == GNOME* ]] ;
then
    prints "[OK] GNOME-shell"
else
    peints_err "[fail] GNOME Shell not install"
    exit;
fi

sudo apt-get update;

printf '\nRemove useless applications...'
sudo apt autoremove gnome-sudoku gnome-mahjongg gnome-mines gnome-todo gnome-todo-common aisleriot -y

printf '\nInstall gnome-tweak-tool...'
sudo apt install chrome-gnome-shell gnome-shell-extensions gnome-tweak-tool -y

printf '\nInstall Numix Theme'
sudo apt install numix-gtk-theme numix-icon-theme -y

printf '\nSet Numix Theme'
gsettings set org.gnome.desktop.interface gtk-theme "Numix"
gsettings set org.gnome.desktop.wm.preferences theme "Numix"
gsettings set org.gnome.desktop.interface icon-theme 'Numix'

printf '\nSet Dark Theme'
echo '[Settings]' > ~/.config/gtk-3.0/settings.ini
echo 'gtk-application-prefer-dark-theme=1' >> ~/.config/gtk-3.0/settings.ini

