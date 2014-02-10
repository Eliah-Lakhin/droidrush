generator = require 'seed-random'
$$ = require './consts'

module.exports = class Map
  colors: []
  planets: []

  constructor: (@seed, @players) ->
    console.log 'Seed: ' + @seed

    random = if @seed then generator @seed else generator()

    defaultDistance = $$.map.planetDistance
    homeDistance = Math.max(
      defaultDistance
      Math.min($$.scene.width / @players, $$.scene.height / @players) * 2 - $$.planet.maxRadius * 2
    )
    defaultDistance *= defaultDistance
    homeDistance *= homeDistance

    generate = (homeplanet) =>
      if homeplanet
        production = 100
      else
        production = Math.ceil(random() * (100 - $$.map.production.min) / $$.map.production.step) *
          $$.map.production.step + $$.map.production.min

      loop
        x1 = random() * ($$.scene.width - $$.planet.maxRadius * 2) +
          $$.planet.maxRadius
        y1 = random() * ($$.scene.height - $$.planet.maxRadius * 2) +
          $$.planet.maxRadius

        clashes = @planets.some ({x: x2, y: y2, owner}) ->
          distance = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
          if owner >= 0 and homeplanet then distance < homeDistance
          else distance < defaultDistance
        if not clashes then break

      {x: x1, y: y1, production}

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