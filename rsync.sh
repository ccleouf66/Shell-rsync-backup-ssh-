#!/bin/bash

todayDate="$(date +%d-%m-%Y)";
logFile="./log.txt";
mail="mail@gamil.com";

localPath="/home/cyril/Documents/Test_save/";
destinationServer="USER@HOST:/home/cyril/Test_save";

echo "------------------------ Sauvegarde du $todayDate -------------------" >> $logFile;
echo "[$todayDate $(date +%k:%M:%S)] Debut de la sauvegarde" >> $logFile;

rsync -Haurov --stats -e "ssh -p SERVER_PORT" $localPath $destinationServer|tee -a $logFile;

echo "[$todayDate $(date +%k:%M:%S)] Fin de la sauvegarde" >> $logFile;
mutt -s "Script de sauvgarde" -a $logFile -- $mail < /dev/null;


###### sécurité ##############################################################
#                                                                          ###
#il faut générer une clef rsa public sur le serveur local                  ###
#pour l'envoyer vers le serveur distant (qui stock les sauvegardes)        ###
#                                                                          ###
##On génère la clef (serveur local)                                        ###
# ssh-keygen -t dsa -b 1024                                                ###
#                                                                          ###
#On envoie la clef au serveur distant                                      ###
# ssh-copy-id -i /root/.ssh/id_dsa.pub -p SERVER_PORT USER@HOST            ###
#                                                                          ###
##############################################################################