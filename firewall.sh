#!/bin/bash

cat $1 >> temp.txt
echo >> temp.txt 
cat /dev/stdin >> temp2.txt
touch output.txt

while read line; do
	#echo $line
	if [[ $line =~ ^([ ])*([#])+.*$ ]] ;
		then continue;
		#else echo 0;
	elif [ -z "$line" ] ;
		then continue;
	fi

	line=$(echo $line | cut -d '#' -f1)

	IFS=',' read -ra PATS <<< "$line"
	(cat temp2.txt | \
       ./firewall.exe "${PATS[0]}" 2>/dev/null | \
       ./firewall.exe "${PATS[1]}" 2>/dev/null| \
       ./firewall.exe "${PATS[2]}" 2>/dev/null| \
       ./firewall.exe "${PATS[3]}" 2>/dev/null >> output.txt)

done < temp.txt

#cat output.txt
cat output.txt | sort | uniq >> mid_output.txt

while read line; do
	echo $line | tr -d ' ' >> final_output.txt
done < mid_output.txt

cat final_output.txt
rm output.txt mid_output.txt final_output.txt temp.txt temp2.txt