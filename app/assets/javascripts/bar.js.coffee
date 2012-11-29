class MyGovBar
    el: $ "#bar"
    
    constructor: ->
      parent_url = decodeURIComponent document.location.hash.replace(/^#/, '')
      XD.receiveMessage @recieve, parent_url.replace( /\/$/, '')
      $('#logo').click (e) => 
        e.preventDefault()
        @send 'clicked!'
        false
    
    recieve: (msg) ->
      console.log msg
      
    send: (msg) ->
      parent_url = decodeURIComponent document.location.hash.replace(/^#/, '')
      XD.postMessage msg, parent_url, parent 

window.MyGovBar = new MyGovBar()