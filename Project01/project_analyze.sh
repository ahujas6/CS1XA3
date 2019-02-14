
cd ..
echo "function options"
echo "press 1 to create merge log"
echo "press 2 to create todo log"

read ans
if [ "$ans" -eq "1" ] ; then
	git log --oneline >>  temp.txt
	grep -i "merge" temp.txt  >> temp2.txt
	rm temp.txt
	cut -d " "  -f1 temp2.txt >> ~/CS1XA3/Project01/merge.log
	rm temp2.txt

elif [ "$ans" -eq "2" ] ; then
	touch ~/CS1XA3/Project01/todo.log
	grep -r "#TODO" --exclude={todo.log,project_analyze.sh} ~/CS1XA3 >> ~/CS1XA3/Project01/todo.log 

else
	echo "failed"
fi
