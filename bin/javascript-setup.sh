#!/usr/bin/env bash
# To Run a Command go to location and type ./(command)
# Example:
# cd Commands
# ./create-solution.sh

# karma init

cd ..
mkdir "$1"
cd ./$1/

touch .gitignore
echo "node_modules/
.DS_Store
build/
dist/
.env
" > .gitignore

mkdir bin
mkdir spec

mkdir src
touch ./src/index.html
touch ./src/main.js
touch ./src/$1.js
touch ./src/styles.css
touch README.md

cd ./bin/

touch commit.sh

echo "#!/usr/bin/env bash

git add .
git commit -m \"\$1\"
" > ./bin/commit.sh

chmod 755 *.sh

cd ..

git init
npm init -y

echo "{
  \"name\": \"$1\",
  \"version\": \"1.0.0\",
  \"description\": \"\",
  \"main\": \"index.js\",
  \"scripts\": {
    \"build\": \"webpack --mode development\",
    \"commit\": \"bash ./bin/commit.sh\",
    \"start\": \"npm run build && webpack-dev-server --open --mode development\",
    \"lint\": \"eslint src/*.js\",
    \"jamsine\": \"jasmine\",
    \"test\": \"karma start karma.conf.js\"
  },
  \"keywords\": [],
  \"author\": \"Jane Doe\",
  \"license\": \"ISC\"
}
" > package.json

npm install webpack@4.0.1 webpack-cli@2.0.9 style-loader@0.20.2 css-loader@0.28.10 html-webpack-plugin@3.0.6 clean-webpack-plugin@0.1.18 uglifyjs-webpack-plugin@1.2.2 webpack-dev-server@3.1.0 eslint@4.18.2 eslint-loader@2.0.0 jasmine-core@2.99.0 jasmine@3.1.0 karma@2.0.0 karma-jasmine@1.1.1 karma-chrome-launcher@2.2.0  karma-cli@1.0.1 karma-webpack@2.0.13  karma-jquery@0.2.2 karma-jasmine-html-reporter@0.2.2 webpack-dev-middleware@3.1.0 hoek@5.0.3 karma-eslint -f --save-dev

npm install jquery popper.js bootstrap karma-cli -f --save

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
  devtool: 'source-map',
  //eval-source-map for development
  //source-map for production
  devServer: {
    contentBase: './dist'
  },
  optimization: {
    minimizer: [
      new UglifyJsPlugin({
        sourceMap: true,
        uglifyOptions: {
          ecma: 8,
          compress: {
            arrows: true,
            booleans: true,
            collapse_vars: false,
            comparisons: true,
            computed_props: true,
            conditionals: true,
            dead_code: true,
            drop_console: false,
            ecma: 6,
            evaluate: true,
            hoist_funs: false,
            hoist_props: false,
            //hoist_var tends to increase file size if enabled
            hoist_vars: false,
            if_return: true,
            inline: 1,
            join_vars: true,
            keep_infinity: true,
            loops: true,
            negate_iife: false,
            passes: 3,
            properties: false,
            reduce_funcs: true,
            reduce_vars: true,
            sequences: 5,
            side_effects: false,
            switches: true,
            toplevel: false,
            top_retain: true,
            typeofs: false,
            unsafe: false,
            unused: false,
            warnings: false,
          },
        }
      })
    ]
  },
  plugins: [
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery'
    }),
    new CleanWebpackPlugin(['dist']),
    new HtmlWebpackPlugin({
      title: '$1',
      template: './src/index.html',
      inject: 'body'
    })
  ],
  performance:
  {
    hints: false
  },
  mode: 'development',
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
        exclude: [
          /node_modules/,
          /spec/
        ],
        loader: 'eslint-loader'
      }
    ]
  }
};" > webpack.config.js

echo "import {  } from './$1';
import 'bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
import './styles.css';

\$(function()
{
});
" > ./src/main.js

echo "<!DOCTYPE html>
<html>
<head>
  <title>$1</title>
</head>
<body>

</body>
</html>
" > ./src/index.html

echo "const webpackConfig = require('./webpack.config.js');

module.exports = function(config) {
  config.set({
    basePath: '',
    frameworks: ['jquery-3.2.1', 'jasmine'],
    files: [
      'src/*.js',
      'spec/*spec.js'
    ],
    webpack: webpackConfig,
    exclude: [
    ],
    preprocessors: {
      'src/*.js': ['webpack'],
      'spec/*spec.js': ['webpack']
    },
    plugins: [
      'karma-jquery',
      'karma-webpack',
      'karma-jasmine',
      'karma-chrome-launcher',
      'karma-jasmine-html-reporter'
    ],
    reporters: ['progress', 'kjhtml'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ['Chrome'],
    singleRun: false,
    concurrency: Infinity
  })
}
" > karma.conf.js


echo "## GITATTRIBUTES FOR WEB PROJECTS
#
# Found from https://github.com/alexkaratarakis/gitattributes
# These settings are for any web project.
#
# Details per file setting:
#   text    These files should be normalized (i.e. convert CRLF to LF).
#   binary  These files are binary and should be left untouched.
#
# Note that binary is a macro for -text -diff.
######################################################################

## AUTO-DETECT
##   Handle line endings automatically for files detected as
##   text and leave all files detected as binary untouched.
##   This will handle all files NOT defined below.
* text=auto

## SOURCE CODE
*.bat      text eol=crlf
*.coffee   text
*.css      text
*.htm      text
*.html     text
*.inc      text
*.ini      text
*.js       text
*.json     text
*.jsx      text
*.less     text
*.od       text
*.onlydata text
*.php      text
*.pl       text
*.py       text
*.rb       text
*.sass     text
*.scm      text
*.scss     text
*.sh       text eol=lf
*.sql      text
*.styl     text
*.tag      text
*.ts       text
*.tsx      text
*.xml      text
*.xhtml    text

## DOCKER
*.dockerignore    text
Dockerfile    text

## DOCUMENTATION
*.markdown   text
*.md         text
*.mdwn       text
*.mdown      text
*.mkd        text
*.mkdn       text
*.mdtxt      text
*.mdtext     text
*.txt        text
AUTHORS      text
CHANGELOG    text
CHANGES      text
CONTRIBUTING text
COPYING      text
copyright    text
*COPYRIGHT*  text
INSTALL      text
license      text
LICENSE      text
NEWS         text
readme       text
*README*     text
TODO         text

## TEMPLATES
*.dot        text
*.ejs        text
*.haml       text
*.handlebars text
*.hbs        text
*.hbt        text
*.jade       text
*.latte      text
*.mustache   text
*.njk        text
*.phtml      text
*.tmpl       text
*.tpl        text
*.twig       text

## LINTERS
.csslintrc    text
.eslintrc     text
.htmlhintrc   text
.jscsrc       text
.jshintrc     text
.jshintignore text
.stylelintrc  text

## CONFIGS
*.bowerrc      text
*.cnf          text
*.conf         text
*.config       text
.browserslistrc    text
.editorconfig  text
.gitattributes text
.gitconfig     text
.htaccess      text
*.npmignore    text
*.yaml         text
*.yml          text
browserslist   text
Makefile       text
makefile       text

## HEROKU
Procfile    text
.slugignore text

## GRAPHICS
*.ai   binary
*.bmp  binary
*.eps  binary
*.gif  binary
*.ico  binary
*.jng  binary
*.jp2  binary
*.jpg  binary
*.jpeg binary
*.jpx  binary
*.jxr  binary
*.pdf  binary
*.png  binary
*.psb  binary
*.psd  binary
*.svg  text
*.svgz binary
*.tif  binary
*.tiff binary
*.wbmp binary
*.webp binary

## AUDIO
*.kar  binary
*.m4a  binary
*.mid  binary
*.midi binary
*.mp3  binary
*.ogg  binary
*.ra   binary

## VIDEO
*.3gpp binary
*.3gp  binary
*.as   binary
*.asf  binary
*.asx  binary
*.fla  binary
*.flv  binary
*.m4v  binary
*.mng  binary
*.mov  binary
*.mp4  binary
*.mpeg binary
*.mpg  binary
*.ogv  binary
*.swc  binary
*.swf  binary
*.webm binary

## ARCHIVES
*.7z  binary
*.gz  binary
*.jar binary
*.rar binary
*.tar binary
*.zip binary

## FONTS
*.ttf   binary
*.eot   binary
*.otf   binary
*.woff  binary
*.woff2 binary

## EXECUTABLES
*.exe binary
*.pyc binary
" > .gitattributes

echo "{
  'parserOptions': {
    'ecmaVersion': 6,
    'sourceType': 'module'
  },
  'extends': 'eslint:recommended',
  'env': {
    'es6': true,
    'browser': true,
    'jquery': true,
    'node': true,
    'jasmine': true
  },
  'rules': {
    'semi': 1,
    'indent': ['warn', 2],
    'no-console': 'warn',
    'no-debugger': 'warn',
    'no-unused-vars': 'warn'
  }
}" > .eslintrc

touch ./spec/"$1"-spec.js

echo "import { } from './../src/$1';
describe('Temp', function()
{
  var temp;

  beforeEach(function() {
    temp = "";
  });

  afterEach(function() {
  });

  it('should show how beforeEach() works', function() {
    console.log(temp);
  });

  it('sample test', function() {
    expect(true).toEqual(true);
  });

});" > ./spec/"$1"-spec.js

echo "# Project: $1

## Author(s)

## Specs

## Help

## License

## Autogenerated by @xamdes/project-generator
" > README.md
