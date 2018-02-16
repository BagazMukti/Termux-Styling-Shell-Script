#!/data/data/com.termux/files/usr/bin/bash
# Unofficial Termux Styling
# Coded by BagazMukti [ bl33dz ]
# https://github.com/BagazMukti/Termux-Styling-Shell-Script
# https://bl33dz.me/
# z@bl33dz.me
# bagaz@protonmail.ch

function help {
	echo -e "Options:
 --colors-list            Display colors list
 --fonts-list             Display fonts list
 --change-color <number>  Change color list
 --change-font <number>   Change font list
 --update                 Update termux styling
 --help                   Display this help\n"
}
function check_connection {
	curl=$(curl http://bagaz.org/ -s)
	if [ $curl ]; then
		echo "[+] Connected to internet..."
	else
		echo "[-] Not connected to internet..."
		exit
	fi
}
function colors2array {
	list=()
	for color in $(cat colors.list); do
		list+=("$color");
	done
}
function colors_list {
	echo "Colors list:"
	num=1
	colors=
	for color in $(cat colors.list); do
		colors+="[$num] ${color//.properties/}\n"
		((num++))
	done
	echo -ne $colors
}
function fonts2array {
	list=()
	for font in $(cat fonts.list); do
		list+=("$font")
	done
}
function fonts_list {
	echo "Fonts list:"
	num=1
	fonts=
	for font in $(cat fonts.list); do
		fonts+="[$num] ${font//.ttf/}\n"
		((num++))
	done
	echo -ne $fonts
}

echo "
 _____      _____ _         _ _
|_   _|    /  ___| |       | (_)
  | |______\ \`--.| |_ _   _| |_ _ __   __ _
  | |______|\`--. \ __| | | | | | '_ \ / _\` |
  | |      /\__/ / |_| |_| | | | | | | (_| |
  \_/      \____/ \__|\__, |_|_|_| |_|\__, |
                       __/ |           __/ |
                      |___/           |___/"
echo -e "             { \e[1;31mTermux Styling\e[0m }\n"

if [[ $1 = "--help" ]]; then
	help
elif [[ $1 = "--colors-list" ]]; then
	colors_list
elif [[ $1 = "--fonts-list" ]]; then
	fonts_list
elif [[ $1 = "--change-color" ]]; then
	colors2array
	color=${list[(($2-1))]}
	if [[ $2 = "" ]]; then
		echo "Option \"--change-color\" need argument!"
	else
		check_connection
		echo "[+] Color: ${color//.properties/}"
		echo "[+] Downloading $color file..."
		url="http://bagaz.org/termux/colors/$color"
		wget -q "$url" -O color.tmp
		echo "[+] Installing color..."
		mv color.tmp ~/.termux/colors.properties
		termux-reload-settings
		echo "[+] Done..."
	fi
elif [[ $1 = "--change-font" ]]; then
	fonts2array
	font=${list[(($2-1))]}
	if [ $2 = "" ]; then
		check_connection
		echo "Option \"--change-font\" need argument!"
	else
		echo "[+] Font: ${font//.ttf/}"
		echo "[+] Downloading $font file..."
		url="http://bagaz.org/termux/fonts/$font"
		wget -q "$url" -O font.tmp
		echo "[+] Installing font..."
		mv font.tmp ~/.termux/font.ttf
		termux-reload-settings
		echo "[+] Done..."
	fi
elif [[ $1 = "--update" ]]; then
	check_connection
	echo "[+] Updating..."
	wget -q http://bagaz.org/termux/data/fonts.list -O fonts.list
	wget -q http://bagaz.org/termux/data/colors.list -O colors.list
	echo "[+] Done..."
else
	echo -e "Usage: ./termux-styling.sh --help\n"
fi

# bl33dz with love <3
