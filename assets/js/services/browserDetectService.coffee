###
BrowserDetect Service
Detects the type of browser, the version and the OS.
Easily usable in conjuction with ng-hide/ng-show.

Example (jade):
section(ng-show="browserDetect.browser == 'Explorer' && browserDetect.version < 10")
span.warn This page is not supported in IE below 10

@return {String} .browser for the browser name
@return {String} .version for the browser version
@return {String} .OS for the OS in which the browser is running
###

define ['app'], (app)->
  app.lazy.service 'browserDetect', ['$log', '$http', ($log, $http) ->
    browserDetect =
      ###
      Initializes the properties and error messages.
      @return {Boolean} True if no errors. False if errors.
      ###
      init: ->

        # Errors array
        @errors = []

        # Copy of the navigator access
        @navigator = navigator
        @browser = @searchString(@dataBrowser) or undefined

        # this.browser = "Explorer"
        @errors.push "Unknown browser"  unless @browser
        @version = @searchVersion(navigator.userAgent) or @searchVersion(navigator.appVersion) or undefined

        # this.version = 9
        @errors.push "Unknown version"  unless @version
        @OS = @searchString(@dataOS) or undefined
        @errors.push "Unkown OS"  unless @OS
        if @errors.length
          false
        else
          true

      searchString: (data) ->
        i = 0

        while i < data.length
          dataString = data[i].string
          dataProp = data[i].prop
          @versionSearchString = data[i].versionSearch or data[i].identity
          if dataString
            return data[i].identity  unless dataString.indexOf(data[i].subString) is -1
          else return data[i].identity  if dataProp
          i++

      searchVersion: (dataString) ->
        index = dataString.indexOf(@versionSearchString)
        return  if index is -1
        parseFloat dataString.substring(index + @versionSearchString.length + 1)


      ###
      Array of known Browsers
      @type {Array}
      ###
      dataBrowser: [
        string: navigator.userAgent
        subString: "Chrome"
        identity: "Chrome"
      ,
        string: navigator.userAgent
        subString: "OmniWeb"
        versionSearch: "OmniWeb/"
        identity: "OmniWeb"
      ,
        string: navigator.vendor
        subString: "Apple"
        identity: "Safari"
        versionSearch: "Version"
      ,
        prop: window.opera
        identity: "Opera"
        versionSearch: "Version"
      ,
        string: navigator.vendor
        subString: "iCab"
        identity: "iCab"
      ,
        string: navigator.vendor
        subString: "KDE"
        identity: "Konqueror"
      ,
        string: navigator.userAgent
        subString: "Firefox"
        identity: "Firefox"
      ,
        string: navigator.vendor
        subString: "Camino"
        identity: "Camino"
      ,
        # for newer Netscapes (6+)
        string: navigator.userAgent
        subString: "Netscape"
        identity: "Netscape"
      ,
        string: navigator.userAgent
        subString: "MSIE"
        identity: "Explorer"
        versionSearch: "MSIE"
      ,
        string: navigator.userAgent
        subString: "Gecko"
        identity: "Mozilla"
        versionSearch: "rv"
      ,
        # for older Netscapes (4-)
        string: navigator.userAgent
        subString: "Mozilla"
        identity: "Netscape"
        versionSearch: "Mozilla"
      ]
      dataOS: [
        string: navigator.platform
        subString: "Win"
        identity: "Windows"
      ,
        string: navigator.platform
        subString: "Mac"
        identity: "Mac"
      ,
        string: navigator.userAgent
        subString: "iPhone"
        identity: "iPhone/iPod"
      ,
        string: navigator.platform
        subString: "Linux"
        identity: "Linux"
      ]

    browserDetect.init()
    browserDetect
  ]