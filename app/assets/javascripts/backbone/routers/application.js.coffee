class Discovery.Routers.Router extends Backbone.Router
  routes:
    "": "root"
    
  root: ->
    window.page = new Discovery.Models.Page
    indexView = new Discovery.Views.Index({ model: page, el: $("#bar") })
        
#window.router = new Discovery.Routers.Router
#Backbone.history.start {pushState: true}