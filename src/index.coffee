pixi = require 'pixi.js'
raf = require 'raf'
Scene = require './engine/Scene'
Map = require './engine/Map'

map = new Map Math.random()
scene = new Scene document.getElementById('main'), map

raf().on 'data', (delta) ->
  scene.render()

