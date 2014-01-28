pixi = require 'pixi'
Field = require './game/Field'

field = new Field

document.body.appendChild field.getCannvas()

field.render()