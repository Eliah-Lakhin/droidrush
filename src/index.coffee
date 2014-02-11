pixi = require 'pixi.js'
raf = require 'raf'
Scene = require './game/Scene'
Engine = require './game/Engine'

engine = new Engine Math.floor(Math.random() * 100000).toString(), 3
scene = new Scene document.getElementById('main'), engine

raf().on 'data', (delta) ->
  scene.render()
