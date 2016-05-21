#cp -r ~/project/abc/1.0/code/ ~/project/abc/2.0/code/
# ~/project/abc/2.0/code/ -type f>file_listing.txt
#!/bin/bash
# Declare array
#declare -a ARRAY
# Link filedescriptor
exec 10<&0
# stdin replaced with a file supplied as a first argument
exec < subsscribers.txt
while read LINE; do
    i=0
    #sed -i '1s/1.0/2.0/' $LINE
    for WORD in $LINE; do
      if [ $i -eq $((1)) ]; then
        if [ $WORD == "chennai" ]; then
    echo $LINE >> chennai_subs.txt   
  fi
    fi 
    i=$(($i+1))
  done
done

#echo Number of elements: ${#ARRAY[@]}
# echo array's content
#echo ${ARRAY[@]}
# restore stdin from filedescriptor 10
# and close filedescriptor 10
exec 0<&10 10<&-

