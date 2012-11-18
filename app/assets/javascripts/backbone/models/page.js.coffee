class Discovery.Models.Page extends Backbone.Model
  paramRoot: 'page'
  urlRoot: "/pages/"
  url: ->
    @urlRoot + @id + ".json?callback=?"
    
  

  lookup: ->
    old_url = @url
    @url = "/pages/lookup.json?url=" + @get("url") + "&callback=?"
    @fetch()
    @url = old_url
       
  initialize: ->
    @lookup()
      
  defaults:
    url: window.location.href
  
  get_meta_keywords: ->
    $( "meta[name] ").filter( ->
      this.name.toLowerCase() == "keywords").attr("content")

class Discovery.Collections.PagesCollection extends Backbone.Collection
  model: Discovery.Models.Page
  url: '/pages'
