arr[0]="delhi"
arr[1]="chennai"
arr[2]="kolkata"
arr[3]="mumbai"
arr1[0]="yahoo.com"
arr1[1]="gmail.com"
arr1[2]="hotmail.com"
arr1[3]="rediffmail.com"
for (( i=0; i<=$1; i++)) 
do
ran=$[$RANDOM%3]
city=${arr[$ran]}
POS=0  # Starting from position 0 in the string.
LEN=8  # Extract eight characters.
str1=$( echo "$i" | md5sum )
usern="${str1:$POS:$LEN}"
#echo =</dev/urandom tr -dc A-Za-z0-9_ | head -c8
ran1=$RANDOM%3
hostn=${arr1[$ran1]}
echo "$usern@$hostn $city $((1000000000 + $RANDOM%1000000000))">>subsscribers.txt
done