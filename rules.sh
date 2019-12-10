#!/bin/bash

export https_proxy="https://example.com:8080"
export http_proxy="http://example.com:8080"

rm -rf emerging-exploit.rules
wget https://rules.emergingthreatspro.com/open/suricata-5.0/rules/emerging-exploit.rules
sed 's/$EXTERNAL_NET/any/g' emerging-exploit.rules > exploit-local.rules

rm -rf emerging-malware.rules
wget https://rules.emergingthreatspro.com/open/suricata-5.0/rules/emerging-malware.rules
sed 's/$EXTERNAL_NET/any/g' emerging-malware.rules > malware-local.rules

rm -rf emerging-scan.rules
wget https://rules.emergingthreatspro.com/open/suricata-5.0/rules/emerging-scan.rules
sed 's/$EXTERNAL_NET/any/g' emerging-scan.rules > scan-local.rules

rm -rf emerging-web_server.rules
wget https://rules.emergingthreatspro.com/open/suricata-5.0/rules/emerging-web_server.rules
sed 's/$EXTERNAL_NET/any/g' emerging-web_server.rules > webserver-local.rules

rm -rf emerging-web_client.rules
wget https://rules.emergingthreatspro.com/open/suricata-5.0/rules/emerging-web_client.rules
sed 's/$EXTERNAL_NET/any/g' emerging-web_client.rules > webclient-local.rules

rm -rf tor.rules
wget https://rules.emergingthreatspro.com/open/suricata-5.0/rules/tor.rules
sed 's/->/<>/g' tor.rules > tor-local.rules
