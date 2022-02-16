# Ansible Scripts

## Config

Ansible defaults to loading `ansible.cfg` from the current directory. 

## Deploy Vultr VM

### Important

To deploy a new VM on Vultr, we need to run the Ansible playbooks on `localhost`. After that, we dynamically generate an inventory of VMs from `./inventories/staging`. Then we can run a playbook over groups e.g. `vultr`, `vultr_region_chicago`, or individual VMs. We can also use regex pattern matching with `~(web|db).*\.example\.com`.

### Get Vultr Machine Plans

```
ansible localhost -m vultr_plan_info
```

This should be our default plan (cheapest bandwidth):

```
"id": 202,
"name": "2048 MB RAM,55 GB SSD,2.00 TB BW",
"price_per_month": 10.0
```

### Get Vultr Regions

```
ansible localhost -m vultr_region_info
```

See `vultr_regions.md`

### Get Vultr Inventory

```
ansible-inventory --list -i ./inventories/staging
```

### Deploy and Install Base Software

```
ansible-playbook -i inventories/staging wg_provision_vultr.yml -e server_location=Chicago -e server_id=temp23 -e env=staging
```

### Upgrade Sotware on all Vultr staging machines

```
ansible-playbook wg_upgrade_all.yml -i inventories/staging -e env=staging
```

## Push Configurations

### Ansible Playbook

The ansible playbook is called `wg_configure.yml`. It will push various configurations depending on the existance of each of the following variables:

```
ip_config, wg_config, bird6_config, nftables_config
```

These can either be passed as an argument with `-e '{"key": "value"}'`, or as a .json file with `-e @file.json`.

### JSON Specification

Contains a list of IP addresses that will be assigned to the wg server, i.e. what the client will connect to. IPv4 addresses that end in /32 or IPv6 addresses that end in /128 must be truncated.

```
ip_config: {"edge_ip_addresses": ["192.168.0.1/24", "2602:ffc5:200:9::/64"]}
```

Contains currently active tunnel ids, and/or a list of WireGuard delta configs to push to the wg server. These delta configs are only for either creating a new tunnel or updating an existing tunnel. Deletions are handled simply by removing the tunnel from `active_wg_ids`. Multiple peers are also allowed.

```
wg_config: {"active_wg_ids": ["586b30a4583e"],
            "tunnel_deltas":
            [
            {"wg_id": "586b30a4583e",
            "privatekey": "EF20wR7i6oiHg8YkxEMCq3Q2JjFxsYxCTE0o3IB082g=",
            "listenport": "52498",
            "peers": [{"allowedips": "2602:ffc5:200:10::/64, 192.168.0.5/32",
                        "publickey": "4l2pNd1X1Ljm5VGS6RNEPbWAGa8rPa3wepZshtxI12w="}]}
            ]
            "all_ip_routes": ["2602:ffc5:200:10::/64", "2602:ffc5:200:11::/64", "192.168.0.5"]
            }
```

Contains the required info for BGP routing with BIRD, for IPv6. The `announced_routes` are propagated to external BGP servers. All other values are currently hardcoded for usage with Vultr.

```
bird6_config =  {"local_asn": "64997",
                "neighbor_address": "2001:19f0:ffff::1",
                "neighbor_asn": "64515",
                "announced_routes": ["2602:ffc5:200::/48"],
                "password": "REDACTED"
                }
```

Contains the rate limiting data for every IP pair. Each pair requires a corresponding fwmark for ingress and egress, since this is how packets are identified. fwmarks must be unique per edge_ip/wireguard interface. The speed is uncapped if the pair doesn't appear in this list.

```
nftables_config = {"tunnel_limits": [
    {"wg_id": "8437843", "ipv6": "2602:ffc5:201:13::/64", "kbytes_sec": "2048", "from_fwmark": "2", "to_fwmark": "3"},
    {"wg_id": "8437843", "ipv6": "2602:ffc5:201:11::/64", "ipv4": "192.168.0.5/32", "kbytes_sec": "400", "from_fwmark": "4", "to_fwmark": "5"}
]
                  }
```

## Invariances

- Each server id must be unique to the environment, i.e. staging or production
- Each wg id must be unique within an wg server
- Each wg id must be between 1-12 alphanumeric characters (linux interface name restriction)
- Each edge must have a unique port within a wg server
- Each address in `edge_ip_addresses` must be a part of the BGP advertised network range, i.e. `announced_routes`, of the wg server.
- Each BGP advertised network range (/48 for IPv6 or /24 for IPv4) must be announced at only one network, e.g. 1 Vultr Location, or 1 BGP peer.
- Each IPv4 and IPv6 network range defined as a tunnel or edge IP must not conflict with one another, across all environments and networks.

- Each IPv6 address in `edge_ip_addresses` or tunnel `allowedips` recommended to have subnet at least /64, on a nibble boundary, i.e. /64, /60, /56.
- Each peer in a edge_ip/wireguard interface must have a different keypair, if they're the same, the interface gets confused. This means if there is the same private key for two different interfaces, we need to pop up an error message. If there is a collision between two separate users (!), either we pop up an error message or silently force them to be on different edge_ips. (first option preferred)
- Each IP address in `all_ip_routes` must not have the CIDR prefix if it is an IPv4 /32 address, or an IPv6 /128 address.
- Each nftables limit should use a unique fwmark for a given edge_ip/wireguard interface, preferably between 1 and 32765 for no conflicts.

## Possibe Vultr bug

It appears that sometimes it takes longer than 3 minutes to start a VM, at which point Ansible times out and fails. We can lengthen the time by patching the ansible package, from 60 --> 600

```
/Users/yoonsik/.local/share/virtualenvs/ansible-kF2dC3w5/lib/python3.7/site-packages/ansible/modules/cloud/vultr/vultr_server.py

Line 569:


server = self._wait_for_state(key='status', state='active')
            server = self._wait_for_state(state='running', timeout=3600 if snapshot_restore else 600)
        return server

```

## Hoppy Internal VPN

Let's use 172.16.0.0/16. Since this is WireGuard, we need manual IP assignments for the roles.

```
Database: 172.16.1.1/32
Database Replica: 172.16.1.101/32

Health Service: 172.16.2.1/32
API Server: 172.16.3.1/32
Provisioning Service: 172.16.4.1/32
Debugging: 172.16.5.1/32
```

## Warning:

Make sure to initailize doppler secret files and drop into a doppler shell before running the commands

```
doppler run -- ./secrets/export_secret_files.sh
doppler run -- bash
```

## DB Provision

```
ansible-playbook db_provision_vultr.yml -i "inventories/$HOPPY_ENV" -e "env=$HOPPY_ENV"
```

## DB Configure

```
ansible-playbook db_configure.yml -i "inventories/$HOPPY_ENV" -e "env=$HOPPY_ENV" -e "db_root_pass=$POSTGRES_PW" -e='@../secrets/__wg_db_conf.json'
```

## DB Connections

Use WireGuard to connect to DB securely

## Provisioning Service Provision

```
ansible-playbook ps_provision_vultr.yml -i "inventories/$HOPPY_ENV" -e "env=$HOPPY_ENV"
```

## PS Configure

```
ansible-playbook ps_configure.yml -i "inventories/$HOPPY_ENV" -e "env=$HOPPY_ENV" -e "doppler_token=$DOPPLER_TOKEN" -e "repo_version=master" -e='@../secrets/__wg_ps_conf.json'
```

## RDNS Provision

Let's put bind9 on the same server as provisioning service

## RDNS Configure Schema

```
{"active_zone_names": ["12.211.173.in-addr.arpa"], "zone_confs": [{"zone_name": "12.211.173.in-addr.arpa", "ptr_records": [{"name": "4", "data": "hohoho.naut.ca."}]}]}
```
