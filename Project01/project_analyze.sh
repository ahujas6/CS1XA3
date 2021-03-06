
cd ..
echo "function options"
echo "press 1 to create merge log"
echo "press 2 to create todo log"
echo "press 3 to decrypt or encrypt a file"

read ans
#the code writes log on temp.txt and then write the lines having merge and then cut it and type it in main merge.log and in the end delete both temp files
if [ "$ans" -eq "1" ] ; then
	git log --oneline >>  temp.txt
	grep -i "merge" temp.txt  >> temp2.txt
	rm temp.txt
	cut -d " "  -f1 temp2.txt >> ~/CS1XA3/Project01/merge.log
	rm temp2.txt
# it greps #TODO from files and write it in  a file todo.log
elif [ "$ans" -eq "2" ] ; then
	touch ~/CS1XA3/Project01/todo.log
	grep -r "#TODO" --exclude={todo.log,project_analyze.sh,README.md} ~/CS1XA3 >> ~/CS1XA3/Project01/todo.log 
	
	
elif [ "$ans" -eq "3" ] ; then
	echo "press 1 to encrypt"
	echo "press 2 to decrypt"
	read a1
# it encrypt a file using gpg and delete the orignal file too
	if [ "$a1" -eq "1" ] ; then
		echo "enter file name"
		read file
		gpg -c "$file"
		echo "file encrypted"
		echo "deleting orignal file"
		rm "$file"
#it decrypts file with .gpg and prints it results and also puts it in new file
	elif [ "$a1" -eq "2" ] ; then
		echo "enter file name"
                read file
		gpg --decrypt "$file"
		echo "putting decryted  text in file"
		gpg --output "$file" --decrypt "$file"
		
		echo "data decryted"
	else 
		echo "failed "
	fi
else
	echo "failed"
fi
