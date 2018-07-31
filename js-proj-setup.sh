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

npm install webpack@4.0.1 webpack-cli@2.0.9 style-loader@0.20.2 css-loader@0.28.10 html-webpack-plugin@3.0.6 clean-webpack-plugin@0.1.18 uglifyjs-webpack-plugin@1.2.2 webpack-dev-server@3.1.0 eslint@4.18.2 eslint-loader@2.0.0 jasmine-core@2.99.0 jasmine@3.1.0 --save-dev

npm install jquery popper.js bootstrap --save

echo "const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const webpack = require('webpack');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');

module.exports =
{
  entry: './src/main.js',
  output:
  {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
  },
  devtool: 'eval-source-map',
  devServer: {
    contentBase: './dist'
  },
  plugins: [
    new UglifyJsPlugin({sourceMap: true}),
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery'
    }),
    new CleanWebpackPlugin(['dist']),
    new HtmlWebpackPlugin({
      title: '[Program Name]',
      template: './src/index.html',
      inject: 'body'
    })
  ],
  module:
  {
    rules: [
      {
        test: /\.css$/,
        use: [
          'style-loader',
          'css-loader'
        ]
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "eslint-loader"
      }
    ]
  }
};" > webpack.config.js

mkdir src
touch ./src/index.html
touch ./src/main.js
touch ./src/$1.js
touch ./src/style.css

echo "import {  } from './$1';
import 'bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
import './styles.css';

\$(function()
{
});
" > src/main.js

echo "<!DOCTYPE html>
<html>
<head>
  <title>$1</title>
</head>
<body>

</body>
</html>
" > src/index.html
