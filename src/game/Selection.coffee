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

      flag = x1 - border <= x <= x2 + border and y1 - border <= y <= y2 + border

      if @stage.keyboard.shift
        planet.select planet.selected or flag
      else if @stage.keyboard.ctrl or @stage.keyboard.meta
        if flag then planet.select false
      else
        planet.select flag

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
      if x2 - x1 > 0 and y2 - y1 > 0
        @moveTo x1, y1
        @lineTo x2, y1
        @lineTo x2, y2
        @lineTo x1, y2
        @lineTo x1, y1