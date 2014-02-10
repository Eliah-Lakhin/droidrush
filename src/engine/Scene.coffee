pixi = require 'pixi.js'
$$ = require './consts'
Planet = require './Planet'

module.exports = class Scene extends pixi.Stage
  constructor: (canvas, map) ->
    super $$.colors.bg
    @renderer = pixi.autoDetectRenderer $$.scene.width, $$.scene.height, canvas,
      false, true

    for {x, y, production, id} in map.planets
      do (id) =>
        pl = new Planet x, y, production, 0xff00ff
        pl.mousedown = -> console.log id

        @addChild pl

  render: ->
    @renderer.render @
