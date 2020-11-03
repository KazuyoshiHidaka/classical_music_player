const {environment} = require('@rails/webpacker');
var webpack = require('webpack');
var vueLoader = require('vue-loader');
var vue = require('./loaders/vue');

environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
  }),
);
environment.plugins.prepend('VueLoaderPlugin', new vueLoader.VueLoaderPlugin());
environment.loaders.prepend('vue', vue);
module.exports = environment;
