#!/bin/bash
# ThemeInstaller by Secret-chest (https://github.com/Secret-chest/theme-installer)

# Colors
YELLOW=`tput setaf 11`
GREEN=`tput setaf 10`
CYAN=`tput setaf 14`
BLUE=`tput setaf 12`
PURPLE=`tput setaf 13`
BOLD=`tput bold`
DIM=`tput dim`
RESET=`tput sgr0`

THEME_NAME="Example Theme"

echo "${DIM}ThemeInstaller by Secret-chest (https://github.com/Secret-chest/theme-installer)"

echo -e "\n${CYAN}Welcome to the ${THEME_NAME} text mode installer!\nThis script will install ${THEME_NAME} to your computer. You will need to change the system theme after it finishes.${RESET}\n"

LOCATION="/usr/share/themes"
INSTALL_TYPE="all users"

if [ ! $USER = "root" ]
then
    echo "Theme will be installed locally, you are not root!"
    echo "Run this script with ${YELLOW}sudo${RESET} to install globally."
    if [ ! -d /home/$USER/.themes ]
    then
        mkdir /home/$USER/.themes
        echo "Created ~/.themes as it was missing"
    fi
    LOCATION="/home/$USER/.themes"
    INSTALL_TYPE="this user only"
fi

echo -e "\n${BLUE}${BOLD}Summary:${RESET}"
echo "${PURPLE}${BOLD}User${RESET}: "$USER
echo "${PURPLE}${BOLD}Location${RESET}: "$LOCATION
echo "${PURPLE}${BOLD}Install type${RESET}: "$INSTALL_TYPE
echo "${PURPLE}${BOLD}Themes to be installed${RESET}: "`ls source`

read -p "Install? (y/n) " confirm
echo ""
if [ $confirm = "n" ] || [ $confirm = "N" ]
then
    echo "Aborted."
    exit 0 
fi

echo "Copying theme files..."
cp -prf source/* $LOCATION
echo "Done"
echo "Adding extra styling to your stylesheet..."
cp /home/$USER/.config/gtk-3.0/gtk.css /home/$USER/.config/gtk-3.0/gtk.css.bak
cat extra.css > /home/$USER/.config/gtk-3.0/gtk.css
echo "Done"

echo -e "${GREEN}\nInstallation complete!${RESET}"
