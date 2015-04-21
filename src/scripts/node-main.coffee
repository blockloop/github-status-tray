_ = require('lodash')
request = require('request')
moment = require('moment')

# exit the application
exports.exit = @exit = =>
  @tray.remove()
  @tray = null
  @gui.App.quit()


# show a window by name
exports.showWindow = @showWindow = (name, options) =>
  name ?= 'settings'
  win = @getWindow(name)

  if !win
    win = @newWindow(name, options)
    win.on 'close', win.hide
    win.on 'minimize', win.hide
    win.on 'blur', win.hide

  win.open() if win.closed
  win.show()
  win.focus()
  return win


# get a window by name
exports.getWindow = @getWindow = (name) => @windows[name]


# create a new window
# if there is no name provided we get the main
exports.newWindow = @newWindow = (name, options) =>
  open = window.open("views/#{name}.html", options) if name
  win = @gui.Window.get(open)
  @windows[name] = win
  # win.showDevTools()


exports.setTrayIcon = @setTrayIcon = (level)=>
  @tray.icon = getIcon level


exports.getIcon = @getIcon = (level) =>
  if level is "minor"
    return "app/imgs/status-icon-orange.png"
  if level is "major"
    return "app/imgs/status-icon-red.png"
  return "app/imgs/status-icon-green.png"


exports.updateStatus = @updateStatus = =>
  cb = (err, resp, body) =>
    console.log 'status updated'
    throw err if err #XXX remove this when deploying and just console.error

    icon = @getIcon(body.status)

    # TODO IMPLEMENT notify -- don't use @
    # need to use an external variable when notifications are implemented
    if @currentMessage isnt body.body or @currentStatus isnt body.status
      @currentMessage = body.body
      @currentStatus = body.status
      # @notify icon, "Github status change!", currentMessage
      @tray.icon = icon

    now = moment().format('M/DD h:mmA')
    @tray.tooltip = "#{now}\n#{@currentMessage}"

  request.get({
    url: "https://status.github.com/api/last-message.json"
    json: true
  }, cb)


# initialize the application
# since the script runs before the DOM we cannot
# load nw.gui so wait for nwService to initialize it
exports.init = @init = =>
  return if @gui # prevent multiple calls
  @gui = global.window.nwDispatcher.requireNwGui()
  @windows = {}

  # create main window
  @newWindow()

  @tray = new @gui.Tray
    icon: @getIcon("good")

  @menu = new @gui.Menu()

  menuItems = [
    new @gui.MenuItem
      type: 'normal'
      label: 'Refresh'
      click: => @updateStatus()
  ,
    new @gui.MenuItem
      type: 'normal'
      label: 'Settings'
      click: => @showWindow 'settings'
  ,
    new @gui.MenuItem
      type: 'separator'
  ,
    new @gui.MenuItem
      type: 'normal'
      label: 'Exit'
      click: @exit
  ]

  @menu.append item for item in menuItems

  @tray.menu = @menu
  @updateStatus()
  setInterval @updateStatus, 1000*60*10 # update every ten minutes
  return


