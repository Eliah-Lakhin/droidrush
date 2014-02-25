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
Planet = require './Planet'
Trooper = require './Trooper'
Selection = require './Selection'
Keyboard = require 'keyboard-cjs'

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

    @keyboard = new Keyboard window

    @selection = new Selection @

  render: ->
    @renderer.render @
