#! /bin/bash

# On se positionne au bon endroit"
path=`dirname $0`
cd "$path"

# On défini les variables
#gitrepo="git@github.com:aaaaadrien/gentoo-config.git"
package="etc/portage/package."
jour=$(date +"%d-%m-%Y")
heure=$(date +"%H:%M:%S")

# Début du script

for fic in "use" "accept_keywords" "mask" "unmask" "env"
do
	chemin="etc/portage/package.$fic/"
	if [ -d "/$chemin" ]
	then
		echo "On sauvegarde le fichier package.$fic ..."
		
		if [ -d $chemin ]
		then
			rsync -a --delete "/$chemin/" "$chemin/"
		else
			mkdir -p "$chemin"
			rsync -a --delete "/$chemin/" "$chemin/"
		fi
	fi
done


chemin="etc/portage/env"
if [ -d "/$chemin" ]
then
        echo "On sauvegarde les fichiers perso env ..."
        if [ -d $chemin ]
        then
                rsync -a --delete "/$chemin/" "$chemin/"
        else
                mkdir -p "$chemin"
                rsync -a --delete "/$chemin/" "$chemin/"
        fi
fi

chemin="etc/portage/"
fic="make.conf"
if [ -f "/$chemin/$fic" ]
then
        echo "On sauvegarde le $fic ..."
        if [ -d $chemin ]
        then
                cp "/$chemin/$fic" "$chemin/$fic"
        else
                mkdir -p "$chemin"
                cp "/$chemin/$fic" "$chemin/$fic"
        fi
fi


chemin="etc/portage/repos.conf"
if [ -d "/$chemin" ]
then
        echo "On sauvegarde les fichiers repos ..."
        if [ -d $chemin ]
        then
                rsync -a --delete "/$chemin/" "$chemin/"
        else
                mkdir -p "$chemin"
                rsync -a --delete "/$chemin/" "$chemin/"
        fi
fi


chemin="var/lib/portage/"
fic="world"
if [ -f "/$chemin/$fic" ]
then
	echo "On sauvegarde la liste des applications installées..."
	if [ -f $chemin/$fic ]
	then
		cp "/$chemin/$fic" "$chemin/$fic"
	else
		mkdir -p "$chemin"
		cp "/$chemin/$fic" "$chemin/$fic"
	fi
fi


chemin="usr/src/linux/"
fic=".config"
if [ -f "/$chemin/$fic" ]
then
	echo "On sauvegarde la conf kernel..."
	if [ -f $chemin/$fic ]
	then
		cp "/$chemin/$fic" "$chemin/$fic"
	else
		mkdir -p "$chemin"
		cp "/$chemin/$fic" "$chemin/$fic"
	fi
fi



git add *
git commit -m "Mise à jour de la configutaion de Gentoo le $jour à $heure"
git push
