#!/bin/bash  
echo "Gatt Louis"
echo "############################################"
echo "##CONFIGURATION DE LA PLAGE HORAIRE######"
echo  "############################################\n\n
dans var/www/afficheur/config.ini et Documents/configuration/ini/config.ini"

echo "#Merci de renseigner au mieux les champs qui vous seront demandés"
echo "#En cas d'erreur vous pouvez arreter ce script à tout moment"
echo "#En cas d'erreur la configuration du .ini peut se faire manuellement"

echo "####Début######\n\n"
echo "#Choisissez la plage horaire ou l'écran sera systematiquement éteint"
echo "#Ex: 19-8 (19h à 8h l'ecran sera éteint) 23-3 (23h à 3h l'ecran sera éteint) "
echo "-Entrer la plage horaire (format: 19-8) : "  
read plagefixe

find /home/pi/Documents/configuration/ini/config.ini -type f -exec sed -i 's/heurefixe\=.*/heurefixe\='$plagefixe'/g' {} \;


echo "\n\n#Choisissez la fréquence de mise à jour des plages horaires (laissez vide si non voulu)"
echo "\n#Par Défaut: minutesmaj=59; heuresmaj=0; joursmaj=0; (mise à jour toute les 59 minutes des heures)"
echo "\n#Exemple: minutesmaj=0; heuresmaj=2; joursmaj=0; mise à jour à 02h de la journée"
echo "#Exemple: minutesmaj=0; heuresmaj=2; joursmaj=4; mise à jour au 4e jour de la semaine"
echo "#Exemple: minutesmaj=30; heuresmaj=14; joursmaj=2; mise à jour tout les Mardi à 14h et 30 minutes"
echo "\n#Si vous vous trompez, une confirmation vous sera demandé, pas d'inquiétude"


while true; do

echo "\n\n#Renseignez le(s) minute(s) de la journée (MAX:59)"

read minutesmaj

echo "\n\n#Renseignez le(s) heure(s) de la journée (MAX:23)"

read heuresmaj

echo "\n\n#Renseignez le(s) jour(s) de la semaine (MAX:7)"

read joursmaj

if [ $joursmaj -eq 1 ]
then

$jour='Lundi'

fi

if [ $joursmaj -eq 2 ]
then

jour='Mardi'

fi

if [ $joursmaj -eq 3 ]
then

jour='Mercredi'

fi

if [ $joursmaj -eq 4 ]
then

jour='Jeudi'

fi

if [ $joursmaj -eq 5 ]
then

jour='Vendredi'

fi

if [ $joursmaj -eq 6 ]
then

jour='Samedi'

fi

if [ $joursmaj -eq 7 ] 
then

jour='Dimanche'
fi

echo "\n#LA raspberry se mettra à jour tout les "$jour" à "$heuresmaj"h et "$minutesmaj" minutes "
    read -p "\n\nEst-ce bien correct ? (yes ou no)" y

    if [ "$y" = "no" ]; then
    continue
  elif [ "$y" = "yes" ]; then
    echo "C'est Enregistré.\n"; break
  fi

  

done

find /home/pi/Documents/configuration/ini/config.ini -type f -exec sed -i 's/joursmajj\=.*/joursmajj\='$joursmaj'/g' {} \;
find /home/pi/Documents/configuration/ini/config.ini -type f -exec sed -i 's/heuresmajj\=.*/heuresmajj\='$heuresmaj'/g' {} \;
find /home/pi/Documents/configuration/ini/config.ini -type f -exec sed -i 's/minutesmajj\=.*/minutesmajj\='$minutesmaj'/g' {} \;
exit;