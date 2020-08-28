#!/bin/bash

NAME="FirefoxSetup"
INSTALL_DIR="/usr/bin"
FOX_DIR="/opt/"
REGEX="^PATH=.*\K$INSTALL_DIR(?=.*)"
URL="https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US"


if [[ "$(env | grep -oP "$REGEX")" != "$INSTALL_DIR" ]]; then
   echo "Looks like your install directory "$INSTALL_DIR" is not in your PATH. Make sure you export it";
fi

INSTALLED_FIREFOX_VERSION=$(firefox --version | grep -Poie "\d+.\d+")


if [[ "${LATEST_FIREFOX_RELEASE}" != "${INSTALLED_FIREFOX_VERSION}" ]]; then
   echo "Installing Firefox ${LATEST_FIREFOX_RELEASE}..."
   sudo wget -O /tmp/${NAME}.tar.bz2 ${URL}
   echo "Downloading Firefox DONE!!!"
   sudo tar xjf /tmp/${NAME}.tar.bz2 -C ${FOX_DIR}
   echo "Exporting Firefox DONE!!!"
   sudo rm /tmp/${NAME}.tar.bz2
   echo "Deleting FirefoxSetup.tar.gz2 DONE!!!"
   sudo update-alternatives --install ${INSTALL_DIR}/firefox firefox ${FOX_DIR}/firefox/firefox 1
   echo "Firefox is DONE!!!"
else
   echo "Nothing done. Latest Firefox already installed."
fi
