class MyGovBar
    el: $ "#bar"
    
    constructor: ->
      @parent_url = decodeURIComponent( document.location.hash.replace(/^#/, '') ).replace( /\/$/, '')
      XD.receiveMessage @recieve, @parent_url
      
      window.page = new Discovery.Models.Page
      indexView = new Discovery.Views.Index({ model: page, el: $("#bar") })

    recieve: (msg) =>
      switch msg.data
        when "shown", "hidden" then @toggleVisibility()
      
    send: (msg) =>
      XD.postMessage msg, @parent_url 

    toggleVisibility: ->
      @el.toggleClass 'hidden'
      @el.toggleClass 'shown'

window.MyGovBar = new MyGovBar()