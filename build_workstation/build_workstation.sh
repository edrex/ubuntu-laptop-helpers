# quick'n'dirty build script for a workstation

# add sources

srcdir="${PWD}"

repos="
  ppa:cherokee-webserver/ppa
"
packages="vim git meld cherokee php5-cli php5-fpm php5 phpmyadmin php5-mysql mysql-server xmonad avant-window-navigator chromium-browser quicksynergy"

# dropbox
# sublime text (tar)

for repo in $repos
do
  sudo apt-add-repository $repo
done
sudo apt-get update
sudo apt-get install -y $packages


# xmonad
mkdir ~/.xmonad
cp $srcdir/xmonad.hs ~/.xmonad
gconftool -t string -s /desktop/gnome/session/required_components/windowmanager xmonad
gconftool -t string -s /desktop/gnome/session/required_components/panel avant-window-navigator

# project
# repo="git@github.com:user/repo.git
mkdir ~/Working_Copies
pushd ~/Working_Copies
git clone $repo
mkdir cache cache/persistent cache/models
sudo chown -R www-data:www-data cache
cd ~/Working_Copies/turk/site/app/config
cp local.example.php local.php
# create dbs
cat $srcdir/setup.sql | mysql -u root -p
scp name@server:/tmp/db.sql.gz
zcat $srcdir db.sql.gz | mysql -u uname -p db


# http://dbanck.de/2009/06/16/cakephp-and-cherokee/
sudo cp $srcdir/cherokee.conf /etc/cherokee/cherokee.conf
/etc/init.d/cherokee reload
sudo cp $srcdir/www.conf /etc/php5/fpm/pool.d/www.conf
/etc/init.d/php5-fpm reload
cd /var/www
sudo ln -s /usr/share/phpmyadmin .

# sublime text
cd ~/Downloads
tar -xjvf $srcdir/sublime_text.tar.bz2
mkdir ~/bin
cd ~/bin
ln -s ~/Downloads/Sublime\ Text\ 2/sublime_text .
