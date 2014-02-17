$$ = require './consts'
pixi = require 'pixi.js'
Planet = require './Planet'

module.exports = class Selection extends pixi.Graphics
  constructor: (scene) ->
    super

    @visible = false

    scene.addChild @

    scene.mousedown = (interaction) =>
      @start = interaction.global.clone()
      @end = interaction.global.clone()
      @visible = true
      @redraw()

    scene.mousemove = (interaction) =>
      if @visible
        @end = interaction.global.clone()
        @performSelection()
        @redraw()

    scene.mouseup = =>
      @visible = false
      @performSelection()

  performSelection: ->
    for planet in @stage.children when planet instanceof Planet
      x = planet.position.x
      y = planet.position.y
      border = planet.hitArea.radius
      [x1, y1, x2, y2] = @rectange()
      planet.select x1 - border <= x <= x2 + border and y1 - border <= y <= y2 + border

  rectange: -> [
    Math.min @start.x, @end.x
    Math.min @start.y, @end.y
    Math.max @start.x, @end.x
    Math.max @start.y, @end.y
  ]

  redraw: ->
    if @visible
      [x1, y1, x2, y2] = @rectange()

      @clear()
      @lineStyle 1, $$.colors.highlight, 1
      @moveTo x1, y1
      @lineTo x2, y1
      @lineTo x2, y2
      @lineTo x1, y2
      @lineTo x1, y1