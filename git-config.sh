#!/usr/bin/env bash



if [ -g == "$1" ];
then
  git config --global user.name "$2"
  git config --global user.email "$3"
else
  git config user.name "$1"
  git config user.email "$2"
fi
