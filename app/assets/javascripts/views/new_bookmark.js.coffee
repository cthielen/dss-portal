DssPortal.Views.NewBookmark = Backbone.View.extend

  initialize: ->
    console.log @model
    @$el.html JST["templates/application_assignments/bookmark_form"]()
    @bind("cancel", @removeFromDOM)
    @bind("ok", @save)
    
  removeFromDOM: (modal) ->
    window.location.hash = "#/index"
    modal.remove()

  save: (modal) ->
    window.location.hash = "#/index"
    
  render: ->
    @

