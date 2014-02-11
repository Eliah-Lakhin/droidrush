pixi = require 'pixi.js'

module.exports = class Trooper extends pixi.Sprite
  constructor: ->
    super pixi.Texture.fromImage './trooper.png'

    @anchor = new pixi.Point 0.5, 0.5
