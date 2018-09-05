#!/usr/bin/env bash
git add .

if [ -p == "$1" ];
then
  git-pair-commit -m "$2"
else
  git commit -m "$1"
fi
