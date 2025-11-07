#!/usr/bin/env bash

# List of keywords
KEYWORDS=(
  CRED_ACQ
  CRED_DISP
  LOGIN
  USER_ACCT
  USER_END
  USER_START
  CRED_REFR
  SERVICE_START
  SERVICE_STOP
  VIRT_CONTROL
  CRYPTO_KEY_USER
  CRYPTO_SESSION
  PROCTITLE
  SYSCALL
  USER_AUTH
  USER_LOGIN
  USER_LOGOUT
  USER_ROLE_CHANGE
  CWD
  PATH
  PROCTITLE
  SYSCALL
  USER_ERR
  AVC
  CHGRP_ID
  USER_ERR
  USER_CMD
)

OUTPUT_DIR="tests"

# Iterate and create JSON files
for keyword in "${KEYWORDS[@]}"; do
  #filepath="${OUTPUT_DIR}/${keyword}.json"
  line=`grep ${keyword} audit_sample.log | head -n 1`
  #echo "${keyword};${line}"
  echo "poetry run python3 create_test.py ../formats/auditd/tests/${keyword}.json \"$line\""
  #cd ..
done
