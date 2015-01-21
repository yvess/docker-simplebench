#!/bin/bash
set -e
export PATH=$PATH:/usr/local/go/bin

if [ "$1" = 'bench' ]; then
  # VARIBLES
  NR_RUNNING=${COUCHDB_DATA:-1}
  MAX_NUMBER=${MAX_NUMBER:-100000000}

  # COMPILE GO STUFF
  [ ! -f "/root/primes" ] && go build primes.go

  # RUN CPU BENCHMARKS
  echo "* CPython *"
  time python2.7 primes.py $MAX_NUMBER
  echo -e "\n"

  echo "* pypy 1. *"
  time pypy primes.py $MAX_NUMBER
  echo -e "\n"

  echo "* pypy 2. *"
  time pypy primes.py $MAX_NUMBER
  echo -e "\n"

  echo "* go *"
  time ./primes $MAX_NUMBER
  echo -e "\n"

  exit
fi

exec "$@"
