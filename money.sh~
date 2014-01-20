#!/bin/bash
# Coded by drpaneas
########################################################################################
# Shorten Links hack! Earn Money Script for Ubuntu                                     #
# sudo apt-get install mailutils ssmtp                                                 #
# Στο mail βάλε (κατά την εγκατάσταση) επέλεξε Internet και το άλλο desktop (default)  #
# Ρύθμισε το ssmtp (/etc/ssmtp/ssmtp.conf) και /etc/ssmtp/revaliases σύμφωνα           #
# με τις οδηγιες: http://www.nixtutor.com/linux/send-mail-with-gmail-and-ssmtp/        #
# Φτιάξε τα αρχεία: links.txt vpns.txt                                                 #
########################################################################################

# Σέταρε τους χρόνους
# οι τιμές είναι σε μονάδα second (δευτερόλεπτα)
########################################################################################
# Χρόνος μεταξύ των links
link_time=105

# Χρόνος μεταξύ των VPNs
vpn_time=60

# Χρόνος πριν ξεκινήσει το VPN (χρειάζεται κάποια δευτερόλεπτα να 'νιώσει' την IP)
vpn_boot_time=60

# Χρόνος στην πρώτη αποτυχία
fail_time_1=300

# Χρόνος στην δεύτερη αποτυχία
fail_time_2=7200

# Χρόνος στην τρίτη αποτυχία
fail_time_3=360000

#########################################################################################

# Δώσε την διεύθυνση e-mail που θα σε ενηρώνει για προβλήματα (ή και επιτυχίες)
addr=drpaneas@gmail.com

#########################################################################################

# Γράψε μία λίστα με links και αποθήκευσέ τα ως 'links.txt'
links="links.txt"

##########################################################################################

# Α Π Ο   Ε Δ Ω   Κ Α Ι    Κ Α Τ Ω     - - -      Μ Η Ν   Π Ε Ι Ρ Α Ξ Ε Ι Σ   Τ Ι Π Ο Τ Α

##########################################################################################


is_VPN_connected(){
    if grep --quiet "Connection activated" response.txt
    then
        return 0 # True
    else
        return 1 # False
    fi
}


# Φτιάχνω την λίστα με τα VPNs που έχω ήδη ρυθμήσει στον Network Manager
# και τα αποθηκεύω στο αρχείο 'vpns.txt'
nmcli con | grep vpn | awk '{ print $1 }' > vpns.txt
vpn_connections="vpns.txt"

# Χρησιμοποιήσε μία 'σημαία' για βοήθεια
flag=0

# Κράτα ρολόι
ora=`date +%H:%M:%S`



# Εκκίνηση
while read -r connection_name
do
    # Δοκιμάζω να συνδεθώ σ'ένα VPN
    vpn=$connection_name
    echo "Trying to connect as $vpn VPN"

    # Πραγματοποίηση σύνδεσης
    nmcli con up id $vpn > response.txt

    # Ελεγχος σύνδεσης
    if is_VPN_connected
    then
	# Αν η σύνδεση είναι επιτυχημένη, βγάλε χρήμα!
        echo "VPN $vpn has been successfully connected"
	echo "----------------------------------------"

	# Αν απέτυχε προηγουμένως, ας το ξεχάσουμε αφού πέτυχε τώρα
	if [ "$flag" -gt 0 ]
	then
	    ora=`date +%H:%M:%S`
	    echo "ΕΝΗΜΕΡΩΣΗ: Αν και απέτυχε προηγουμένως για $flag φορά, τώρα στις $ora είναι ok"

	    # Στείλε mail να ενημερώσεις ότι διορθώθηκε το πρόβλημα
	    ora=`date +%H:%M:%S`
	    echo "Αν και απέτυχε προηγουμένως για $flag φορά, τώρα στις $ora είναι ok. " > message.txt
	    cat message.txt | mail -s "Το πρόβλημα διορθώθηκε" $addr
	    echo "Στάλθηκε mail στο $addr"

	    # Δήλωσε ξανά την σημαία = 0 -- αφού δεν υπάρχει πρόβλημα
	    flag=0
	fi
	
	# Πριν ξεκινήσεις το browsing, περίμενε λίγο να πάρει μπρος ο VPN
	echo "Συνδέθηκες! Τώρα περίμενε $vpn_boot_time sec ... να νιώσει o router την νέα IP του VPN $vpn"
	sleep $vpn_boot_time
	
	# Ξεκίνα να κάνεις browse τα shorten links
    	while read -r line
    	do
	    # Διάβασε το x,y,z link από το αρχείο 'links.txt'
            link=$line

	    # Ενημέρωσε με μήνυμα σε ποιο link βρίσκεσαι και με ποιο VPN
	    ora=`date +%H:%M:%S`
            echo "$ora  ::  Browsing at - $link - using $vpn"
	
            # Άνοιξε το link σε νέο Tab του Firefox (όχι παράθυρο)
	    firefox -new-tab $link &

	    # Περίμενε κάποιο χρόνο μεταξύ των links 
	    sleep $link_time

	    # Όσο υπάρχουν κι άλλα links, συνέχισε το loop
    	done < "$links"

	# Αφού τελείωσες με όλα τα links, κλείσε τον firefox (σιγουρέψου ότι δεν κάνει restore)
    	# αλλάζοντας ρυθμήσεις στο about:config (ψάξε για το resume και κανε το false)
    	pkill -9 firefox

	# Αφού ολοκληρώθηκαν όλα τα links με τον συγκεκριμένο VPN
	ora=`date +%H:%M:%S`
	echo "ΕΝΗΜΕΡΩΣΗ: Ο VPN $vpn ολοκλήρωσε τις επισκέψεις σε όλα τα links ( $ora )"

	# Κλείσε την σύνδεση με τον συγκεκριμένο VPN
	nmcli con down id $vpn > response.txt

	# Αναμονή μεταξύ της εναλλαγής των VPN
	echo "Περίμενε... όσο τον αποσυνδέω..."
	sleep $vpn_time
	echo
    else
	# Αν η σύνδεση απέτυχε
	# Μέτρα πόσες φορές απέτυχε στην σειρά
	flag=$(( $flag + 1 ))

	# Αν είναι η πρώτη φορά που απέτυχε
	if [ "$flag" -eq 1 ]
	then
	    echo "VPN $vpn connection failed"
	    echo "Είναι η $flag φορά που απέτυχε η σύνδεση."

	    # Πες του ότι θα περιμένει καποια ώρα μέχρι την επόμενη προσπάθεια
	    ora=`date +%H:%M:%S`
	    echo "Θα περιμένεις $fail_time_1 sec μέχρι την επόμενη προσπάθεια ( τώρα είναι $ora )"

	    # Στείλε μου mail
	    ora=`date +%H:%M:%S`
	    echo "Απέτυχε για 1η φορά. Πρόβλημα στον $vpn στις $ora" > message.txt
	    cat message.txt | mail -s "Αποτυχία 1" $addr
	    echo "Στάλθηκε mail στον Πάνο"

	    # Περίμενε μπας και φτιάξει
	    sleep $fail_time_1
	fi

	# Αν είναι η 2η φορά που απέτυχε στην σειρά
	if [ "$flag" -eq 2 ]
	then
	    # Εμφάνισε μήνυμα ότι κάτι δεν πάει καλά
	    echo "VPN $vpn connection failed"
	    echo "Είναι η $flag φορά που απέτυχε η σύνδεση."

	    # Πες του ότι θα περιμένει καποια ώρα μέχρι την επόμενη προσπάθεια
	    ora=`date +%H:%M:%S`
	    echo "Θα περιμένεις $fail_time_2 sec μέχρι την επόμενη προσπάθεια ( τώρα είναι $ora )"

	    # Στείλε μου mail
	    ora=`date +%H:%M:%S`
	    echo "Απέτυχε για 2η φορά. Πρόβλημα στον $vpn στις $ora" > message.txt
	    cat message.txt | mail -s "Αποτυχία 2" $addr
	    echo "Στάλθηκε mail στον Πάνο"

	    # Περίμενε μπας και φτιάξει
	    sleep $fail_time_2
	fi

	# Αν είναι η 3η φορά που απέτυχε στην σειρά
	if [ "$flag" -eq 3 ]
	then
	    # Εμφάνισε μήνυμα ότι κάτι δεν πάει καλά
	    echo "VPN $vpn connection failed"
	    echo "Είναι η $flag φορά που απέτυχε η σύνδεση."

	    # Πες του ότι θα περιμένει καποια ώρα μέχρι την επόμενη προσπάθεια
	    ora=`date +%H:%M:%S`
	    echo "Θα περιμένεις $fail_time_3 sec μέχρι την επόμενη προσπάθεια ( τώρα είναι $ora )"

	    # Στείλε μου mail
	    ora=`date +%H:%M:%S`
	    echo "Απέτυχε για 3η φορά. Πρόβλημα στον $vpn στις $ora" > message.txt
	    cat message.txt | mail -s "Αποτυχία 3" $addr
	    echo "Στάλθηκε mail στον Πάνο"

	    # Περίμενε μπας και φτιάξει
	    sleep $fail_time_3
	fi   

    # Δοκίμασε να συνδεθείς ξανά, συνεχίζοντας το loop με άλλον VPN
    fi

# Σβήσε το αρχείο που κρατάει τα logs για την σύνδεση με τον συγκεκριμένο VPN
rm response.txt

# Συνέχισε στον επόμενο VPN
echo "Βάλε μπρος τον επόμενο VPN"

done < "$vpn_connections"

# Τελος με τα VPN
ora=`date +%H:%M:%S`
echo "Τελείωσα την δουλειά! Όλα τα links με όλους τους VPN. H ώρα είναι $ora"

# Τώρα κάνε browse με την κανονική IP
# Ξεκίνα να κάνεις browse τα shorten links
while read -r line
do
    # Διάβασε το x,y,z link από το αρχείο 'links.txt'
    link=$line

     # Ενημέρωσε με μήνυμα σε ποιο link βρίσκεσαι και με ποιο VPN
     ora=`date +%H:%M:%S`
     echo "$ora  ::  Browsing at - $link - using $vpn"
	
     # Άνοιξε το link σε νέο Tab του Firefox (όχι παράθυρο)
     firefox -new-tab $link &

     # Περίμενε κάποιο χρόνο μεταξύ των links 
     sleep $link_time

     # Όσο υπάρχουν κι άλλα links, συνέχισε το loop
done < "$links"

# Τελείωσες οριστηκά
ora=`date +%H:%M:%S`
echo "Τελείωσα και με την αληθινή IP . H ώρα είναι $ora"

# Σκοτωσε και τον Firefox
pkill -9 firefox








