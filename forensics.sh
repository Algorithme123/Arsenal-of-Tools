#!/bin/bash

# Créer un répertoire d'installation pour tous les outils de forensic
INSTALL_DIR="/opt/forensics"
VOLATILITY2_DIR="$INSTALL_DIR/volatility2"
VOLATILITY3_DIR="$INSTALL_DIR/volatility3"
REKALL_DIR="$INSTALL_DIR/rekall"
AUTOPSY_DIR="$INSTALL_DIR/autopsy"

# Créez les répertoires principaux
sudo mkdir -p "$INSTALL_DIR"

### Installation de Volatility 2 dans un environnement virtuel ###
echo "Installation de Volatility 2 dans un environnement virtuel..."
if [ ! -d "$VOLATILITY2_DIR" ]; then
    sudo apt install -y python3-venv python3-pip  # Installer venv et pip
    python3 -m venv "$VOLATILITY2_DIR"             # Créer l'environnement virtuel
    source "$VOLATILITY2_DIR/bin/activate"         # Activer l'environnement
    pip install -U pip                             # Mettre à jour pip
    pip install volatility                         # Installer Volatility 2
    deactivate                                     # Désactiver l'environnement

    # Créer un lien symbolique pour Volatility 2
    echo -e "#!/bin/bash\nsource $VOLATILITY2_DIR/bin/activate\npython3 -m volatility \"\$@\"" | sudo tee /usr/local/bin/volatility2 > /dev/null
    sudo chmod +x /usr/local/bin/volatility2
else
    echo "Volatility 2 est déjà installé dans $VOLATILITY2_DIR."
fi

### Installation de Volatility 3 ###
echo "Installation de Volatility 3 depuis GitHub..."
if [ ! -d "$VOLATILITY3_DIR/.git" ]; then
    sudo git clone https://github.com/volatilityfoundation/volatility3.git "$VOLATILITY3_DIR"
    cd "$VOLATILITY3_DIR" || exit

    # Installation des dépendances
    sudo pip3 install -r requirements-minimal.txt
    echo "Volatility 3 installé dans $VOLATILITY3_DIR."

    # Créer un lien symbolique pour Volatility 3
    echo -e "#!/bin/bash\npython3 $VOLATILITY3_DIR/vol.py \"\$@\"" | sudo tee /usr/local/bin/volatility3 > /dev/null
    sudo chmod +x /usr/local/bin/volatility3
else
    echo "Volatility 3 est déjà cloné dans $VOLATILITY3_DIR."
fi

### Installation de Rekall ###
echo "Installation de Rekall..."
if [ ! -d "$REKALL_DIR" ]; then
    sudo apt install -y python3-venv python3-pip
    python3 -m venv "$REKALL_DIR"                   # Créer un environnement pour Rekall
    source "$REKALL_DIR/bin/activate"               # Activer l'environnement
    pip install rekall-agent rekall-core            # Installer Rekall
    deactivate                                      # Désactiver l'environnement

    # Créer un lien symbolique pour Rekall
    echo -e "#!/bin/bash\nsource $REKALL_DIR/bin/activate\nrekall \"\$@\"" | sudo tee /usr/local/bin/rekall > /dev/null
    sudo chmod +x /usr/local/bin/rekall
else
    echo "Rekall est déjà installé dans $REKALL_DIR."
fi

### Installation de FTK Imager ###
echo "Installation de FTK Imager..."
if [ ! -f /usr/local/bin/ftkimager ]; then
    wget -P "$INSTALL_DIR" https://download-url-of-ftkimager.tar.gz
    tar -xzvf "$INSTALL_DIR/ftkimager.tar.gz" -C "$INSTALL_DIR"
    sudo ln -s "$INSTALL_DIR/ftkimager/ftkimager" /usr/local/bin/ftkimager
else
    echo "FTK Imager est déjà installé."
fi

### Installation de Autopsy ###
echo "Installation de Autopsy..."
if [ ! -d "$AUTOPSY_DIR" ]; then
    sudo apt install -y autopsy
    echo "Autopsy est installé et accessible via la commande 'autopsy'."
else
    echo "Autopsy est déjà installé."
fi

# Vérification des installations
echo -e "\n--- Vérification des installations ---"
for tool in volatility2 volatility3 rekall ftkimager autopsy; do
    if command -v "$tool" &> /dev/null; then
        echo "$tool est installé et accessible."
    else
        echo "Erreur : $tool n'est pas accessible."
    fi
done
