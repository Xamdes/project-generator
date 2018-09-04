#!/usr/bin/env bash

cd ..
mkdir $1
cd $1

echo "{
  \"name\": \"$1\",
  \"version\": \"1.0.0\",
  \"description\": \"Description text for project\",
  \"main\": \"index.js\",
  \"scripts\": {
    \"npm\": \"npm\",
    \"fresh\": \"npm install; webpack\",
    \"gen\": \"./bin/generate-component.sh\",
    \"commit\": \"./bin/commit.sh\",
    \"webpack\": \"webpack\",
    \"webpack-dev-server\": \"webpack-dev-server\",
    \"start\": \"webpack-dev-server --open\",
    \"web\": \"open http://localhost:8080\"
  },
  \"author\": \"John Doe\",
  \"license\": \"MIT\",
  \"dependencies\": {
    \"prop-types\": \"^15.5.10\",
    \"react\": \"^15.5.4\",
    \"react-dom\": \"^15.5.4\"
  },
  \"devDependencies\": {
    \"babel-core\": \"^6.24.1\",
    \"babel-loader\": \"^7.0.0\",
    \"babel-preset-es2015\": \"^6.24.1\",
    \"babel-preset-react\": \"^6.24.1\",
    \"html-webpack-plugin\": \"^2.29.0\",
    \"react-hot-loader\": \"^3.0.0-beta.7\",
    \"webpack\": \"^3.4.0\",
    \"webpack-dev-server\": \"^2.5.0\"
  }
}
" > package.json

mkdir bin

echo "#!/usr/bin/env bash

git add .
git commit -m \"\$1\"
" > ./bin/commit.sh

echo "#!/usr/bin/env bash

cd ./src/components

echo \"import React from \\\"react\\\";
import PropTypes from \\\"prop-types\\\";

function \$1(){
  return (
  <div>
  Insert Code Here
  </div>
  );
}

\$1.propTypes = {
  // example: PropTypes.string,
};

export default \$1;

/*
propTypes Examples
exampleArray: PropTypes.array,
exampleBoolean: PropTypes.bool,
exampleFunction: PropTypes.func,
exampleNumber: PropTypes.number,
exampleObject: PropTypes.object,
exampleString: PropTypes.string,
exampleSymbol: PropTypes.symbol,
exampleReactElement: PropTypes.element,
exampleArrayOfNumbers: PropTypes.arrayOf(PropTypes.number),
exampleArrayOfStrings: PropTypes.arrayOf(PropTypes.string),
exampleClassTypeProp: PropTypes.instanceOf(ExampleClassName),
optionalEnum: PropTypes.oneOf(['ExampleClass', 'AnotherExampleClass']),
*/
\" > \"\$1.jsx\"
" > ./bin/generate-component.sh

chmod 755 ./bin/*.sh

mkdir src
mkdir src/components

git init
npm init -y
npm install

npm run gen App

echo "import React from 'react';
import ReactDOM from 'react-dom';
import App from './components/App';
import { AppContainer } from 'react-hot-loader';

const render = (Component) => {
  ReactDOM.render(
    <AppContainer>
      <Component/>
    </AppContainer>,
    document.getElementById('react-app-root')
  );
};

render(App);

if (module.hot) {
  module.hot.accept('./components/App', () => {
    render(App)
  });
}
" > ./src/index.jsx

echo ".DS-STORE
node_modules
build
" > .gitignore

echo "MIT License

Copyright (c) [Year] [First Last]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the \"Software\"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
" > LICENSE

touch README.md

echo "<!DOCTYPE html>
<head>
  <meta charset="utf-8">
  <title><%= htmlWebpackPlugin.options.title %></title>
</head>
  <body>
    <% if (htmlWebpackPlugin.options.appMountId) { %>
      <div id=\"<%= htmlWebpackPlugin.options.appMountId%>\"></div>
    <% } %>
  </body>
</html>
" > template.ejs

echo "const webpack = require('webpack');
const { resolve } = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {

  entry: [
    'react-hot-loader/patch',
    'webpack-dev-server/client?http://localhost:8080',
    'webpack/hot/only-dev-server',
    resolve(__dirname, \"src\") + \"/index.jsx\"
  ],

  output: {
    filename: 'app.bundle.js',
    path: resolve(__dirname, 'build'),
    publicPath: '/'
  },

  resolve: {
    extensions: ['.js', '.jsx']
  },

  devtool: 'eval-source-map',

  devServer: {
    hot: true,
    contentBase: resolve(__dirname, 'build'),
    publicPath: '/'
  },

  module: {
    rules: [
      {
        test: /\.jsx?$/,
        loader: \"babel-loader\",
        exclude: /node_modules/,
        options: {
          presets: [
            [\"es2015\", {\"modules\": false}],
            \"react\",
          ],
          plugins: [
            \"react-hot-loader/babel\"
          ]
        }
      }
    ],
  },

  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NamedModulesPlugin(),
    new HtmlWebpackPlugin({
      template:'template.ejs',
      appMountId: 'react-app-root',
      title: 'React Help Queue',
      filename: resolve(__dirname, \"build\", \"index.html\"),
    }),
  ]

};
" > webpack.config.js
