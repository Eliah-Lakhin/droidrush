###
    Droid Rush - browser based minimalistic realtime strategic videogame.
    Copyright (C) 2014 Ilya Lakhin (Илья Александрович Лахин) <eliah.lakhin@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
###

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
      #(Math.floor(Math.random() * $$.planet.sprite.types) + 0.5) / $$.planet.sprite.types
      0.1
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

  select: (flag) ->
    if @selected isnt flag
      @selected = flag
      @redraw()

  redraw: () ->
    radius = Math.floor($$.planet.sprite.radius * @sprite.scale.x) + 1

    if !!@color
      @sprite.tint = @color
#      @sprite.anchor.y = 0.75
    else
#      @sprite.anchor.y = 0.75 - @hover / 2

    @accenture.clear()
    if @hover or @selected
      @accenture.lineStyle 1, $$.colors.highlight, 1
      @accenture.drawCircle 0, 0, radius + 7
