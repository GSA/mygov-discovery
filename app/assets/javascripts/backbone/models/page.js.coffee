class Discovery.Models.Page extends Backbone.Model
  paramRoot: 'page'

  defaults:
    url: null

class Discovery.Collections.PagesCollection extends Backbone.Collection
  model: Discovery.Models.Page
  url: '/pages'
