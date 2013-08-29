moduleName = 'nwService'
name = 'nwService'
typ = 'service'
deps = []

fn = () ->
  root = process.mainModule.exports

  root.init()

  this.exit = root.exit

  this.getWindow = root.getWindow

  this.showWindow = root.showWindow

  this.setMenuItem = root.setMenuItem

  this.updateStatus = root.updateStatus

  return

deps.push fn
angular.module(moduleName)[typ](name,deps)



