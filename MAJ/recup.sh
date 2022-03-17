#######Recuperation des variables dans le ini##########################


##BDD##
hostbdd=$(grep "hostbdd" config.ini |  sed -e 's/hostbdd\=\([[:alnum:]]\)/\1/g')
userbdd=$(grep "userbdd" config.ini |  sed -e 's/userbdd\=\([[:alnum:]]\)/\1/g')
passbdd=$(grep "passbdd" config.ini |  sed -e 's/passbdd\=\([[:alnum:]]\)/\1/g')
namebdd=$(grep "namebdd" config.ini |  sed -e 's/namebdd\=\([[:alnum:]]\)/\1/g')
idecran=$(grep "idecran" config.ini |  sed -e 's/idecran\=\([[:alnum:]]\)/\1/g')
######

##Horaire##
heurefixe=$(grep "heurefixe" config.ini |  sed -e 's/heurefixe\=\([[:alnum:]]\)/\1/g')
minutesmaj=$(grep "minutesmajj" config.ini |  sed -e 's/minutesmajj\=\([[:alnum:]]\)/\1/g')
heuresmaj=$(grep "heuresmajj" config.ini |  sed -e 's/heuresmajj\=\([[:alnum:]]\)/\1/g')
joursmaj=$(grep "joursmajj" config.ini |  sed -e 's/joursmajj\=\([[:alnum:]]\)/\1/g')

########
