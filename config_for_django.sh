#!/bin/bash

. ~/.bashrc

conda update conda
conda update anaconda

conda install -c anaconda anaconda-navigator
chmod +x Anaconda.desktop 
cp Anaconda.desktop ~/.local/share/applications

# coede Plugins:
code --install-extension ms-ceintl.vscode-language-pack-ru
code --install-extension donjayamanne.python-extension-pack
code --install-extension thebarkman.vscode-djaneiro
code --install-extension ffaraone.pyfilesgen #?
# dongli.python-preview
code --install-extension alefragnani.bookmarks
ms-python.anaconda-extension-pack