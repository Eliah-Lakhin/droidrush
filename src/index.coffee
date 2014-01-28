pixi = require 'pixi'
Field = require './engine/Field'

field = new Field

document.body.appendChild field.getCannvas()

field.render()