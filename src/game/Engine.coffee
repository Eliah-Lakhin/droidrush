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

generator = require 'seed-random'
$$ = require './consts'

module.exports = class Engine
  colors: []
  planets: []

  constructor: (@seed, @players, @me) ->
    console.log 'Seed: ' + @seed

    random = if @seed then generator @seed else generator()

    defaultDistance = $$.map.planetDistance
    homeDistance = Math.max(
      defaultDistance
      Math.min($$.scene.width / @players, $$.scene.height / @players) * 2 - $$.planet.maxRadius * 3
    )
    defaultDistance *= defaultDistance
    homeDistance *= homeDistance

    generate = (homeplanet) =>
      if homeplanet
        production = 100
      else
        production = Math.ceil(random() * ($$.map.production.max -
          $$.map.production.min) / $$.map.production.step) * $$.map.production.step + $$.map.production.min

      loop
        x1 = random() * ($$.scene.width - $$.planet.maxRadius * 3) +
          $$.planet.maxRadius * 1.5
        y1 = random() * ($$.scene.height - $$.planet.maxRadius * 3) +
          $$.planet.maxRadius * 1.5

        clashes = @planets.some ({x: x2, y: y2, owner}) ->
          distance = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
          if owner >= 0 and homeplanet then distance < homeDistance
          else distance < defaultDistance
        if not clashes then break

      {x: Math.round(x1), y: Math.round(y1), speed: 100 / production, production}

    for player in [1..@players]
      do (player) =>
        loop
          color = Math.floor(random() * $$.colors.players.length)
          if (@colors.indexOf color) < 0 then break

        @colors.push color

        planet = generate true
        planet.id = player
        planet.owner = player
        @planets.push planet

    for index in [1..$$.map.planets]
      do (index) =>
        planet = generate false
        planet.id = index + @players
        planet.owner = 0
        @planets.push planet
