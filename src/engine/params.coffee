consts = require './consts'

params = _.extend {}, consts

params.field.min = Math.min consts.field.width, consts.field.height
params.field.max = Math.max consts.field.width, consts.field.height

params.grid.min = Math.min consts.grid.vertical, consts.grid.horizontal
params.grid.max = Math.max consts.grid.vertical, consts.grid.horizontal

params.cell.maxRadius = Math.max(
  Math.floor((params.field.min - params.field.padding * 2) / params.grid.max / 2 - consts.cell.minRadius)
  consts.cell.minRadius
)
params.cell.step = [
  (params.field.width - params.field.padding * 2) / (params.grid.horizontal - 1)
  (params.field.height - params.field.padding * 2) / (params.grid.vertical - 1)
]

module.exports = params