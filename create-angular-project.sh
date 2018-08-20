#!/usr/bin/env bash
ng new $1
cd ./$1
npm install ajv hoek bootstrap --save
npm audit fix --force
