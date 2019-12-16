# Dynamic IP Blacklisting for UniFi USG
This Docker Image remotely sets up a dynamic IP blacklist on your UniFi Security Gateway (USG).

This is kind of a lightweight Intrusion Prevention System (IPS) only based on known blacklisted IP addresses. It retains USG's hardware offloading feature.

The following sources are used:
* Spamhaus.org
* EmergingThreats.net
* TOR Exit Nodes

Based on and inspired by the great script at: https://github.com/brontide/usg-blacklist

## Preparing the USG
1. Create an IPv4 firewall group named "Dynamic Threat List".
1. Create firewall rules in WAN_LOCAL, WAN_OUT, WAN_IN to drop traffic from/to this group.
1. Create an SSH key using ```ssh-keygen``` and install the public key in your UniFi SDN Controller under: Settings > Site > Device Authentication

## Updating the firewall rules
The rules are updates only once per day. If you run the container more than once per day, the update operation is skipped. This is useful to reinstall the rules after rebooting the USG, as existing rules are reset on reboot.

I recommend running this regularly (i.e. via a cronjob).

```
docker run --rm \
    -e "MODE=update" \
    -e "HOST=10.10.1.1" \
    -e "USER=unifi-ssh-user" \
    -v ${PWD}/ssh-key:/root/ssh-key:ro \
    virtualzone/usg-blacklist
```

## Viewing the stats
```
docker run --rm \
    -e "MODE=stats" \
    -e "HOST=10.10.1.1" \
    -e "USER=unifi-ssh-user" \
    -v ${PWD}/ssh-key:/root/ssh-key:ro \
    virtualzone/usg-blacklist
```

## Disclaimer
Tested on a UniFi USG3 with firmware 4.4.44. Use at your own risk.