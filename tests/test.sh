#!/bin/sh

echo "SCENARIO 1: version RDS"
ansible-playbook test.yml -e "localaction=version" || exit 1
echo "SCENARIO 2: flavor RDS"
ansible-playbook test.yml -e "rds_name=ansible-mysql01 rds_type=MySQL rds_version=5.7 localaction=flavor" || exit 1
echo "SCENARIO 3: create RDS"
ansible-playbook test.yml -e "rds_name=ansible-mysql01 localaction=create waitfor=true" || exit 1
echo "SCENARIO 4: show RDS"
ansible-playbook test.yml -e "rds_name=ansible-mysql01 localaction=show" || exit 1
echo "SCENARIO 5: list RDS"
ansible-playbook test.yml -e "localaction=list" || exit 1
echo "SCENARIO 6: delete RDS"
ansible-playbook test.yml -e "rds_name=ansible-mysql01 localaction=delete" || exit 1
#echo "SCENARIO 7: resize volume RDS"
#echo "SCENARIO 8: resize flavor RDS"
#echo "SCENARIO 9: reboot RDS"
#echo "SCENARIO 10: list backups RDS"
#echo "SCENARIO 11: create backup RDS"
#echo "SCENARIO 12: delete backup RDS"
#echo "SCENARIO 13: restore current instance RDS"
#echo "SCENARIO 14: restore new instance RDS"
#echo "SCENARIO 15: query error log RDS"
#echo "SCENARIO 16: query slow log RDS"
#echo "SCENARIO 17: query slow log with type RDS"
