ng = angular

ng.module 'nwService', []
ng.module 'github-status-tray.ctrls', []
ng.module 'github-status-tray.services', []
ng.module 'github-status-tray', [
    'github-status-tray.ctrls',
    'github-status-tray.services',
    'nwService'
  ]

ng.module('github-status-tray').value 'require',require
ng.module('nwService').value 'require',require
