# microEMR
No more shitty EMR pls

<img src="https://imgs.xkcd.com/comics/standards.png">

### User story
A family doctor wants to write their notes in a standards compliant way, without paying for greedy and proprietary EMR systems.

A health agency wants an EMR that will log the user's access to patient records to prevent misuse or unethical access.

A rural doctor wants to write notes on their laptop without internet connection, and sync their changes once they connect to the internet again.

### Features
- Git based sync
- Notes, documents, and media stored as files
- Local editing through persistent SMB share
- Server-client model to enforce access control and logging

### quick notes
Populate secrets/__ansible_ssh_private.key

add_user.yml before adduser.sh before chpasswd.sh

--signoff for legal reason

### 

golden (master)      --> (git clone)    scratch (personal_branch)

sync between these two (git pull + git push) w/ security in mind.


### Warning

Use of microEMR in standalone mode without an upstream server for access control and logging may not be compliant with your regional healthcare regulations. Furthermore, this may interfere with inter-professional health and collaborative efforts.



## Usage

```
./scripts/env.sh ./scripts/init_chart.sh
```
