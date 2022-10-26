# nanoChart
No more shitty electronic charts pls

### User story
A family doctor wants to write their notes in an accesssible format, without using outdated and proprietary charting systems.

A healthcare professional wants an EMR that will generate access logs to ensure ethical access.

A rural practitioner wants to write notes on their laptop without internet connection, and sync once they connect to the internet again.

### Features
- Git based sync
- Documents, observables, and raw media stored as files
- Local editing allowed
- Gitolite to enforce access control and logging

### quick notes
Populate secrets/__ansible_ssh_private.key

add_user.yml before adduser.sh before chpasswd.sh

--signoff for legal reason

### 

golden (master)      --> (git clone)    scratch (personal_branch)

sync between these two (git pull + git push) w/ security in mind.


### Regulatory Warning

Use of nanoChart in standalone mode without an upstream server for access control and logging may not be compliant with your regional healthcare regulations. We recommend inter-professional health and collaborative efforts when possible.

## Usage

```
./scripts/env.sh ./scripts/init_chart.sh
```


## TODO

- add gitolite3 config, template, and hooks
