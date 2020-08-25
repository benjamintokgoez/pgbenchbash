#!/bin/bash
#@author: Benjamin Tokgoez
#implemented for usage with remote postgresdbs

echo "Welcome to the postgres auto-config"

echo "Please provide your database host (default localhost)"

read dbhost

if test -z "$dbhost"
then
	export DBHOST=localhost
else
	export DBHOST=$dbhost
fi

echo "Please provide your postgres username"

read dbuser

if test -z "$dbuser"
then
	echo "you must provide a valid username"
else
	export DBUSER=$dbuser
fi

echo "Please provide your database name (default postgres)"

read postgresdb

if test -z "$postgresdb"
then
	export POSTGRESDBNAME=postgres
else
	export POSTGRESDBNAME=$postgresdb
fi


echo "Please provide a number of worker threads (default 1)"

read workerthreads

if test -z "$workerthreads"
then
	export PGTHREADS=1
else
	export PGTHREADS=$workerthreads
fi
echo "Please provide a number of simulated clients (default 1)"

read pgclients

if test -z "$pgclients"
then
	export PGCLIENTS=1
else
	export PGCLIENTS=$pgclients
fi
echo "Please provide a number of transactions each client runs (default 10)"

read transactions

if test -z "$transactions"
then
	export PGTRANS=10
else
	export PGTRANS=$transactions
fi


echo summary:

echo "database host: $DBHOST, database user: $DBUSER, database name: $POSTGRESDBNAME, worker threads: $PGTHREADS, simulated clients: $PGCLIENTS, transactions per client: $PGTRANS"

read -p "Continue with benchmark?  <y/N> " prompt
if [[ $prompt =~ [yY](es)* ]]
then
	pgbench -h $DBHOST -j$PGTHREADS -r -Mextended -n -c$PGCLIENTS -t$PGTRANS -U $DBUSER $POSTGRESDBNAME >> ./pgbench_results
else 
	echo "cancel benchmark..."
fi

exit 0
