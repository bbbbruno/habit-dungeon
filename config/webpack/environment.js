const { environment } = require('@rails/webpacker')
const jquery = require('./plugins/jquery')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.loaders.get('sass').use.push('import-glob-loader')
environment.plugins.prepend('jquery', jquery)
module.exports = environment
