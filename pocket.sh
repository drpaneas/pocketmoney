#!/bin/bash
i=1
host=http://linuxed.gr/script/
str=links
extension=.txt
day=1
addr=drpaneas@gmail.com
while true
do
    echo
    # Check how many times
    if [[ "$i" == 13 ]]
    then
	# Script ran 12 times sucessfully. This is 24 hours (theoretically)
        echo "Day $day out!"
	echo "\   /"
	echo " \ / "
	echo "  |  " 
        day=$(( $day + 1 ))
        i=1

	# Send email
	ora=`date +%H:%M:%S`
	echo "Script ran 12 times successfully. Time $ora and day $day " > message.txt
	cat message.txt | mail -s "PocketMoney $day" $addr
	echo "Στάλθηκε mail στο $addr"
    else
	# Script ran less than 12 times (during the day, still has work to do)
        # Κατέβασε τα links
        file=`echo $str$i$extension`
        url=`echo $host$file`
        wget $url -q -O links_new.txt

	# Τσέκαρε αν το κατέβασες σωστά
        if [ $? -eq 0 ]
	then
	    echo "New links fetched from $url ! Database has been updated!"
	    mv links_new.txt links.txt
        else
	    echo "I COULDN'T !!!! fetch the new links from $url "
	    echo "I will use the OLD links again"
	fi
        
	echo "This is the $i time running..."
	echo "============================================================="
        sleep 1
	sh ./money.sh
	
	# Πάμε ξανά
        i=$(($i +1))
    fi
    echo
done
