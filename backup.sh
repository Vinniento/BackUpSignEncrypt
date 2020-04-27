#!/bin/bash
#vincent schauer



BACKUP_DIR="/tmp"
user=${USER}

backupAnother="y"
let nrFilesAlltogether=0
let nrDirsAlltogether=0
let nrUsersAlltogether=0

echoSomething() {
echo "--------------------------------------" &&
echo "$1" 


}

#get number of files in dir
nrFiles (){
    if [[ $1 == backup ]]
    then
        tar -tvf $2 | grep '^-' | wc -l
    else
        find $2 -type f | wc -l
    fi
}
#get number of dirs in dir
nrDirectories (){

if [[ $1 == backup ]]
	then
		
		tar -tvf $2 | grep '^d' | wc -l

	else
		find $2 -type d | wc -l
	fi

}
addUpItems() {
	((nrDirsAlltogether+=$1))
	((nrFilesAlltogether+=$2))
	((nrUsersAlltogether+=1))
}

compareNumbers () {

	if [[ ($1 == $2) && ($3 == $4) ]]
	then
		echoSomething "Backup successfull"
		addUpItems $1 $3
		
		
	else
		echoSomething "Backup failed, these files and dirs weren not t added to the total sum of numbers!!"
	fi
	
}

#could be implemented if users weren't allowed to be backuped twice
#declare -a backupedUsers
#checkIfUserAlreadyWasBackuped() {

#}

encrypt() {
	#keypair
	if [ ! -f private.key ]
	then	
		openssl genrsa -out private.key 1024
		openssl rsa -in private.key -pubout -out public.key
	fi

	#symmetric encryption. Encrypting with public key
	#tar -tvf $1 |
	openssl aes-256-cbc -pbkdf2 -salt -in $1 -out $1.enc -pass file:public.key
	echoSomething "Encryption done!"
	rm $1
	echo "Encrypted file: $1.enc"

fileName=${1##*/}
	#asymmetric sign with private key
	openssl dgst -sha256 -sign private.key -out signature_${fileName} $1.enc
	echoSomething "Signing done!"
	echo "Signature file: signature_${fileName}"
}



#backs up dir; firstArg = directory to be backuped, secondArg = backuped dest
backupDir() {
date=$(date '+%Y-%m-%d_%H:%M:%S');

	read homeDir
	fileName=${USER}_$date #.tar.gz
	#set path and file names
	if [[ -d $homeDir ]]
	then
		echoSomething "directory found"
		toBeBackedUp=$homeDir
		backupFilePath="$BACKUP_DIR/${homeDir##*/}_$date.tar.gz"
	else
		echoSomething "the specified directory $homeDir doesn't exist. The default will be backuped"
		toBeBackedUp="/home/${USER}"
		backupFilePath="$BACKUP_DIR/${USER}_$fileName_$date.tar.gz"
		
	fi
	
	

	#zcpfv for output
	echoSomething "compressing filePath = $backupFilePath ------- what? == $toBeBackedUp"
	#cd $toBeBackedUp && tar -zcvf $backupFilePath * #überprüft, wird richtig compressed
	tar -zcf $backupFilePath $toBeBackedUp 2>/dev/null	
	nrDirBefore=$( nrDirectories notBackup $toBeBackedUp )
	nrDirAfter=$( nrDirectories backup $backupFilePath )
	nrFilesBefore=$( nrFiles notBackup $toBeBackedUp)
	nrFilesAfter=$( nrFiles backup $backupFilePath)
	
	echoSomething "Details for $backupFilePath"
	stat $backupFilePath
	ls -lh $backupFilePath 

	echo " dirs | files in $toBeBackedUp :  $nrDirBefore |  $nrFilesBefore " &&
	echo " dirs | files in $backupFilePath :  $nrDirAfter | $nrFilesAfter "
	
	compareNumbers $nrDirBefore $nrDirAfter $nrFilesBefore $nrFilesAfter
	

	

	encrypt $backupFilePath 

 


}


echoSomething "specify the path to the user that should be backed up, otherwise /home/user will be backed up as default. Although it is designed for user backups, it also works for any directory which is targeted. "
while [[ $backupAnother == "y" ]]
do
	backupDir $userInputBackup
	echoSomething "Items backuped so far (backing up another user will still add to the total sum of all items!): "
	echoSomething "Files = $nrFilesAlltogether "
	echoSomething "Dirs = $nrDirsAlltogether "
	echoSomething "Users = $nrUsersAlltogether "

	echo "would you like to backup another folder? y/n"
	read backupAnother
done

