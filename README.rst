otc_rds
=======

OTC role for RDS.

Variables:
^^^^^^^^^^

+-------------------------+----------------------------------------------------------------+
| Name                    | Description                                                    |
+=========================+================================================================+
| rds_version_id          | ID of the RDS version (to use to fetch flavor                  |
+-------------------------+----------------------------------------------------------------+
| rds_name                | Name of RDS instance                                           |
+-------------------------+----------------------------------------------------------------+
| rds_id                  | ID of RDS instance                                             |
+-------------------------+----------------------------------------------------------------+
| rds_node_id             | ID of RDS instance node (name convention _node0,_node1..)      |
+-------------------------+----------------------------------------------------------------+
| rds_type                | RDS type (MySQL or PostgreSQL)                                 |
+-------------------------+----------------------------------------------------------------+
| rds_version             | RDS version (i.e. 5.6.7)                                       |
+-------------------------+----------------------------------------------------------------+
| rds_spec_code           | RDS resource specification code, (i.e. rds.mysql.m1.xlarge.ha) |
+-------------------------+----------------------------------------------------------------+
| rds_instance_mode       | RDS instance type (ha,replica or single)                       |
+-------------------------+----------------------------------------------------------------+
| rds_volume_type         | Type of RDS volume (COMMON (SATA) or ULTRAHIGH (SSD))          |
+-------------------------+----------------------------------------------------------------+
| rds_volume_size         | Size of RDS volume (40 - 4000 GB)                              |
+-------------------------+----------------------------------------------------------------+
| rds_port                | RDS port                                                       |
+-------------------------+----------------------------------------------------------------+
| rds_ram                 | Memory for RDS in MB                                           |
+-------------------------+----------------------------------------------------------------+
| rds_availability_zone   | RDS Availability Zone ( i.e. eu_de-01)                         |
+-------------------------+----------------------------------------------------------------+
| rds_secgroup_name       | RDS Security Group                                             |
+-------------------------+----------------------------------------------------------------+
| rds_subnet_name         | RDS subnet                                                     |
+-------------------------+----------------------------------------------------------------+
| rds_backup_time         | Start time of backup (i.e. 01:00-02:00, maximum of 1 hour,     |
|                         | minutes in 00,15,30,45)                                        |
+-------------------------+----------------------------------------------------------------+
| rds_backup_id           | ID of RDS backup (required for restore)                        |
+-------------------------+----------------------------------------------------------------+
| rds_backup_name         | Name if manual generated backup                                |
+-------------------------+----------------------------------------------------------------+
| rds_backup_days         | Keep days of backups (between 0-732, 0 = disabled)             |
+-------------------------+----------------------------------------------------------------+
| rds_restore_time        | Timestamp of RDS restore                                       |
+-------------------------+----------------------------------------------------------------+
| rds_ha_enabled          | RDS HA enabled or not (true or false)                          |
+-------------------------+----------------------------------------------------------------+
| rds_ha_replication_mode | RDS replication mode (async or semisync for MySQL,             |
|                         | async or sync for PostgreSQL)                                  |
+-------------------------+----------------------------------------------------------------+
| rds_disk_encryption_id  | Key ID for disc encryption                                     |
+-------------------------+----------------------------------------------------------------+
| rds_root_password       | RDS root password                                              |
+-------------------------+----------------------------------------------------------------+
| errorlog_startdate      | Start date of error log (i.e. 2018-04-05+23:59)                |
+-------------------------+----------------------------------------------------------------+
| errorlog_enddate        | End date of error log (i.e. 2018-05-05+23:59)                  |
+-------------------------+----------------------------------------------------------------+
| errorlog_curpage        | Pages per error log (default 1)                                |
+-------------------------+----------------------------------------------------------------+
| errorlog_perpage        | Error message per page (1-100, default 100)                    |
+-------------------------+----------------------------------------------------------------+
| slowlog_type            | Type of slowlog (INSERT, UPDATE, SELECT, DELETE, CREATE)       |
+-------------------------+----------------------------------------------------------------+
| waitfor                 | Wait for RDS creation is finished (true or false)              |
+-------------------------+----------------------------------------------------------------+


Functions:
^^^^^^^^^^

Version::

     ./grole otc_rds; ansible-playbook roles.yml -e "localaction=version"

Flavor::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_name=ansible-mysql01 rds_type=MySQL rds_version=5.7.20 localaction=flavor"

List::

    ./grole otc_rds; ansible-playbook roles.yml -e "localaction=list"

Show::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_name=ansible-mysql01_node0 localaction=show"

Note: configured rds_name will automatically append with number of instances starting from ``_node0``

Create::

    ./grole otc_rds: ansible-playbook roles.yml -e "rds_name=ansible-mysql01 rds_root_password=Ab+12345678 localaction=create"

Resize Volume::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_name=ansible-mysql01_node0 rds_volume_size=120 localaction=resize_volume"

Resize Flavor::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_name=ansible-mysql01 rds_node_id=d61a75b397ff4af1837fafb75a860eafin01  rds_ram=8000  rds_type=MySQL rds_version=5.7.20 rds_ha_enabled=false localaction=resize_flavor"

Reboot an instance::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_name=ansible-mysql01 waitfor=true localaction=reboot"

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_node_id=d61a75b397ff4af1837fafb75a860eafin01 localaction=reboot"

Note: rds_node_id to shown from ``Show`` command

Delete an instance::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_name=ansible-mysql01 localaction=delete"

List backups::

    ./grole otc_rds; ansible-playbook roles.yml -e "localaction=backups"

Create a backup::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_name=ansible-mysql01 rds_backup_name=my_backup_mysql01_1 localaction=create_backup"

Delete a backup::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_backup_id=04eabf2523c8445e80faa0452c991e87br01 localaction=delete_backup"

Note: grab the rds_backup_id from ``List backups``

Restore current DB (with file backup)::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_backup_id=04eabf2523c8445e80faa0452c991e87br01 rds_name=ansible-mysql01 localaction=restore_backup_current" 

Restore current DB (Point in Time Recovery)::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_restore_time='2018-05-13 19:30:01' rds_name=ansible-mysql01 localaction=restore_backup_current" 

Note: microseconds are rounded

Restore to a new instance (with file backup)::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_backup_id=04eabf2523c8445e80faa0452c991e87br01" rds_name=ansible-mysql02 rds_volume_size=120  rds_ram=4096 rds_type=MySQL rds_version=5.7.20 rds_ha_enabled=false rds_id=02eabf2523c8445e80faa0452c991e87br01 localaction=restore_backup_new" 

Note: instance version is assigned to the backup set, so it's not possible to restore MySQL 5.7 version from MySQL 5.6 backup

Restore to a new instance (Point in Time Recovery)::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_restore_time='2018-05-13 19:30:01' rds_name=ansible-mysql02 rds_volume_size=120  rds_ram=4096 rds_type=MySQL rds_version=5.7.20 rds_ha_enabled=false rds_id=02eabf2523c8445e80faa0452c991e87br01 localaction=restore_backup_new" 

Note: grab the different IDs for example from ``list (backups)``

Query error log::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_node_id=a0fbfc3ff14f4d7b8f4bec1aff2e7e8cno01 errorlog_startdate=2018-05-01+00:00 errorlog_enddate=2018-05-13+18:00 localaction=errorlog"

Note: You can only query error logs generated within a month. rds_node_id to shown from ``Show`` command

Query slow query log::

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_node_id=a0fbfc3ff14f4d7b8f4bec1aff2e7e8cno01 localaction=slowlog"

    ./grole otc_rds; ansible-playbook roles.yml -e "rds_node_id=a0fbfc3ff14f4d7b8f4bec1aff2e7e8cno01 slowlog_type=SELECT localaction=slowlog"

Note: if ``slowlog_type`` is not set, all types will be queried
