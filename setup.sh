#!/bin/bash  
echo "Gatt Louis"
echo "############################################"
echo "##INSTALLATION ##############################"
echo  "############################################\n\n"
echo "#<!>CE SCRIPT NE FONCTIONNE QU'AVEC LA BASE DE DONNEE FOURNIS\n"

echo "#<!>INTERNET EST NECESSAIRE A L'INSTALLATION DU SYSTEME\n"
echo "#Merci de renseigner au mieux les champs qui vous seront demandés"

echo "#En cas d'erreur vous pouvez arreter ce script à tout moment"


echo "####Début######\n\n"

sudo apt update

echo "#Installation du serveur web"
echo "\n#Installation d'apache2"

sudo apt-get install apache2 -y


sudo chown -R pi:www-data /var/www/html/
sudo chmod -R 770 /var/www/html/

echo "\n#Installation d'apache2 TERMINEE"
echo "\n#Installation de php"


sudo apt-get install php php-mbstring -y
sudo rm /var/www/html/index.html

echo "\n#Installation de PHP TERMINEE"
echo "\n#Installation de MYSQL"

sudo apt install mariadb-server php-mysql -y


echo "\n#Installation de MYSQL TERMINEE"
echo "\n#Installation des paquets necessaire "

sudo apt-get install vsftpd -y
sudo apt-get install unclutter -y

echo "\n\n\n#Installation des paquets necessaire TERMINEE "
echo "#Installation Preleminaire terminée"
echo "#Debut du telechargement des contenants necessaires"
cd /var/www/html/
sudo curl -s -O 'Authorization: token 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' https://raw.githubusercontent.com/RaitNaoo/DiffuseurSnir2022PHPCODE/main/index.php
sudo curl -s -O 'Authorization: token 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' https://raw.githubusercontent.com/RaitNaoo/DiffuseurSnir2022PHPCODE/main/scriptbdd.php
sudo curl -s -O 'Authorization: token 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' https://raw.githubusercontent.com/RaitNaoo/DiffuseurSnir2022PHPCODE/main/afficheur.php
sudo curl -s -O 'Authorization: token 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' https://raw.githubusercontent.com/RaitNaoo/DiffuseurSnir2022PHPCODE/main/functionaffichage.php
sudo curl -s -O 'Authorization: token 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' https://raw.githubusercontent.com/RaitNaoo/DiffuseurSnir2022PHPCODE/main/style.css
sudo mkdir /home/pi/.config/lxsession/
sudo mkdir /home/pi/.config/lxsession/LXDE-pi/
sudo cp /home/pi/Documents/composition/autostart /home/pi/.config/lxsession/LXDE-pi/
