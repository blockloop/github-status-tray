name = 'configService'
typ = 'service'
deps = []

fn = ($scope) ->
  this.put = (name,value) ->
    throw new Error('arg:name is required') unless name
    throw new Error('arg:value is required') unless value
    str = JSON.stringify value
    localStorage.setItem name,str

  this.get = (name) ->
    throw new Error('arg:name is required') unless name
    str = localStorage.getItem name
    result
    try result = JSON.parse(str) catch
    return result

  return

deps.push fn
angular.module('github-status-tray.services')[typ](name,deps)
