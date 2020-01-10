#!/bin/bash
# Caution! Regex!
# Refact
remove_reg(){
	suffix=$2
	input_s=$1
	suffix1=$(echo "$input_s" | grep -oP "$suffix")
	echo ${input_s%"$suffix1"}
}

clean_url(){
a=$(echo $1 | cut -d '/' -f 5)

a=$(remove_reg $a '\?version_tag=\d*')

a=$(remove_reg $a '\.shell-extension.zip')

a=$(remove_reg $a '\.v\d*')
a=${a//%40/@}
echo $a
}

install_extension(){
	
	extension_url=$1
	
	extension_full_name=$(clean_url $extension_url)

	extension_path=~/.local/share/gnome-shell/extensions/$extension_full_name
	extension_zip=$extension_full_name.zip

	echo -e "\n\033[1;42mDownload and unziping \033[0m\033[1;44m$extension_full_name\033[0m"
	echo -e ""
	
	mkdir -p $extension_path
	wget -O $extension_zip $extension_url
	unzip $extension_zip -d $extension_path
	gnome-shell-extension-tool -e $extension_full_name
	rm -f $extension_zip
}


sudo apt-get update;

printf '\nRemove useless applications...'
sudo apt autoremove gnome-sudoku gnome-mahjongg gnome-mines gnome-todo gnome-todo-common aisleriot

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



printf '\n Install extensions!'

gval1=$(gnome-shell --version)
gval2="GNOME Shell 3.28"
if [[ "$gval1" =~ "$gval2" ]] ; then
	install_extension https://extensions.gnome.org/extension-data/arc-menu%40linxgem33.com.v22.shell-extension.zip;
	install_extension https://extensions.gnome.org/extension-data/dash-to-panel%40jderose9.github.com.v16.shell-extension.zip
	install_extension https://extensions.gnome.org/extension-data/clipboard-indicator%40tudmotu.com.v30.shell-extension.zip
	install_extension https://extensions.gnome.org/extension-data/remove-dropdown-arrows%40mpdeimos.com.v9.shell-extension.zip
	install_extension https://extensions.gnome.org/extension-data/alternate-tab%40gnome-shell-extensions.gcampax.github.com.v38.shell-extension.zip
	install_extension  https://extensions.gnome.org/extension-data/refresh-wifi%40kgshank.net.v10.shell-extension.zip
	install_extension  https://extensions.gnome.org/extension-data/native-window-placement%40gnome-shell-extensions.gcampax.github.com.v37.shell-extension.zip
else
	echo "Your GNOME Shell version is not 3.28"
fi

printf '\nRestart Gnome Shell'
killall -3 gnome-shell
