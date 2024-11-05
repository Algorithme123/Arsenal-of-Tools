#!/bin/bash

# Variables de chemins d'installation
rootpath="/path/to/install"  # Remplacez par votre chemin d'installation
binpath="/usr/local/bin"      # Répertoire des exécutables

# CRYPTOGRAPHIE ET STÉGANOGRAPHIE
echo "Installation des outils de cryptographie et de stéganographie pour les CTFs"

# pdfcrack - Casser les mots de passe des fichiers PDF
echo "Install pdfcrack"
apt-get install pdfcrack -y

# fcrackzip - Casser les mots de passe des fichiers ZIP
echo "Install fcrackzip"
apt-get install fcrackzip -y

# RsaCtfTool - Outil pour résoudre les défis RSA
echo "Install RsaCtfTool"
git clone https://github.com/Ganapati/RsaCtfTool $rootpath/RsaCtfTool
apt-get install libgmp3-dev libmpc-dev -y
pip3 install -r $rootpath/RsaCtfTool/requirements.txt
ln -s $rootpath/RsaCtfTool/RsaCtfTool.py $binpath/RsaCtfTool

# xortool - Pour déchiffrer les données chiffrées avec XOR
echo "Install xortool"
pip3 install xortool

# pkcrack - Casser les fichiers ZIP protégés
echo "Install pkcrack"
git clone https://github.com/keyunluo/pkcrack $rootpath/pkcrack
mkdir $rootpath/pkcrack/build
cd $rootpath/pkcrack/build
cmake ..
make
for bin in $(ls ../bin/ | grep -v "exe"); do ln -s $rootpath/pkcrack/bin/$bin $binpath/$bin ;done
cd $rootpath

# Stéganographie et Manipulation de Fichiers
echo "Installation des outils de stéganographie et de manipulation de fichiers"

# outguess
echo "Install outguess"
apt-get install outguess -y

# steghide
echo "Install steghide"
apt-get install steghide -y

# exiftool - Extraction de métadonnées
echo "Install exiftool"
apt-get install exiftool -y

# LSB-Steganography
echo "Install LSB-steganography"
git clone https://github.com/RobinDavid/LSB-Steganography /usr/share/LSB-steganography
pip install -r /usr/share/LSB-steganography/requirements.txt
chmod 755 /usr/share/LSB-steganography/LSBSteg.py

# pdf-parser
echo "Install pdf-parser"
apt-get install pdf-parser -y

# sng - Manipulation de fichiers PNG
echo "Install sng"
apt-get install sng -y

# stegsolve - Analyse de données cachées dans des images
echo "Install stegsolve"
wget www.caesum.com/handbook/Stegsolve.jar -P /usr/share/stegsolve/
ln -s /usr/share/stegsolve/Stegsolve.jar /usr/bin/stegsolve.jar

# stegsnow - Outil pour cacher des données dans des espaces blancs
echo "Install stegsnow"
apt-get install stegsnow -y

# stegosuite - Outil graphique pour la stéganographie
echo "Install stegosuite"
apt-get install stegosuite -y

# ffmpeg - Manipulation de fichiers multimédia
echo "Install ffmpeg"
apt-get install ffmpeg -y

# pngcheck - Validation et analyse de fichiers PNG
echo "Install pngcheck"
apt-get install pngcheck -y

# stegoveritas - Suite pour analyser les fichiers stéganographiques
echo "Install stegoveritas"
pip3 install stegoveritas
stegoveritas_install_deps

# spectrology - Analyse des spectres audio
echo "Install spectrology"
git clone https://github.com/solusipse/spectrology /usr/share/spectrology
ln -s /usr/share/spectrology/ /usr/bin

# cloacked-pixel - Outil de stéganographie pour les images
echo "Install cloacked-pixel"
git clone https://github.com/livz/cloacked-pixel /usr/share/cloacked-pixel
ln -s /usr/share/cloacked-pixel/lsb.py /usr/bin/cloackedpxl-lsb.py
ln -s /usr/share/cloacked-pixel/crypt.py /usr/bin/cloackedpxl-crypt.py

# AudioStego (Hideme) - Stéganographie pour les fichiers audio
echo "Install AudioStego (Hideme)"
apt-get install -y libboost-all-dev cmake
git clone https://github.com/danielcardeenas/AudioStego /usr/share/AudioStego
cd /usr/share/AudioStego
mkdir build
cd build
cmake ..
make
ln -s /usr/share/AudioStego/build/hideme /usr/bin/

# jphide & jpseek - Cacher et extraire des données dans des fichiers JPEG
echo "Install jphide & jpseek"
apt-get install libjpeg-dev -y
git clone https://github.com/h3xx/jphs /usr/share/jphs
cd /usr/share/jphs/
make
ln -s /usr/share/jphs/jpseek /usr/bin/
ln -s /usr/share/jphs/jphide /usr/bin/
cd

# zsteg - Détection de données cachées dans des fichiers PNG
echo "Install zsteg"
git clone https://github.com/zed-0xff/zsteg.git /usr/share/zsteg
cd /usr/share/zsteg
gem install zsteg
cd

# qsstv - Logiciel de transmission d'images par ondes radio
echo "Install qsstv"
apt-get install qsstv -y

# Finalisation
echo "Installation des outils de cryptographie et de stéganographie terminée."
echo "Tous les liens symboliques sont créés dans $binpath."
