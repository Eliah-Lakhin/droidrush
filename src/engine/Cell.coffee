pixi = require 'pixi'
params = require './params'

module.exports = class Cell extends pixi.Graphics
  constructor: (@player) ->
    super()

    @move 0, 0

    @size = Math.ceil(Math.random() * (100 - params.cell.minSize) +
      params.cell.minSize)

    blur = new pixi.BlurFilter()

    blur.blue = 1

    @draw()

  move: (@i, @j) ->
    @position.x = @i * params.cell.step[0] + params.field.padding
    @position.y = @j * params.cell.step[1] + params.field.padding

  draw: ->
    @clear
    @beginFill params.colors[@player.color]
    @drawCircle 0, 0, Math.max(@size / 100 * params.cell.maxRadius,
      params.cell.minRadius)
    @endFill