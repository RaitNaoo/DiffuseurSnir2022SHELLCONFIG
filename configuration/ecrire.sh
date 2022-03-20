#!/bin/bash  
echo "Gatt Louis"
echo "############################################"
echo "##INSTALLATION ET CONFIGURATION D'UN ECRAN######"
echo  "############################################\n\n"
echo "#<!>CE SCRIPT NE FONCTIONNE QU'AVEC LA BASE DE DONNEE FOURNIS\n"

echo "#<!>AVANT L'EXCUTION DE CE SCRIPT, IL FAUT AJOUTER L'ECRAN à LA BASE DE DONNEES (./ajoutecran.sh ou manuellement)\n"
while true; do
    read -p "<!>L'ECRAN EST-IL AJOUTE ?(yes ou no)" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo "Ouvrir le fichier ./ajoutecran.sh ou l'ajouté manuellement"; exit;;
        * ) echo "Repondre yes ou no.";;
    esac
done

echo "#Merci de renseigner au mieux les champs qui vous seront demandés"
echo "#En cas d'erreur vous pouvez arreter ce script à tout moment"
echo "#En cas d'erreur la configuration du .ini peut se faire manuellement"

echo "####Début######\n\n"
echo "#l'host est l'ip ou le dns de votre bdd: x.x.x.x"
echo "-Entrer l'hote : "  
read hostbdd

find  /home/pi/Documents/configuration/ini/config.ini -type f -exec sed -i 's/hostbdd\=.*/hostbdd\='$hostbdd'/g' {} \;


echo "\n#Utilisateur autorisé à acceder à la base de donnée"
echo "-Entrer l'utilisateur de la bdd : "
read userbdd

find  /home/pi/Documents/configuration/ini/config.ini -type f -exec sed -i 's/userbdd\=.*/userbdd\='$userbdd'/g' {} \;

echo "\n#Mettre le mot de passe en clair de la bdd"
while true; do
    read -p "<!>Le mot de passe contient-il des charcteres spéciaux ?(yes ou no)" yn
    case $yn in
        [Yy]* ) echo "Merci de le renseigner directement dans le ./Documents/configuration/ini//config.ini et dans var/www/afficheur/config.ini\n\n";
         echo "-Entrer le mot de pase de la bdd pour la suite du script (à modifier dans le Documents/configuration/ini/config.ini)\n /!\/!\/!\/!\/!\ET DANS LE var/www/html/config.ini /!\/!\/!\/!\/!\/!\ : "
         read passbdd; break;;
                
        [Nn]* ) echo "-Entrer le mot de pase de la bdd : "
                read passbdd

                find  /home/pi/Documents/configuration/ini/config.ini -type f -exec sed -i 's/passbdd\=.*/passbdd\='$passbdd'^/g' {} \;
                break;;
    esac
done


echo "\n#Nom de la base de donnée à utiliser"
echo "-Entrer le Nom de la bdd : "
read namebdd

find  /home/pi/Documents/configuration/ini/config.ini -type f -exec sed -i 's/namebdd\=.*/namebdd\='$namebdd'/g' {} \;

mysql -h$hostbdd -u$userbdd --password="$passbdd" $namebdd -e 'SELECT * FROM ecran'

echo "\n#Choisissez l'ID_Ecran de l'écran ajouté "
echo "<!> PRENDRE CELUI AJOUTé RECEMMENT <!>"
echo "-Entrer l'id_ecran souhaité : "
read idecran

echo "\n#Vous avez choisi l'ecran n°"$idecran""
while true; do
    read -p "<!> EST-CE BIEN CELUI CI ? ?(yes ou no)" yn
    case $yn in
        [Yy]* ) idecran1=$idecran ; break;;
        [Nn]* ) echo "-Entrer l'id_ecran souhaité : \n"
                read idecran1 ; break;;
        * ) echo "Repondre yes ou no.";;
    esac
done

find /home/pi/Documents/configuration/ini/config.ini -type f -exec sed -i 's/idecran\=.*/idecran\='$idecran1'/g' {} \;

echo "\n\n\n\n #############Récapitulatif"
echo "################################################"
echo "##HOTE :      $hostbdd##########"
echo "################################################"
echo "##USER :      $userbdd##########"
echo "################################################"
echo "##NOM:        $namebdd##########"
echo "################################################"
echo "##Ecran n°:   $idecran##########"
echo "################################################"


while true; do
    echo "#Pour Modifier la plage horaire rendez vous dans le ./Documents/configuration/ini/config.ini"
    read -p "Voulez vous configurer la plage horraire maintenant ? (yes ou no)" yn
    case $yn in
        [Yy]* ) echo "\n\n\n"; sh confplage.sh ; break;;
        [Nn]* )
               break;;
        * ) echo "Repondre yes ou no.";;
    esac
done

cp /home/pi/Documents/configuration/ini/config.ini /var/www/afficheur/ | sed -i 's/\#/\;/g' /var/www/afficheur/config.ini;

echo "\n#C'est fait Vous pouvez fermer le programme"
