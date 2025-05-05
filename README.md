# Spamhaus DROP IP Address Lists for MikroTik Firewalls

MikroTik firewall address lists for the Spamhaus DROP list. Refreshed daily at 05:30 UTC. The generated configuration files create IPv4 and IPv6 address lists named **spamhaus-drop-ips-ipv4** and **spamhaus-drop-ips-ipv6** which can be used in firewall filter/NAT/mangle rules.

## Usage

Create a script to download **spamhaus-drop-ips-v4.rsc** and **spamhaus-drop-ips-v6.rsc**, remove any existing entries in the **spamhaus-drop-ips-ipv4** and **spamhaus-drop-ips-ipv6** address lists, and import the new address lists. Then, create a schedule to run the script at an appropriate time for your environment. You can either configure these manually, or download and import **spamhaus-drop-ips-setup.rsc** to create them automatically. Read on for a sample script and schedule if you want to configure these manually. If you create the script and schedule manually, they require **ftp**, **read**, **write** and **test** permissions.

### Sample Script

```
:log info "Download Spamhaus DROP IP lists";
/tool fetch url="https://raw.githubusercontent.com/GForceIndustries/mikrotik-spamhaus-drop-ips/refs/heads/main/spamhaus-drop-ips-v4.rsc" mode=https dst-path=spamhaus-drop-ips-v4.rsc;
/tool fetch url="https://raw.githubusercontent.com/GForceIndustries/mikrotik-spamhaus-drop-ips/refs/heads/main/spamhaus-drop-ips-v6.rsc" mode=https dst-path=spamhaus-drop-ips-v6.rsc;

:log info "Remove current Spamhaus DROP IPs";
/ip firewall address-list remove [find where list="spamhaus-drop-ips-ipv4"];
/ipv6 firewall address-list remove [find where list="spamhaus-drop-ips-ipv6"];
:log info "Import newest Spamhaus DROP IPs";
/import file-name=spamhaus-drop-ips-v4.rsc;
/import file-name=spamhaus-drop-ips-v6.rsc;
```

### Sample Schedule

```
/system scheduler
add interval=1d name=spamhaus-drop-ips on-event=spamhaus-drop-ips policy=ftp,read,write,test start-date=2025-04-23 start-time=06:45:00
```
