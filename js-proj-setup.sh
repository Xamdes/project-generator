#!/usr/bin/env bash
# To Run a Command go to location and type ./(command)
# Example:
# cd Commands
# ./create-solution.sh


cd ..
mkdir "$1"
cd ./$1/

touch .gitignore
echo "node_modules/
.DS_Store
dist/
" > .gitignore

mkdir Commands

cd ./Commands/

touch commit.sh

echo "#!/usr/bin/env bash
git add ..

if [ -s = \"\$1\" ]
then
  git commit -m \"\$2\"
fi

if [ -p = \"\$1\" ]
then
  git-pair-commit -m \"\$2\"
fi" > commit.sh

chmod 755 *.sh

cd ..

git init
npm init -y

touch README.md

npm install webpack@4.0.1 webpack-cli@2.0.9 style-loader@0.20.2 css-loader@0.28.10 html-webpack-plugin@3.0.6 clean-webpack-plugin@0.1.18 jquery uglifyjs-webpack-plugin@1.2.2 webpack-dev-server@3.1.0 eslint@4.18.2 eslint-loader@2.0.0 --save-dev
