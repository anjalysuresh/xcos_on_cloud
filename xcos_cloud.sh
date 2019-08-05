#!/bin/bash

test $( id -u ) -eq 0 && { echo "Do not run this script as root"; exit 1; }
sudo -v

set -ex
cd ~

sudo apt install python3-mysqldb python3-pip

sudo rm -rf xcos_on_cloud
git clone https://github.com/FOSSEE/xcos_on_cloud
cd xcos_on_cloud

##read -p 'Enter the name of the scilab directory:' dir
##sudo sed -i "s,SCILAB_DIR = scilab_for_xcos_on_cloud,SCILAB_DIR =$dir,g" config.py
##sudo sed -i "s,HTTP_SERVER_HOST='127.0.0.1', HTTP_SERVER_HOST='10.129.103.157',g" config.py


sudo sed -i "s/.*HTTP_SERVER_HOST.*/HTTP_SERVER_HOST = '10.129.103.157'/" config.py 

pip3 install -r requirements.txt
make

#sudo chown -Rc edx:edx /tmp/flask-caching-dir/
#sudo chown -Rc edx:edx /tmp/flask-sessiondir/
#sudo chown -Rc edx:edx /tmp/sessiondir/
#sudo chown -Rc edx:edx /tmp/xcos-on-cloud-logs/

python3 SendLog.py
