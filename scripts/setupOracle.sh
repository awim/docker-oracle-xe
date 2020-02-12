#!/bin/bash

echo "set listener timeout to 180"
lsnrctl <<EOF
set inbound_connect_timeout 180
EXIT
EOF

echo "update sqlnet timeout to 120"
cat ${ORACLE_HOME}/scripts/sqlnet.ora > ${ORACLE_HOME}/network/admin/sqlnet.ora

echo "alter common_user_prefix as null"
sqlplus sys/oracle@localhost as sysdba <<EOF
ALTER SYSTEM SET COMMON_USER_PREFIX='' scope=spfile sid='*';
ALTER SYSTEM SET SHARED_POOL_SIZE=524288000 scope=spfile sid='*';
EXIT
EOF

echo "alter adrci control to keep file only until 7 days"
adrci exec="set home diag/rdbms/xe/XE; set control (SHORTP_POLICY = 0)"
adrci exec="set home diag/rdbms/xe/XE; set control (LONGP_POLICY = 0)"