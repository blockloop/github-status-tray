name = 'settingsCtrl'
module = 'github-status-tray.ctrls'
type = 'controller'
deps = [
  '$scope',
  'require',
  'configService',
  'nwService'
]

fn = ($scope,require,configService,nw) ->

  $scope.submit = ->
    return

  return

deps.push fn
angular.module(module)[type](name,deps)
