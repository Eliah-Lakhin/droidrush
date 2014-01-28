pixi = require 'pixi'
consts = require './consts'

fieldMin = Math.min consts.field.width, consts.field.height
gridMax = Math.max consts.grid.vertical, consts.grid.horizontal
maxRadius = Math.floor fieldMin / gridMax

module.exports = class GameField extends pixi.Stage
  constructor: ->
    @renderer = pixi.autoDetectRenderer consts.field.width, consts.field.height

    super 0xffcfcf

  render: -> @renderer.render @

  getCannvas: -> @renderer.view