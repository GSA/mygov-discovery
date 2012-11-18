class Discovery.Views.Index extends Backbone.View
  
  template: JST['backbone/templates/index']
  
  events: 
    "click #save_tags": "save"
  
  render: ->
    $(@el).html( @template( @model.toJSON() ))    
    @
  
  initialize: ->
    _.bindAll @, "render"
    @.model.bind 'change', @render
    
  save: ->
    @model.save { tag_list: $("#tags").val() } 
  
  fetch: ->
    @model.fetch()