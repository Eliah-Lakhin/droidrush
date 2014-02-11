pixi = require 'pixi.js'
$$ = require './consts'

module.exports = class Planet extends pixi.DisplayObjectContainer
  constructor: (x, y, size) ->
    super()

    @color = false
    scale = $$.planet.maxRadius / $$.planet.sprite.radius * size / 100

    @position = new pixi.Point x, y
    @hitArea = new pixi.Circle 0, 0, $$.planet.sprite.width / 2 * scale
    @interactive = true

    @sprite = new pixi.Sprite.fromImage './planets.png'
    @sprite.anchor = new pixi.Point(
      (Math.floor(Math.random() * $$.planet.sprite.types) + 0.5) / $$.planet.sprite.types
      0.75
    )
    @sprite.scale = new pixi.Point scale, scale
    @sprite.mask = new pixi.Graphics
    @sprite.mask.beginFill()
    @sprite.mask.drawCircle x, y, $$.planet.sprite.width / 2 * scale
    @sprite.mask.endFill()
    @addChild @sprite

    @accenture = new pixi.Graphics
    @addChild @accenture

    @caption = new pixi.Text size, $$.planet.font
    @caption.anchor = new pixi.Point 0.5, 0.5
    @addChild @caption

    @hover = false
    @mouseover = =>
      @hover = true
      @redraw()
    @mouseout = =>
      @hover = false
      @redraw()

    @redraw()

  setColor: (@color) -> @redraw()

  redraw: () ->
    radius = Math.floor($$.planet.sprite.radius * @sprite.scale.x) + 1

    if !!@color
      @sprite.tint = @color
      @sprite.anchor.y = 0.75
      @caption.alpha = 0.75
    else
      @sprite.anchor.y = 0.75 - @hover / 2
      @caption.alpha = 0.75 - @hover / 2

    @accenture.clear()
    if @hover or @selected
      @accenture.lineStyle 1, $$.colors.highlight, 1
      @accenture.drawCircle 0, 0, radius + 7
