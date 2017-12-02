/*
  Droid Rush - browser based minimalistic realtime strategic videogame.

  Copyright (C) 2014 Ilya Lakhin (Илья Александрович Лахин) <eliah.lakhin@gmail.com>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

const path = require('path');
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');

const cssExtractor =
  new ExtractTextPlugin('assets/[name].[contenthash].css');

const lessExtractor =
  new ExtractTextPlugin('assets/[name].[contenthash].css');

const ENV = process.env.NODE_ENV;

module.exports = {

  entry: {
    'polyfills': path.resolve(__dirname, './src/polyfills.ts'),
    'vendor': path.resolve(__dirname, './src/vendor.ts'),
    'app': path.resolve(__dirname, './src/main.ts')
  },

  output: {
    path: path.resolve(__dirname, './dist'),
    publicPath: '/',
    filename: '[name].[hash].js',
    chunkFilename: '[id].[hash].chunk.js'
  },

  resolve: {
    extensions: ['.ts', '.js']
  },

  devtool: 'cheap-module-eval-source-map',

  devServer: {
    historyApiFallback: true,
    stats: 'minimal'
  },

  module: {
    rules: [
      {
        test: /\.ts$/,
        loaders: [
          {
            loader: 'awesome-typescript-loader',
            options: {
              configFileName: path.resolve(__dirname, './tsconfig.json')
            }
          },
          'angular2-template-loader'
        ]
      },
      {
        test: /\.html$/,
        loader: 'html-loader'
      },
      {
        test: /\.(png|jpe?g|gif|svg|woff|woff2|ttf|eot|ico)$/,
        loader: 'file-loader?name=assets/[name].[hash].[ext]'
      },
      {
        test: /\.css$/,
        loader: cssExtractor.extract([ 'css-loader' ])
      },
      {
        test: /\.scss$/,
        loader: lessExtractor.extract({
          use: [
            'css-loader',
            {
              loader: 'postcss-loader',
              options: {
                plugins: () => [ require('precss'), require('autoprefixer') ]
              }
            },
            'sass-loader'
          ],
          fallback: 'style-loader'
        })
      },
    ]
  },

  plugins: [
    new CleanWebpackPlugin(['dist']),

    cssExtractor,

    lessExtractor,

    new webpack.ContextReplacementPlugin(
      /angular(\\|\/)core(\\|\/)(@angular|esm5)/,
      path.resolve(__dirname, './src')
    ),

    new webpack.optimize.CommonsChunkPlugin({
      name: ['app', 'vendor', 'polyfills']
    }),

    new HtmlWebpackPlugin({
      template: 'src/index.html'
    }),

    new webpack.DefinePlugin({
      'process.env': {
        'ENV': JSON.stringify(ENV),
        'production': JSON.stringify(ENV === 'production'),
        'development': JSON.stringify(ENV === 'development')
      }
    }),

    new webpack.LoaderOptionsPlugin({
      htmlLoader: {
        minimize: ENV === 'production'
      }
    }),

    new webpack.NoEmitOnErrorsPlugin(),

    new webpack.optimize.UglifyJsPlugin({
      mangle: {
        keep_fnames: ENV === 'development'
      }
    })
  ]
};
