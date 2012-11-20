class Discovery.Models.Page extends Backbone.Model
  paramRoot: 'page'
  urlRoot: "http://local.dev:3000/pages"
  
  url: ->
    url = @urlRoot
    
    if @id?    
     url += "/" + @id
    
    url += ".json?callback=?"
    url
     
  lookup: ->
    old_url = @url
    @url = @urlRoot + "/lookup.json?url=" + @get("url") + "&callback=?"
    @fetch error: (page, err) =>
      if err.status != 404
        return
      
      @save()
      
    @url = old_url
       
  initialize: ->
    @lookup()
      
  defaults:
    url: document.referrer
  
  get_meta_keywords: ->
    $( "meta[name] ").filter( ->
      this.name.toLowerCase() == "keywords").attr("content")
  
class Discovery.Collections.PagesCollection extends Backbone.Collection
  model: Discovery.Models.Page
  url: '/pages'
