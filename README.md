# Github Status Tray

This application is intended to give developers the ability to continuously monitor the [status of github](http://status.github.com).

As of now the status refreshes every 10 minutes and there are no settings, but check the [TODO below](#todo-what-does-not-work). You can manually refresh if you want to by right clicking the tray icon and clicking 'Refresh'.

## Usage

This app is written in [node-webkit](https://github.com/rogerwang/node-webkit). There aren't currently any compiled executables but running this application is as simple as:

```bash
$ git clone git@github.com:brettof86/github-status-tray.git
$ cd github-status-tray
$ npm install
$ nw .
```

Of course this assumes you have node-webkit installed and [nw aliased to node-webkit][how-to-alias-nw].

If you're unfamiliar with node-webkit note that **this application will eventually not care if you have node-webkit installed or not** (it will be bundled into the executable for each platform)

## What Works

- Refreshes every 10 minutes
- Shows a timestamp of the last refresh
- Shows red/orange/green status in your system tray
- ~~Notifies via custom notification (no growl yet, see below) when the status has changed~~
- Shows the current message on the top of the github status page


## TODO (What does NOT work)

- Organize code
- Testing
- Make a builder for platform specific executables (exe/app/sh)
- Give a 'refreshing' indicator when the application is refreshing
- Notifications on status change (detection like [grunt-notify](https://github.com/dylang/grunt-notify))
- Create a settings page
  - When to notify
  - Make the refresh interval configurable


## Screenshots

![Green status](https://dl.dropboxusercontent.com/u/8911647/Images/github-status-tray/ss-green.png "Green status")

![Green status alt](https://dl.dropboxusercontent.com/u/8911647/Images/github-status-tray/ss-green-mac.png "Green status Mac")

![Tray context menu](https://dl.dropboxusercontent.com/u/8911647/Images/github-status-tray/ss-context.png "Tray context menu")

![Tooltip on tray hover](https://dl.dropboxusercontent.com/u/8911647/Images/github-status-tray/ss-tooltip.png "Tooltip on tray hover")

![Orange status](https://dl.dropboxusercontent.com/u/8911647/Images/github-status-tray/ss-orange.png "Orange status")

![Red status](https://dl.dropboxusercontent.com/u/8911647/Images/github-status-tray/ss-red.png "Red status")



  [how-to-alias-nw]: https://github.com/rogerwang/node-webkit/wiki/How-to-run-apps 
