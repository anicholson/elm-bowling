var HtmlWebpackPlugin = require('html-webpack-plugin');
var path = require('path');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  context: __dirname + '/src/',
  entry: ['./app.js'],
  resolveLoader: {
    root: path.join(__dirname, 'node_modules')
  },
  output: {
    path: __dirname + '/dist',
    filename: '[name].js',
    libraryTarget: 'umd'
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: 'Elm\'s House of Bowling',
      template: 'index.html', // Load a custom template
      inject: 'body', // Inject all scripts into the body
      filename: 'index.html',
      hash: true
    }),
    new ExtractTextPlugin('style.css', { allChunks: true })
  ],
  module: {
    loaders: [
      { 
        test: /\.jsx?$/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015', 'react']
        },
        exclude: [/node_modules/]
      },
      {
        test: /\.elm$/,
        loader: 'elm-webpack',
        exclude: [/elm-stuff/, /node_modules/]
      },
      {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract('style-loader', 'css-loader?modules&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]!postcss-loader')
      }
    ]
  },
  postcss: [
    require('autoprefixer-core'),
    require('postcss-color-rebeccapurple')
  ]
};
