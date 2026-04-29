#!/bin/bash
echo "Venter på at MongoDB-nodene starter opp..."
sleep 15

echo "Initialiserer replica set..."
mongosh --host mongo1:27017 --eval '
  rs.initiate({
    _id: "myReplicaSet",
    members: [
      { _id: 0, host: "mongo1:27017", priority: 2 },
      { _id: 1, host: "mongo2:27017", priority: 1 },
      { _id: 2, host: "mongo3:27017", priority: 1 }
    ]
  });
'

echo "Venter på at replica set er klart..."
sleep 5

mongosh --host mongo1:27017 --eval 'rs.status()' | head -30

echo "Replica set er klart!"

