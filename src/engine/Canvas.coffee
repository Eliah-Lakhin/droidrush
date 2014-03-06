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
$$ = require '../consts/.'

module.exports = class Canvas extends pixi.Stage
  constructor: (settings) ->
    super $$.ui.canvas.bg.color

    @renderer = pixi.autoDetectRenderer(
      $$.ui.canvas.width
      $$.ui.canvas.height
      settings.canvas
      false
      true
    )

  render: ->
    @renderer.render @
