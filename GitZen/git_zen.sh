sudo apt update
sudo apt install -y nodejs npm git


mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile
source ~/.profile
npm install -g jshint

npm i -g commitizen
npm i -g -D cz-customizable

mv ~/.npm-global/lib/node_modules/cz-customizable ~/.npm-global/lib/node_modules/cz-customizable/cz-config-EXAMPLE.old.js
cp commitizen.js ~/.npm-global/lib/node_modules/cz-customizable/cz-config-EXAMPLE.js

