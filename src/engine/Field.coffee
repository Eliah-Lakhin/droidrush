pixi = require 'pixi'
params = require './params'
Cell = require './Cell'
Player = require './Player'

module.exports = class GameField extends pixi.Stage
  cells: {}

  constructor: ->
    @renderer = pixi.autoDetectRenderer params.field.width, params.field.height

    super params.colors.bg

    @egg = new Player

    for [0..params.cell.count - 1]
      i = 0
      j = 0
      index = ''
      loop
        i = Math.floor(Math.random() * params.grid.horizontal)
        j = Math.floor(Math.random() * params.grid.vertical)
        index = i + ' ' + j
        break if not @cells[index]

      cell = new Cell @egg
      cell.move i, j
      @addChild cell
      @cells[index] = cell

  render: -> @renderer.render @

  getCannvas: -> @renderer.view