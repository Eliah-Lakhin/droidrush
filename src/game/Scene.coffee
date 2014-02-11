pixi = require 'pixi.js'
$$ = require './consts'
Planet = require './Planet'
Trooper = require './Trooper'

module.exports = class Scene extends pixi.Stage
  constructor: (canvas, engine) ->
    super $$.colors.bg
    @renderer = pixi.autoDetectRenderer $$.scene.width, $$.scene.height, canvas,
      false, true

    for {x, y, production, id, owner} in engine.planets
      do (production) =>
        pl = new Planet x, y, production

        if owner > 0
          pl.setColor $$.colors.players[engine.colors[owner - 1]][1]

        pl.mousedown = -> console.log production

        @addChild pl

    trooper = new Trooper
    trooper.position = new pixi.Point 100, 200
    @addChild trooper

  render: ->
    @renderer.render @
