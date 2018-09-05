#!/usr/bin/env bash

cd ~/
touch .pairs
nameOne=$1
initOne=""
emailOne=$2
nameTwo=$3
initTwo=""
emailTwo=$4

for word in $nameOne
do
   initOne=$initOne${word:0:1}
done

initOne=$(echo "$initOne" | tr '[:upper:]' '[:lower:]')

for word in $nameTwo
do
   initTwo=$initTwo${word:0:1}
done

initTwo=$(echo "$initTwo" | tr '[:upper:]' '[:lower:]')

echo "pairs:
  $initOne: $nameOne
  $initTwo: $nameTwo
email:
  $initOne: $emailOne
  $initTwo: $emailTwo">.pairs

atom .pairs
