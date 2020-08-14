#!/bin/bash

INSTALL_DIR='/usr/bin'
FOX_DIR='/opt/'
REGEX="^PATH=.*\K$INSTALL_DIR(?=.*)"
if [[ $(env | grep -oP $REGEX) != $INSTALL_DIR ]]; then
   echo "Looks like your install directory $INSTALL_DIR is not in your PATH. Make sure you export it"; fi

INSTALLED_FIREFOX_VERSION=$(firefox --version | grep -Poie '\d+.\d+.\d+')


if [[ ${LATEST_FIREFOX_RELEASE} != ${INSTALLED_FIREFOX_VERSION} ]]; then
   echo "Installing Firefox ${LATEST_RELEASE}..."
   wget -O ~/tmp/FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64"
   sudo tar xjf ~/tmp/FirefoxSetup.tar.bz2 -C ${FOX_DIR}
   sudo rm ~/tmp/FirefoxSetup.tar.bz2
   sudo update-alternatives --install ${INSTALL_DIR}/firefox firefox ${FOX_DIR}/firefox/firefox 1
else
   echo "Nothing done. Latest Firefox already installed."
fi

