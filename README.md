pocketmoney
===========

A bash script that automatically earns you money from Shorten Links ads
Using this script as it is (take a look at the configuration bellow) it's going to give you about 1 dollar per day.
I know it's not enough money, but it good enough for a machine locked in a garage working 24/7. If you use more VPNs
the more the money you gonna earn. This is completely whitewhat hack, I don't steal or anything. This is just a clever
way to turn your computer into a money making machine.

WARNING: Use your links instead of mine or your PC will be working making money for me :P (lol)

###########################################################################
###  IF YOU LIKE THIS SCRIPT, DONATE AT MY PAYPAL:  drpaneas@gmail.com  ###
###########################################################################


Requirements
=============
1. Setup your VPNs (I am using Ubuntu Network Manager)
   sudo apt-get install pptpd
   
   If you are running Ubuntu over VirtualBox, make sure you set Network Adapter = Bridged (instead of NAT - default)
   
   Make sure you are able to connect to your VPNs manually before proceed. If you are n00b and you have no idea
   check this step-by-step guide at VPNAuthority.com --> http://www.vpnauthority.com/faq.php?info_id=33
   for example you can play with nmcli (Network Manager Command Line Interface) using 
       nmcli con # to show all your connections
       nmcli con up id yourconnection # to use this VPN
       nmcli con down id yourconnection # to disconnect this VPN
   
   PS : You don't have to buy an actual VPN package, just register for trial using FakeMakeGenerator ( http://www.fakemailgenerator.com )


2. Configure Firefox properly

    Go to Edit > Preferences > Advanced > Network > Settings > Auto-detect proxy settings for this Network
    Go to "about:config", search for "resume" and disable (turn into false) the "browser.sessionstore.resume_from_crash"
  
  
3. Configure the mail settings (if you want to get informed)

    Use this guide: http://www.nixtutor.com/linux/send-mail-with-gmail-and-ssmtp/
    and replace username@gmail.com  with your gmail account (eg drpaneas@gmail.com)
    and insert your password in order to use GMAIL credentials without problem.
    
    PS: Try to send yourself an e-mail: 
    
    echo "blahblahblahblahblah" > message.txt
    cat message.txt | mail -s "This is a test mail" youremail@gmail.com

4.  Upload tweleve links.txt (links.txt, links1.txt, links2.txt ---- links12.txt) and upload them on your server
    Then edit the file "pocket.sh" and replace:
    
    host=http://linuxed.gr/script/
    with your server  eg host=http://something.com/somefolder/     here there will be all the links.txt files
    
    I am using four links:
        Adf.ly, Shorte.st, cashfly.com and adfoc.us
        
5.  Change the mail address
    Edit the file "pocket.sh" and replace
    
    addr=drpaneas@gmail.com
    with your e-mail
    
    then edit the file "money.sh" and replace
    addr=drpaneas@gmail.com  with your e-mail (again)
    
6.  Optional changes
    The script comments are written in my native language, so here's a brief exaplanation for the non-Greek speakers
    
    // Time interval between links
    link_time=105
    
    // Time interval between change of VPNs
    vpn_time=60
    
    // Time to wait after setting up the VPN connection
    vpn_boot_time=60
    
    // Time to wait after the first failure
    fail_time_1=300
    
    // Time to wait after the second failure
    fail_time_2=7200
    
    // Time to wait after the third failure
    fail_time_3=360000
    
    
How to run
===========
sudo chmod +x pocket.sh
./pocket.sh


###########################################################################
###  IF YOU LIKE THIS SCRIPT, DONATE AT MY PAYPAL:  drpaneas@gmail.com  ###
###########################################################################

Have fun and piece out
Panos (aka drpaneas)
    
    
    
    
