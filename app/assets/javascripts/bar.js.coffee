class MyGovBar
    el: $ "#bar"
    
    constructor: ->
      parent_url = decodeURIComponent document.location.origin
      XD.receiveMessage @recieve, parent_url.replace( /\/$/, '')
      $('#logo').click (e) => 
        e.preventDefault()
        @send 'clicked!'
        false
      
      window.page = new Discovery.Models.Page
      indexView = new Discovery.Views.Index({ model: page, el: $("#bar") })

    recieve: (msg) ->
      console.log msg
      
    send: (msg) ->
      parent_url = decodeURIComponent document.location.host.replace(/^#/, '')
      XD.postMessage msg, parent_url, parent 

window.MyGovBar = new MyGovBar()