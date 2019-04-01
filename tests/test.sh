#!/bin/sh

echo "SCENARIO 1: version RDS"
ansible-playbook test.yml -e "localaction=version" || exit 1
echo "SCENARIO 2: flavor RDS"
ansible-playbook test.yml -e "rds_name=ansible-mysql01 rds_type=MySQL rds_version=5.7 localaction=flavor" || exit 1
echo "SCENARIO 3: create RDS"
ansible-playbook test.yml -e "rds_name=ansible-mysql01 localaction=create waitfor=true" || exit 1
echo "SCENARIO 4: show RDS"
ansible-playbook test.yml -e "rds_name=ansible-mysql01 localaction=show" || exit 1
echo "SCENARIO 5: reboot RDS"
ansible-playbook test.yml -e "rds_name=ansible-mysql01 localaction=reboot waitfor=true" || exit 1
echo "SCENARIO 6: list RDS"
ansible-playbook test.yml -e "localaction=list" || exit 1
echo "SCENARIO 7: create backup RDS"
ansible-playbook test.yml -e "rds_name=ansible-mysql01 rds_backup_name=backup_ansible-mysql01_1 localaction=create_backup" || exit 1
echo "SCENARIO 8: list backups RDS"
ansible-playbook test.yml -e "rds_name=ansible-mysql01 localaction=backups" || exit 1
echo "SCENARIO 9: restore current instance RDS"
ansible-playbook test-restore.yml -e "rds_name=ansible-mysql01" || exit 1
echo "SCENARIO 10: delete RDS"
ansible-playbook test.yml -e "rds_name=ansible-mysql01 localaction=delete" || exit 1
#echo "SCENARIO 10: resize volume RDS"
#echo "SCENARIO 11: resize flavor RDS"
#echo "SCENARIO 12: delete backup RDS"
#echo "SCENARIO 14: restore new instance RDS"
#echo "SCENARIO 15: query error log RDS"
#echo "SCENARIO 16: query slow log RDS"
#echo "SCENARIO 17: query slow log with type RDS"
