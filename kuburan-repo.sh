#!/data/data/com.termux/files/usr/bin/sh

# Script untuk memasukkan external repo

# install beberapa tools pendukung
apt-get update
apt-get install --assume-yes gnupg coreutils curl

# buat folder source.list baru
APT_DIR=/data/data/com.termux/files/usr/etc/apt
if [ -z "${SOURCES_LIST}" ]; then
    SOURCES_LIST="${APT_DIR}/sources.list.d"
fi

if [ ! -e "${SOURCES_LIST}" ]; then
    mkdir -p "${SOURCES_LIST}"
fi

# Download signed key
PREFIX=/data/data/com.termux/files/usr
if [ -z "${TMPDIR}" ]; then
    TMPDIR="${PREFIX}/tmp"
fi

if [ ! -e "${TMPDIR}" ]; then
    mkdir -p "${TMPDIR}"
fi

curl -o "${TMPDIR}/pubkey.gpg" https://kuburan.github.io/pubkey.gpg
apt-key add "${TMPDIR}/pubkey.gpg"
rm -rf "${TMPDIR}/pubkey.gpg"

# masukkan external repo
aarch64_architecture()
{
printf "\ndeb [arch=all,aarch64] https://kuburan.github.io/files/ termux external" > "${SOURCES_LIST}/kuburan.list"
}

arm_architecture()
{
printf "\ndeb [arch=all] https://kuburan.github.io/files/ termux external" > "${SOURCES_LIST}/kuburan.list"
}

i686_architecture()
{
printf "\ndeb [arch=all] https://kuburan.github.io/files/ termux external" > "${SOURCES_LIST}/kuburan.list"
}

x86_64_architecture()
{
printf "\ndeb [arch=all] https://kuburan.github.io/files/ termux external" > "${SOURCES_LIST}/kuburan.list"
}

arch=`dpkg --print-architecture`
case "$arch" in
    aarch64)
        aarch64_architecture
        ;;
    arm)
        arm_architecture
        ;;
    armhf)
        arm_architecture
        ;;
    i686)
        i686_architecture
        ;;
    x86_64)
        x86_64_architecture
        ;;
esac

# update
apt-get update

echo "\nDone ..."

exit
