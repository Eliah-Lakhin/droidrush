generator = require 'seed-random'
$$ = require './consts'

module.exports = class Map
  planets: []

  constructor: (@seed) ->
    random = if @seed then generator @seed else generator()

    for index in [1..$$.map.planets]
      do (index) =>
        radius = Math.ceil(random() * (100 - $$.map.production.min) / $$.map.production.step) *
          $$.map.production.step + $$.map.production.min

        loop
          x1 = random() * ($$.scene.width - $$.planet.maxRadius * 2) +
            $$.planet.maxRadius
          y1 = random() * ($$.scene.height - $$.planet.maxRadius * 2) +
            $$.planet.maxRadius
          clashes = @planets.some ({x: x2, y: y2}) ->
            (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) < $$.planet.minDistance * $$.planet.minDistance
          if not clashes
            break

        @planets.push {
          id: index
          x: x1
          y: y1
          production: radius
        }