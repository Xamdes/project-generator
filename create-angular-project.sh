#!/usr/bin/env bash
ng new $1
cd ./$1
npm install ajv hoek bootstrap --save
npm audit fix --force

mkdir commands
cd commands
touch component.sh
echo "#!/usr/bin/env bash
ng g component \$1
" > ./component.sh

chmod 755 *
