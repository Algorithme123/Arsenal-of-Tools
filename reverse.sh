#!/bin/bash

# Répertoire d'installation
INSTALL_DIR="$HOME/tools/reverse_engineering"

# Création du répertoire d'installation s'il n'existe pas déjà
mkdir -p "$INSTALL_DIR"

# Fonction pour télécharger et extraire les fichiers
download_and_extract() {
    local url=$1
    local dir=$2
    local filename=$(basename "$url")

    echo "Téléchargement de $filename..."
    wget -q "$url" -O "$filename"
    
    echo "Extraction de $filename dans $dir..."
    mkdir -p "$dir"
    unzip -q "$filename" -d "$dir" || tar -xf "$filename" -C "$dir"  # Essayer avec unzip ou tar selon le format
    rm "$filename"
}

# Installation de Ghidra
GHIDRA_DIR="$INSTALL_DIR/ghidra"
if [ -d "$GHIDRA_DIR" ]; then
    echo "Ghidra est déjà installé dans $GHIDRA_DIR."
else
    GHIDRA_URL="https://ghidra-sre.org/ghidra_10.1.5_PUBLIC_20220914.zip"
    echo "Installation de Ghidra..."
    download_and_extract "$GHIDRA_URL" "$GHIDRA_DIR"
fi

# Installation de Radare2 (version 5.9.6)
RADARE2_DIR="$INSTALL_DIR/radare2"
if [ -d "$RADARE2_DIR" ]; then
    echo "Radare2 est déjà installé dans $RADARE2_DIR."
else
    echo "Installation de Radare2 (version 5.9.6)..."
    curl -Ls https://github.com/radareorg/radare2/releases/download/5.9.6/radare2-5.9.6.tar.xz | tar xJv -C "$INSTALL_DIR"
    cd "$INSTALL_DIR/radare2-5.9.6" && ./sys/install.sh
fi

# Installation de x64dbg
X64DBG_URL="https://sourceforge.net/projects/x64dbg/files/snapshots/symbols-snapshot_2024-10-18_19-09.zip/download"
X64DBG_DIR="$INSTALL_DIR/x64dbg"
download_and_extract "$X64DBG_URL" "$X64DBG_DIR"

# Installation de Binary Ninja
BINARY_NINJA_URL="https://cdn.binary.ninja/installers/binaryninja_free_linux.zip"
BINARY_NINJA_DIR="$INSTALL_DIR/binary_ninja"
download_and_extract "$BINARY_NINJA_URL" "$BINARY_NINJA_DIR"

# Installation de IDA Free (à remplacer par un lien valide si disponible)
IDA_URL="https://out7.hex-rays.com/files/idafree70_linux.run"
IDA_DIR="$INSTALL_DIR/ida"
mkdir -p "$IDA_DIR"
echo "Téléchargement de IDA Free..."
wget -q "$IDA_URL" -O "$IDA_DIR/idafree.run"

echo "Installation de IDA Free..."
chmod +x "$IDA_DIR/idafree.run"
"$IDA_DIR/idafree.run" --mode unattended --prefix "$IDA_DIR"

# Ajouter les outils au PATH
echo "Ajout des outils au PATH..."
export PATH="$INSTALL_DIR/ghidra:$INSTALL_DIR/radare2:$INSTALL_DIR/x64dbg:$INSTALL_DIR/binary_ninja:$INSTALL_DIR/ida:$PATH"

# Vérification des installations
echo "Vérification des installations..."
if [ -d "$GHIDRA_DIR" ]; then echo "Ghidra installé avec succès."; else echo "Échec de l'installation de Ghidra."; fi
if [ -d "$RADARE2_DIR" ]; then echo "Radare2 installé avec succès."; else echo "Échec de l'installation de Radare2."; fi
if [ -d "$X64DBG_DIR" ]; then echo "x64dbg installé avec succès."; else echo "Échec de l'installation de x64dbg."; fi
if [ -d "$BINARY_NINJA_DIR" ]; then echo "Binary Ninja installé avec succès."; else echo "Échec de l'installation de Binary Ninja."; fi
if [ -f "$IDA_DIR/idafree.run" ]; then echo "IDA Free installé avec succès."; else echo "Échec de l'installation de IDA Free."; fi

echo "Installation terminée."
