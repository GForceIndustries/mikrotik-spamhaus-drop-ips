/system script
add dont-require-permissions=yes name=spamhaus-drop-ips owner=admin policy=ftp,read,write,test source=":log info \"Download Spamhaus DROP IP lists\";\r\
    \n/tool fetch url=\"https://raw.githubusercontent.com/GForceIndustries/mikrotik-spamhaus-drop-ips/refs/heads/main/spamhaus-drop-ips-v4.rsc\" mode=https dst-path=spamhaus-drop-ips-v4.rsc;\r\
    \n/tool fetch url=\"https://raw.githubusercontent.com/GForceIndustries/mikrotik-spamhaus-drop-ips/refs/heads/main/spamhaus-drop-ips-v6.rsc\" mode=https dst-path=spamhaus-drop-ips-v6.rsc;\r\
    \n\r\
    \n:log info \"Remove current Spamhaus DROP IPs\";\r\
    \n/ip firewall address-list remove [find where list=\"spamhaus-drop-ips-ipv4\"];\r\
    \n/ipv6 firewall address-list remove [find where list=\"spamhaus-drop-ips-ipv6\"];\r\
    \n:log info \"Import newest Spamhaus DROP IPs\";\r\
    \n/import file-name=spamhaus-drop-ips-v4.rsc;\r\
    \n/import file-name=spamhaus-drop-ips-v6.rsc;"
/system scheduler
add interval=1d name=spamhaus-drop-ips on-event=spamhaus-drop-ips policy=ftp,read,write,test start-date=2025-04-23 start-time=06:45:00
