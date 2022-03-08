#!/bin/bash  
echo "Gatt Louis"
echo "############################################"
echo "####Ajout d'un ecran par shell##############"
echo  "############################################\n\n"
echo "#<!>CE SCRIPT NE FONCTIONNE QU'AVEC LA BASE DE DONNEE FOURNIS"
echo "#Merci de renseigner au mieux les champs qui vous seront demandés"
echo "#En cas d'erreur vous pouvez arreter ce script à tout moment"
echo  "#Merci de ne pas entrer un ID_ecran déjà occupé\n\n"

echo "####Début######\n\n"
echo "#l'host est l'ip ou le dns de votre bdd: x.x.x.x"
echo "-Entrer l'hote : "  
read hostbdd


echo "\n#Utilisateur autorisé à acceder à la base de donnée"
echo "-Entrer l'utilisateur de la bdd : "
read userbdd

echo "\n#Mettre le mot de passe en clair de la bdd"
echo "-Entrer le mot de pase de la bdd : "
read -r passbdd

echo "\n#Nom de la base de donnée à utiliser"
echo "-Entrer le Nom de la bdd : "
read namebdd

mysql -h$hostbdd -u$userbdd --password="$passbdd" $namebdd -e 'SELECT * FROM ecran'

echo "\n#Attribuer un nouvel ID_Ecran dans la bdd pour l'ajout de l'ecran "
echo "<!> AUTRE QUE CEUX CI DESSUS <!>"
echo "-Entrer l'id_ecran souhaité : "
read idecran

echo "\n#Nommer le lieu du nouvel ecran"
echo "<!> AUTRE QUE CEUX CI DESSUS <!>"
echo "-Entrer le lieu souhaité : "
read lieu



echo "\n#Le nouvel ecran est actif immediatement=yes"
echo "#Le nouvel ecran n'est pas actif immediatement=no"
while true; do
    read -p "Le nouvel écran est-il actif ?(yes ou no)" yn
    case $yn in
        [Yy]* ) actif=1 ; break;;
        [Nn]* ) actif=0 ; break;;
        * ) echo "Repondre yes ou no.";;
    esac
done

mysql -h$hostbdd -u$userbdd --password="$passbdd" $namebdd -e "INSERT INTO ecran (ID_ecran, Actif, Nom) VALUES ("$idecran","$actif", '"$lieu"')"

mysql -h$hostbdd -u$userbdd --password="$passbdd" $namebdd -e 'SELECT * FROM ecran'


echo "\n#C'est fait Vous pouvez fermer le programme"
exit;