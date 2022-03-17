#!/bin/bash
#Gatt Louis dev

source recup.sh

rm Jour/Lundi.txt
rm Jour/Jeudi.txt
rm Jour/Vendredi.txt 
rm Jour/Samedi.txt
rm Jour/Mardi.txt
rm Jour/Dimanche.txt
rm Jour/Mercredi.txt
rm maj.tsv
rm traitement.txt


#Recuperation de la date du jour

date=$(date +%F)


echo -e "$(date -u "+[%Y-%m-%d | %H:%M:%S]:")\n############################################\n##########Debut de la mise à jour###########\n############################################"

###
#Recuperation du contenu de la bdd

mysql -h$hostbdd -u$userbdd --password="$passbdd" $namebdd -e 'SELECT veille FROM veille WHERE ID_ecran='$idecran' ORDER BY DATEDEBUT<='$date' DESC LIMIT 1' >maj.tsv
sed 1d maj.tsv -i

####Si la bdd n'a pas pu être trouvé 
if [[ ! -f maj.tsv ]]
	then
		echo -e "$(date -u "+[%Y-%m-%d | %H:%M:%S]:") #/!\/!\Une erreur est survenue au moment de chercher la table Veille\nMerci de verifier les identifiants de la bdd dans le ./config.ini"
fi

#####
#Debut du script de lecture##

plage=`cat maj.tsv`
TESTSTR=$plage

for i in $(echo $TESTSTR |  tr '/' '\n')
do
echo $i >>traitement.txt
done
##Ecritures des plages dans txt




###############################################VERIFICATION DES DONNEES PAR JOURS####################################################

if h=$(grep "L\([^A-Za-z0-9_-]\|$\)" traitement.txt); then
        heure=$(tr -d "\n" <<< "$h")

        IFS=* read -r values <<< $heure
                for v in "${values[@]}"
                do
                         echo $v |  tr 'L' '%' >>Jour/Lundi.txt  
        done

fi

if h=$(grep "M\([^A-Za-z0-9_-]\|$\)" traitement.txt); then
        heure=$(tr -d "\n" <<< "$h")

        IFS=* read -r values <<< $heure
                for v in "${values[@]}"
                do
                         echo $v |  tr 'M' '%' >>Jour/Mardi.txt
        done

fi

if h=$(grep "Me\([^A-Za-z0-9_-]\|$\)" traitement.txt); then
        heure=$(tr -d "\n" <<< "$h")

        IFS=* read -r values <<< $heure
                for v in "${values[@]}"
                do
                         echo $v |  tr 'Me' ' %' >>Jour/Mercredi.txt
        done

fi

if h=$(grep "J\([^A-Za-z0-9_-]\|$\)" traitement.txt); then
        heure=$(tr -d "\n" <<< "$h")

        IFS=* read -r values <<< $heure
                for v in "${values[@]}"
                do
                         echo $v |  tr 'J' '%' >>Jour/Jeudi.txt
        done

fi

if h=$(grep "V\([^A-Za-z0-9_-]\|$\)" traitement.txt); then
        heure=$(tr -d "\n" <<< "$h")

        IFS=* read -r values <<< $heure
                for v in "${values[@]}"
                do
                         echo $v |  tr 'V' '%' >>Jour/Vendredi.txt
        done

fi

if h=$(grep "S\([^A-Za-z0-9_-]\|$\)" traitement.txt); then
        heure=$(tr -d "\n" <<< "$h")

        IFS=* read -r values <<< $heure
                for v in "${values[@]}"
                do
                         echo $v |  tr 'S' '%' >>Jour/Samedi.txt
        done

fi

if h=$(grep "D\([^A-Za-z0-9_-]\|$\)" traitement.txt); then
        heure=$(tr -d "\n" <<< "$h")

        IFS=* read -r values <<< $heure
                for v in "${values[@]}"
                do
                         echo $v |  tr 'D' '%' >>Jour/Dimanche.txt
        done

fi


############################################################################################################################
#####################################DEBUT DE L'ECRITURE DANS LE CRONTAB GESTIONNAIRE######################################

crontab -r

if [[ -f Jour/Lundi.txt ]]
	then
		IFS=,;
		cat ./Jour/Lundi.txt | sed -e 's/%\*/\n,/g' | sed -e 's/*$/:/g'| sed -e 's/\([0-9]\)\*/\1,/g'| while read -r -d ':' useless x y;  ##Mise en ordre des cat
				do
					(crontab -l | { cat; echo -e "* *${x[@]} * * 1 DISPLAY=":0" xset dpms force off \n* *${y[@]} * * 1 DISPLAY=":0" xset dpms force on \r"; }) | crontab -u pi -
					echo -e "$(date -u "+[%Y-%m-%d | %H:%M:%S]:") #L'ecran sera éteint ce LUNDI de ${x[@]}h à ${y[@]}h"
					
				done
fi



if [[ -f Jour/Mardi.txt ]]
	then
		IFS=,;
		cat ./Jour/Mardi.txt | sed -e 's/%\*/\n,/g' | sed -e 's/*$/:/g'| sed -e 's/\([0-9]\)\*/\1,/g'| while read -r -d ':' useless x y;
				do
					(crontab -l | { cat; echo -e "* *${x[@]} * * 2 DISPLAY=":0" xset dpms force off \n* *${y[@]} * * 2 DISPLAY=":0" xset dpms force on \r"; }) | crontab -u pi -
					echo -e "$(date -u "+[%Y-%m-%d | %H:%M:%S]:") #L'ecran sera éteint ce MARDI de ${x[@]}h à ${y[@]}h"
				done
fi

if [[ -f Jour/Mercredi.txt ]]
	then
		IFS=,;
		cat ./Jour/Mercredi.txt | sed -e 's/ //g'| sed -e 's/%\*/\n,/g' | sed -e 's/*$/:/g'| sed -e 's/\([0-9]\)\*/\1,/g' | while read -r -d ':' useless x y;
				do
					(crontab -l | { cat; echo -e "* *${x[@]} * * 3 DISPLAY=":0" xset dpms force off \n* *${y[@]} * * 3 DISPLAY=":0" xset dpms force on \r"; }) | crontab -u pi -
					echo -e "$(date -u "+[%Y-%m-%d | %H:%M:%S]:") #L'ecran sera éteint ce MERCREDI de ${x[@]}h à ${y[@]}h"
				done
fi

if [[ -f Jour/Jeudi.txt ]]
	then
		IFS=,;
		cat ./Jour/Jeudi.txt | sed -e 's/%\*/\n,/g' | sed -e 's/*$/:/g'| sed -e 's/\([0-9]\)\*/\1,/g'| while read -r -d ':' useless x y;
				do
					(crontab -l | { cat; echo -e "* *${x[@]} * * 4 DISPLAY=":0" xset dpms force off \n* *${y[@]} * * 4 DISPLAY=":0" xset dpms force on \r"; }) | crontab -u pi -
					echo -e "$(date -u "+[%Y-%m-%d | %H:%M:%S]:") #L'ecran sera éteint ce JEUDI de ${x[@]}h à ${y[@]}h"
				done
fi

if [[ -f Jour/Vendredi.txt ]]
	then
		IFS=,;
		cat ./Jour/Vendredi.txt | sed -e 's/%\*/\n,/g' | sed -e 's/*$/:/g'| sed -e 's/\([0-9]\)\*/\1,/g'| while read -r -d ':' useless x y;
				do
					(crontab -l | { cat; echo -e "* *${x[@]} * * 5 DISPLAY=":0" xset dpms force off \n* *${y[@]} * * 5 DISPLAY=":0" xset dpms force on \r"; }) | crontab -u pi -
					echo -e "$(date -u "+[%Y-%m-%d | %H:%M:%S]:") #L'ecran sera éteint ce VENDREDI de ${x[@]}h à ${y[@]}h"
				done
fi

if [[ -f Jour/Samedi.txt ]]
	then
		IFS=,;
		cat ./Jour/Samedi.txt | sed -e 's/%\*/\n,/g' | sed -e 's/*$/:/g'| sed -e 's/\([0-9]\)\*/\1,/g'| while read -r -d ':' useless x y;
				do
					(crontab -l | { cat; echo -e "* *${x[@]} * * 6 DISPLAY=":0" xset dpms force off \n* *${y[@]} * * 6 DISPLAY=":0" xset dpms force on \r"; }) | crontab -u pi -
					echo -e "$(date -u "+[%Y-%m-%d | %H:%M:%S]:") #L'ecran sera éteint ce SAMEDI de ${x[@]}h à ${y[@]}h"
				done
fi

if [[ -f Jour/Dimanche.txt ]]
	then
		IFS=,;
		cat ./Jour/Dimanche.txt | sed -e 's/%\*/\n,/g' | sed -e 's/*$/:/g'| sed -e 's/\([0-9]\)\*/\1,/g'| while read -r -d ':' useless x y;
				do
					(crontab -l | { cat; echo -e "* *${x[@]} * * 7 DISPLAY=":0" xset dpms force off \n* *${y[@]} * * 7 DISPLAY=":0" xset dpms force on \r"; }) | crontab -u pi -
					echo -e "$(date -u "+[%Y-%m-%d | %H:%M:%S]:") #L'ecran sera éteint ce DIMANCHE de ${x[@]}h à ${y[@]}h"
				done
fi



#####################################################################################################################################################################################

exec crontab -l | { cat; echo -e "*/$minutesmaj */$heuresmaj */$joursmaj * * cd /home/pi/Documents/MAJ/ && bash majscript.sh>>/home/pi/Documents/Logs/veille/$(date -u "+%Y-%m-%d").log"; } | crontab -u pi -;
exec crontab -l | { cat; echo -e "* *$heurefixe * * * DISPLAY=":0" xset dpms force off \n";}| crontab -u pi -;


echo -e "$(date -u "+[%Y-%m-%d | %H:%M:%S]:")\n###########################################\n############FIN de la mise à jour##########\n###########################################"

