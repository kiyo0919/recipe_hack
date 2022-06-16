const { environment } = require('@rails/webpacker')

module.exports = environment
<<<<<<< HEAD
=======

const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)
>>>>>>> b87a0b962c61c4a0e7cf1b80daaa35a05a8a1fda
