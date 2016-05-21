cp -r ~/project/abc/1.0/code/ ~/project/abc/2.0/code/
find ~/project/abc/2.0/code/ -type f>file_listing.txt
#!/bin/bash
# Declare array
#declare -a ARRAY
# Link filedescriptor
exec 10<&0
# stdin replaced with a file supplied as a first argument
exec < file_listing.txt
while read LINE; do
    sed -i '1s/1.0/2.0/' $LINE    
done

#echo Number of elements: ${#ARRAY[@]}
# echo array's content
#echo ${ARRAY[@]}
# restore stdin from filedescriptor 10
# and close filedescriptor 10
exec 0<&10 10<&-

