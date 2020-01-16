prints "[GNOME-Extensions] Check GNOME-shell"

gnome_version=$(gnome-shell --version)
if [[ $gnome_version == GNOME* ]] ;
then
    prints "[OK] GNOME-shell"
else
    peints_err "[fail] GNOME Shell not install"
    exit;
fi

prints "[GNOME-Extensions] Install gnome-shell-extension-installer"
wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/bin/

prints "[GNOME-Extensions] Install extensions!"
gnome-shell-extension-installer 18
gnome-shell-extension-installer 905
gnome-shell-extension-installer 1228
gnome-shell-extension-installer 800
gnome-shell-extension-installer 779
gnome-shell-extension-installer 1160

printf '\nRestart Gnome Shell'
killall -3 gnome-shell