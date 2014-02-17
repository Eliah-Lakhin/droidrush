pixi = require 'pixi.js'
$$ = require './consts'
Planet = require './Planet'
Trooper = require './Trooper'
Selection = require './Selection'

module.exports = class Scene extends pixi.Stage
  constructor: (canvas, engine) ->
    super $$.colors.bg
    @renderer = pixi.autoDetectRenderer $$.scene.width, $$.scene.height, canvas,
      false, true

    for {x, y, production, id, owner} in engine.planets
      do (production) =>
        planet = new Planet x, y, production

        if owner > 0
          planet.setColor $$.colors.players[engine.colors[owner - 1]][1]

        @addChild planet

    @selection = new Selection @

  render: ->
    @renderer.render @
