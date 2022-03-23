mkdir /mnt/micro_emr/
chmod 2770 /mnt/micro_emr/
chown micro_emr:micro_emr_users /mnt/micro_emr/

mkdir /mnt/micro_emr/golden/
chmod 2770 micro_emr:micro_emr_users /mnt/micro_emr/golden/

mkdir /mnt/micro_emr/scratch/
chmod 2770 micro_emr:micro_emr_users /mnt/micro_emr/scratch/


# server should make folder 2750, enforces nchart commit
mkdir /mnt/micro_emr/scratch/joel/
chmod 2750 micro_emr:micro_emr_users /mnt/micro_emr/scratch/joel/

#copy git

# git config usernane + email
git config user.name "John Doe"
git config user.email johndoe@example.com

