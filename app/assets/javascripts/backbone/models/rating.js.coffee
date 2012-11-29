class Discovery.Models.Rating extends Backbone.Model
  paramRoot: 'rating'
  urlRoot: "http://local.dev:3000/"
  
  url: ->
    @urlRoot + "pages/" + @page_id + "/ratings.json?callback=?"