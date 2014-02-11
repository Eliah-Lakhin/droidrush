pixi = require 'pixi.js'
raf = require 'raf'
Scene = require './engine/Scene'
Map = require './engine/Map'

map = new Map Math.floor(Math.random() * 100000).toString(), 9
scene = new Scene document.getElementById('main'), map

raf().on 'data', (delta) ->
  scene.render()
