#!/bin/bash
#vincent schauer

echoSomething() {
echo "--------------------------------------" &&
echo "$1" 

}

decrypt(){
fileName=${1##*/}
echoSomething "Filename = $fileName"
sign_fileName=signature_$(echo "$fileName" | rev | cut -c 5- | rev)
echo $sign_fileName
    verify=$(openssl dgst -sha256 -verify public.key -signature $sign_fileName "/tmp/$fileName")
verifiedOK="Verified OK"
    if [ "$verify" == "$verifiedOK" ]
    then
        echoSomething "Verfification success"
	echo "verified file: $fileName"
        #decrypt
        renamed=$(echo "$fileName" | cut -f 1 -d '.')
        openssl aes-256-cbc -pbkdf2 -salt -d -in /tmp/$fileName -out $renamed.tar.gz -pass file:public.key
        echoSomething "Decryption done"
	echo "Decrypted file: $renamed.tar.gz"
	echoSomething "Would you like to delete the encrypted folder? yes/no"
	read input
	if [ $input == "yes" ]
	then
		rm /tmp/$fileName
	fi
    else
        echoSomething "Verfification failed"
    fi
}

if [ $# -eq 0 ]
  then
    echoSomething "!!No arguments supplied. Please supply the filepath of the file you'd like to decrypt!! It must be in /tmp/"
fi
decrypt $1
