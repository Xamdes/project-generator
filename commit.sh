#!/usr/bin/env bash
git add ..

if [ -s = "$1" ]
then
  git commit -m "$2"
fi

if [ -p = "$1" ]
then
  git-pair-commit -m "$2"
fi
