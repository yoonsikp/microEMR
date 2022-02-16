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
add_user.yml before adduser.sh before chpasswd.sh
