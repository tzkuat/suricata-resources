#!/bin/bash

echo -e "\n"
echo "####################### Suricata IPREP Install #########################"
echo "#                                                                      #"
echo "# @author : Mickael Rigonnaux @tzkuat mickael.rigonnaux@rm-it.fr       #"
echo "#                                                                      #"
echo "########################################################################"
echo -e "\n"

# Setup Proxy
export http_proxy="http://proxy-example.com:8080"
export https_proxy="https://proxy-example.com:8080"

# Function update/install
update_tor () {

        rm -rf tor-nodes.lst tor-nodes.list
        wget https://raw.githubusercontent.com/SecOps-Institute/Tor-IP-Addresses/master/tor-nodes.lst
        sed 's/$/,1,100/' tor-nodes.lst > tor-nodes.list
        mv tor-nodes.list /etc/suricata/iprep/

}

update_blacklist () {

        rm -rf blacklist.list firehol_level1.netset
        wget https://iplists.firehol.org/files/firehol_level1.netset
        sed 's/$/,2,100/' firehol_level1.netset > blacklist.list
        mv blacklist.list /etc/suricata/iprep/

}

if [ $1 = "--install" ] 2> /dev/null
then

        #Add config in suricata.yaml
        echo -e "\n" >> /etc/suricata/suricata.yaml
        echo "# IP Reputation" >> /etc/suricata/suricata.yaml
        echo "reputation-categories-file: /etc/suricata/iprep/categories.txt" >> /etc/suricata/suricata.yaml
        echo "default-reputation-path: /etc/suricata/iprep" >> /etc/suricata/suricata.yaml
        echo "reputation-files:" >> /etc/suricata/suricata.yaml
        echo "- blacklist.list" >> /etc/suricata/suricata.yaml
        echo "- tor-nodes.list" >> /etc/suricata/suricata.yaml
        
        # Create iprep folder
        mkdir /etc/suricata/iprep

        # Create categories file
        touch /etc/suricata/iprep/categories.txt
        echo "1,Tor-hosts,Tor nodes IPs" >> /etc/suricata/iprep/categories.txt
        echo "2,Blocklist,FireHol Blacklist IP" >> /etc/suricata/iprep/categories.txt

        # Function calls
        update_tor
        update_blacklist

        echo "Installation OK"

elif [ $1 = "--update-all" ] 2> /dev/null
then

        update_tor
        update_blacklist
        echo "Update OK"

elif [ $1 = "--update-tor" ] 2> /dev/null
then

        update_tor
        echo "Update OK"

elif [ $1 = "--update-blacklist" ] 2> /dev/null
then

        update_blacklist
        echo "Update OK"

else

        echo -e "\n"
        echo "### Options available with this script"
        echo "#         --install for install IPREP with Tor & FireHol Blacklist"
        echo "#         --update for update the lists Tor & FireHol"
        echo "#         --update-tor for update only tor list"
        echo "#         --update-blacklist for update only FireHol Blacklist"
        echo -e "\n"

fi
