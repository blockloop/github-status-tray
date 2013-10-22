_ = require('lodash')
request = require('request')
moment = require('moment')

# exit the application
exports.exit = ->
  exports.tray.remove()
  exports.tray = null
  exports.gui.App.quit()


# show a window by name
exports.showWindow = (name, options) ->
  name ?= 'settings'
  win = exports.getWindow(name) or exports.newWindow(name, options)
  win.open() if win.closed
  win.show()
  win.focus()
  win.on 'close', ->
    win.hide()
  win.on 'minimize', ->
    win.hide()
  win.on 'blur', ->
    win.hide()
  return win


# get a window by name
exports.getWindow = (name) -> @windows[name]


# create a new window
# if there is no name provided we get the main
exports.newWindow = (name, options) ->
  open = window.open("views/#{name}.html", options) if name
  win = exports.gui.Window.get(open)
  @windows[name] = win
  # win.showDevTools()


exports.setTrayIcon = (level)->
  exports.tray.icon = getIcon level


exports.getIcon = (level) ->
  # throw new Error('args:level must be 0-2') if level > 2 or level < 0
  switch level
    when 0 then return "app/imgs/status-icon-green.png"
    when 1 then return "app/imgs/status-icon-orange.png"
    when 2 then return "app/imgs/status-icon-red.png"


exports.updateStatus = ->
  cb = (err, resp, body) ->
    console.log 'status updated'
    throw err if err #XXX remove this when deploying and just console.error

    levels = "good": 0, "minor": 1, "major": 2
    icon = exports.getIcon(levels[body.status])

    # TODO IMPLEMENT notify -- don't use @
    # need to use an external variable when notifications are implemented
    if @currentMessage isnt body.body or @currentStatus isnt body.status
      @currentMessage = body.body
      @currentStatus = body.status
      # exports.notify icon, "Github status change!", currentMessage
      exports.tray.icon = icon

    now = moment().format('M/DD h:mma')
    exports.tray.tooltip = "#{now}\n#{@currentMessage}"

  request.get
    url: "https://status.github.com/api/last-message.json"
    json: true
  , cb


# initialize the application
# since the script runs before the DOM we cannot
# load nw.gui so wait for nwService to initialize it
exports.init = ->
  return if exports.gui # prevent multiple calls
  exports.gui = global.window.nwDispatcher.requireNwGui()
  @windows = {}

  # create main window
  exports.newWindow()

  exports.tray = new exports.gui.Tray
    icon: exports.getIcon 0

  @menu = new exports.gui.Menu()

  menuItems = [
    new exports.gui.MenuItem
      type: 'normal'
      label: 'Refresh'
      click: -> exports.updateStatus()
  ,
    new exports.gui.MenuItem
      type: 'normal'
      label: 'Settings'
      click: -> exports.showWindow 'settings'
  ,
    new exports.gui.MenuItem
      type: 'separator'
  ,
    new exports.gui.MenuItem
      type: 'normal'
      label: 'Exit'
      click: exports.exit
  ]

  @menu.append item for item in menuItems

  exports.tray.menu = @menu
  exports.updateStatus()
  setInterval exports.updateStatus, 1000*60*10 # update every ten minutes
  return


