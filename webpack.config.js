var HtmlWebpackPlugin = require('html-webpack-plugin');
var path = require('path');

module.exports = {
  context: __dirname + '/src/',
  entry: ['./app.js'],
  resolveLoader: {
    root: path.join(__dirname, 'node_modules')
  },
  output: {
    path: __dirname + '/dist',
    filename: '[name].js'
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: 'Elm\'s House of Bowling',
      template: 'index.html', // Load a custom template
      inject: 'body', // Inject all scripts into the body
      filename: 'bowling.html',
      hash: true
    })
  ],
  module: {
    loaders: [
      { 
        test: /\.jsx?$/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015', 'react']
        }
      },
      {
        test: /\.elm$/,
        loader: 'elm-webpack',
        exclude: [/elm-stuff/, /node_modules/]
      }
    ]
  }
};
