pixi = require 'pixi.js'
$$ = require './consts'
Planet = require './Planet'

module.exports = class Scene extends pixi.Stage
  constructor: (canvas, map) ->
    super $$.colors.bg
    @renderer = pixi.autoDetectRenderer $$.scene.width, $$.scene.height, canvas,
      false, true

    for {x, y, production, id, owner} in map.planets
      do (production) =>
        pl = new Planet x, y, production

        if owner > 0
          pl.setColor $$.colors.players[map.colors[owner - 1]][1]

        pl.mousedown = -> console.log production

        @addChild pl

  render: ->
    @renderer.render @
