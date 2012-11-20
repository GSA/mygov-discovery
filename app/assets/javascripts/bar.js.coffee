class MyGovBar
    el: $ "#bar"
    
    init: ->
        $("#logo").click (e) =>
          e.preventDefault
          @toggle()
          false
        $('.toggle_pane').click @togglePane
        @toggle()
        @initPage()
        
    hide: =>
        $('.popout').animate({'height': 0}, 200).promise().done( =>
            $('.expanded').removeClass 'expanded'
            @el.animate {width: "0%"}, 1000
        )
 
    show: =>
        @el.animate {width: "90%"}, 1000
    
    toggle: =>
        if ( @el.css( 'width') == "0px" )
            @show()
        else
            @hide()
            
    togglePane: (e) ->
        e.preventDefault
        if ( $(@).parent().hasClass('expanded') )
            @hidePane $(@).parent()
        else
            @showPane $(@).parent()
        false
        
    showPane: (pane) ->
        popout = $(pane).children('.popout')
        $(popout).clearQueue()
        $(popout).css 'left', $(this).parent().css('left')
        $(popout).animate {height: "300px"}, 1000
        $(pane).addClass('expanded')
    
    hidePane: (pane) ->
        $(pane).children('.popout').animate {height: 0}, 1000
        $(pane).removeClass('expanded') 
      
    initPage: ->
      window.page = new Discovery.Models.Page
      indexView = new Discovery.Views.Index({ model: page, el: $("#bar") })

      
window.MyGovBar = new MyGovBar()

$(document).ready ->
    window.MyGovBar.init()
