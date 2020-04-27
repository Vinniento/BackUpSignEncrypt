################################################################
#Author: Vincent Schauer                                       #
#Date: 24.04.2020                                              #
#                                                              #
#                                                              #
################################################################

###What is the purpose?###
	--Decrypting, verifying file with openssl

###How is it used?###
    --you need to have openssl installed
	--Run in terminal. 
	--Path of encrypted and signed file must be given as argument
	--file to be decryped must be in /tmp/ (it is created there anyway!)
	--Must be in same folder as backup.sh	
	--No root permissions needed, if staying in the own dir. 
	--signature file must be left in same folder as backup.sh and decrypt.sh (it is created there anyway)

###Which is the expected output?###
	The output should look somthing like this:
	-------------------------------BEGIN OF EXAMPLE OUTPUT------------------------------------
	
	➜  lab5 ./decrypt.sh /tmp/vince_2020-04-24_13:12:38.tar.gz.enc
	--------------------------------------
	Filename = vince_2020-04-24_13:12:38.tar.gz.enc
	signature_vince_2020-04-24_13:12:38.tar.gz
	--------------------------------------
	Verfification success
	verified file: vince_2020-04-24_13:12:38.tar.gz.enc
	--------------------------------------
	Decryption done
	Decrypted file: vince_2020-04-24_13:12:38.tar.gz
	--------------------------------------
	Would you like to delete the encrypted folder? yes/no




	----------------------------------END OF EXAMPLE OUTPUT-----------------------------------

	Expected file output: Verified and decrypted tar.gz file (see example output for file name details)

###Which standards were used?###
	Not followed by detail but used AES
	RFC 3394: Advanced Encryption Standard (AES) Key Wrap Algorithm



