#!/data/data/com.termux/files/usr/bin/sh
# Script untuk memasukkan external repo
#
# install beberapa tools pendukung
apt-get update
apt-get install --assume-yes gnupg coreutils wget

# buat folder source.list baru
mkdir -p /data/data/com.termux/files/usr/etc/apt/sources.list.d

# masukkan external repo
echo "deb [arch=all,aarch64] https://kuburan.github.io/files/ termux external" > /data/data/com.termux/files/usr/etc/apt/sources.list.d/kuburan.list

# Download signed key
wget https://kuburan.github.io/pubkey.gpg
apt-key add pubkey.gpg

# update
apt-get update

echo "Done ..."
