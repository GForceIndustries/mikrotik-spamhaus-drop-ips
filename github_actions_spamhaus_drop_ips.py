from datetime import datetime, UTC
import requests
import json

today = datetime.now(UTC).strftime("%c") + " UTC"

spamhausDropIpsURLv4 = "https://www.spamhaus.org/drop/drop_v4.json"
spamhausDropIpsURLv6 = "https://www.spamhaus.org/drop/drop_v6.json"

def generateRsc(url, outputFile):
    
    fileData = requests.get(url).content

    writer = open(outputFile, "w")
    writer.write("# Generated on " + today)

    listName = ""

    if "v6" in url.lower():
        writer.write("\n/ipv6 firewall address-list")
        listName = "spamhaus-drop-ips-ipv6"
    else:
        writer.write("\n/ip firewall address-list")
        listName = "spamhaus-drop-ips-ipv4"
    
    for line in fileData.splitlines():
        lineJson = json.loads(line)
        try:
            ip = lineJson["cidr"]
            writer.write("\nadd list=" + listName + " address=" + ip)
        except:
            pass

    writer.close()

def main():
    generateRsc(spamhausDropIpsURLv4, "spamhaus-drop-ips-v4.rsc")
    generateRsc(spamhausDropIpsURLv6, "spamhaus-drop-ips-v6.rsc")

if __name__ == "__main__":
    main()
