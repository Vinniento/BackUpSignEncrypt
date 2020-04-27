################################################################
#Author: Vincent Schauer                                       #
#Date: 24.04.2020                                              #
#                                                              #
#                                                              #
################################################################

###What is the purpose?###
	--Backing up directories, signing and encrypting them with openssl
	--playing around with symmetric and asymmetric encryption

###How is it used?###
    	--you need to have openssl installed!
	--Run in terminal in same dir as restore_backup.sh. 
	--No root permissions needed, if staying in the own directories of logged in user. 
	--Follow instructions given in terminal

###Which is the expected output?###
	The output should look somthing like this:
	-------------------------------BEGIN OF EXAMPLE OUTPUT------------------------------------

	➜  lab5 ./backup.sh
	--------------------------------------
	specify the path to the user that should be backed up, otherwise /home/user will be backed up as default. Although it is designed for user backups, it also works for any directory which is targeted. 
	/home/vince
	--------------------------------------
	directory found
	--------------------------------------
	compressing filePath = /tmp/vince_2020-04-24_12:41:42.tar.gz ------- what? == /home/vince
	--------------------------------------
	Details for /tmp/vince_2020-04-24_12:41:42.tar.gz
	  File: /tmp/vince_2020-04-24_12:41:42.tar.gz
	  Size: 5424      	Blocks: 16         IO Block: 4096   regular file
	Device: 10306h/66310d	Inode: 1576935     Links: 1
	Access: (0644/-rw-r--r--)  Uid: ( 1000/  oliver)   Gid: ( 1000/  oliver)
	Access: 2020-04-24 12:41:47.181072151 +0200
	Modify: 2020-04-24 12:41:47.173072161 +0200
	Change: 2020-04-24 12:41:47.173072161 +0200
	 Birth: -
	-rw-r--r-- 1 oliver oliver 5,3K Apr 24 12:41 /tmp/vince_2020-04-24_12:41:42.tar.gz
	 dirs | files in /home/vince :  5 |  9 
	 dirs | files in /tmp/vince_2020-04-24_12:41:42.tar.gz :  5 | 9 
	--------------------------------------
	Backup successfull
	--------------------------------------
	Encryption done!
	Encrypted file: /tmp/vince_2020-04-24_12:41:42.tar.gz.enc
	--------------------------------------
	Signing done!
	Signature file: signature_vince_2020-04-24_12:41:42.tar.gz
	--------------------------------------
	Items backuped so far (backing up another user will still add to the total sum of all items!): 
	--------------------------------------
	Files = 9 
	--------------------------------------
	Dirs = 5 
	--------------------------------------
	Users = 1 
	would you like to backup another folder? y/n


----------------------------------END OF EXAMPLE OUTPUT-------------------------------------------

	Expected File output: signed and encrypted tar.gz.enc file (see example output for file name details)

###Which standards were used?###
	Not followed by detail but usage of following standards:
	--RFC 3447: Public-Key Cryptography Standards (PKCS) #1: RSA Cryptography Specifications Version 2.1
	--RFC 3394: Advanced Encryption Standard (AES) Key Wrap Algorithm




