#!/usr/bin/env bash

mkdir $1
cd $1

echo "{
  \"name\": \"$1\",
  \"version\": \"1.0.0\",
  \"description\": \"Epicodus Tutorial for creating a help queue\",
  \"main\": \"index.js\",
  \"scripts\": {
    \"npm\": \"npm\",
    \"fresh\": \"npm install; webpack\",
    \"gen\": \"./bin/generate-component.sh\",
    \"commit\": \"./bin/commit.sh\",
    \"git-config\": \"./bin/git-config.sh\",
    \"webpack\": \"webpack\",
    \"webpack-dev-server\": \"webpack-dev-server\",
    \"start\": \"webpack-dev-server\",
    \"start-web\": \"webpack-dev-server --open\",
    \"web\": \"open http://localhost:8080\",
    \"lint\": \"eslint 'src/**' 'src/**/**'; exit 0\",
    \"lint-fix\": \"eslint 'src/**' 'src/**/**' --fix; exit 0\"
  },
  \"author\": \"Jane Doe\",
  \"license\": \"MIT\",
  \"dependencies\": {
    \"ajv\": \"^6.5.3\",
    \"bootstrap\": \"^4.1.3\",
    \"jquery\": \"^3.3.1\",
    \"popper.js\": \"^1.14.4\",
    \"prop-types\": \"^15.5.10\",
    \"react\": \"^15.5.4\",
    \"react-dom\": \"^15.5.4\",
    \"styled-components\": \"^3.4.5\",
    \"styled-jsx\": \"^3.0.2\",
    \"webpack\": \"^4.17.2\"
  },
  \"devDependencies\": {
    \"@babel/cli\": \"^7.0.0\",
    \"@babel/core\": \"^7.0.0\",
    \"@babel/preset-env\": \"^7.0.0\",
    \"@babel/preset-react\": \"^7.0.0\",
    \"babel-loader\": \"^8.0.2\",
    \"css-loader\": \"^1.0.0\",
    \"eslint\": \"^5.5.0\",
    \"eslint-loader\": \"^2.1.0\",
    \"eslint-plugin-react\": \"^7.11.1\",
    \"html-webpack-plugin\": \"^3.2.0\",
    \"react-hot-loader\": \"^3.0.0-beta.7\",
    \"style-loader\": \"^0.23.0\",
    \"webpack-cli\": \"^3.1.0\",
    \"webpack-dev-server\": \"^3.1.7\"
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

echo \"import styled from 'styled-components';

function \$1(){
  return (
    <Main>
      <h1>\$1 Component Created Successfully</h1>
    </Main>
  );
}

const Main = styled.div\\\`
  background-color: black;
  fontFamily: sans-serif;
  paddingTop: 50px;
  color: white;
  \\\`
;

export default \$1;
\" > \"\$1.jsx\"
" > ./bin/generate-component.sh

echo  "#!/usr/bin/env bash

git config user.name \"\$1\"
git config user.email \"\$2\"
" > ./bin/git-config.sh

chmod 755 ./bin/*.sh

mkdir src
mkdir src/components

git init
npm init -y
npm install

npm run gen App

echo "import 'bootstrap/dist/css/bootstrap.min.css';
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
    render(App);
  });
}
" > ./src/index.jsx

echo "#Start gitignore
.DS-STORE
node_modules
build
# John they did not read my project if you are seeing this
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
  //development, production or none
  mode: 'development',

  entry: [
    'react-hot-loader/patch',
    'webpack-dev-server/client?http://localhost:8080',
    'webpack/hot/only-dev-server',
    resolve(__dirname, 'src') + '/index.jsx'
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

  plugins: [
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      Popper: 'popper.js',
      React: 'react',
      ReactDOM: 'react-dom'
    }),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NamedModulesPlugin(),
    new HtmlWebpackPlugin({
      template:'template.ejs',
      appMountId: 'react-app-root',
      title: 'React Help Queue',
      filename: resolve(__dirname, 'build', 'index.html'),
    }),
  ],

  module: {
    rules: [
      {
        test: /\.jsx?$/,
        enforce: 'pre',
        loader: 'eslint-loader',
        exclude: /node_modules/,
        options: {
          emitWarning: true,
          configFile: './.eslintrc.json'
        }
      },
      {
        test: /\.jsx?$/,
        loader: 'babel-loader',
        exclude: /node_modules/,
        options: {
          presets: [
            '@babel/preset-react',
            '@babel/preset-env'
          ],
          plugins: [
            'react-hot-loader/babel',
            'styled-jsx/babel'
          ]
        }
      },
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader']
      }
    ],
  }
};
" > webpack.config.js

echo "{
  \"globals\": {
    \"ReactDOM\": true,
    \"$\": true,
    \"jQuery\": true,
    \"Popper\": true,
    \"React\": true
  },
  \"env\": {
    \"browser\": true,
    \"es6\": true,
    \"amd\": true,
    \"node\": true
  },
  \"extends\": \"eslint:recommended\",
  \"parserOptions\": {
    \"ecmaFeatures\": {
      \"jsx\": true
    },
    \"ecmaVersion\": 2018,
    \"sourceType\": \"module\"
  },
  \"plugins\": [
    \"react\"
  ],
  \"rules\": {
    \"react/jsx-key\": 2,
    \"react/jsx-uses-vars\": 2,
    \"react/jsx-uses-react\": 2,
    \"react/jsx-no-duplicate-props\": 2,
    \"react/jsx-no-undef\": 2,
    \"react/no-multi-comp\": 2,
    \"react/jsx-indent-props\": [
      \"error\",
      2
    ],
    \"react/jsx-pascal-case\": 2,
    \"react/prop-types\": 2,
    \"react/jsx-indent\": [
      \"error\",
      2
    ],
    \"indent\": [
      \"error\",
      2
    ],
    \"linebreak-style\": [
      \"error\",
      \"unix\"
    ],
    \"quotes\": [
      \"error\",
      \"single\"
    ],
    \"semi\": [
      \"error\",
      \"always\"
    ],
    \"no-unused-vars\": 1
  }
}
" > .eslintrc.json


echo "
**Use as Needed for Components**
* import PropTypes from 'prop-types';
* import styled from 'styled-components';

**Prop Type Examples**

\`\`\`
[component-name].propTypes = {
 [variable-name]: PropTypes.string,
};
\`\`\`

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

**Styled Examples**

\`\`\`
<Main className=\"card\">
  <ButtonTest className=\"btn\"Test</ButtonTest
</Main>
\`\`\`
\`\`\`
const ButtonTest = styled.button\`
  background-color: red;
  &:hover \${ButtonTest}
  {
    background-color: teal;
  }
\`;
\`\`\`
\`\`\`
const Main = styled.div\`
  backgroundColor: #ecf0f1;
  fontFamily: sans-serif;
  paddingTop: 50px;
  \`
;
\`\`\`
" > ./src/components/README.md

echo "*.md
" > .eslintignore
