DssPortal.Views.NewBookmark = Backbone.View.extend

  initialize: ->
    @collection = @options.person.applicationAssignments
    @model = new @collection.model()
    @$el.html JST["templates/application_assignments/bookmark_form"](@model.toJSON())
    @bind("cancel", @removeFromDOM)
    @bind("ok", @save)
    
  removeFromDOM: (modal) ->
    window.location.hash = "#/index"
    modal.remove()

  save: (modal) ->
    @model.set
      name: $("input[name='name'").val()
      description: $("input[name='description']").val()
      url: $("input[name='url']").val()
      person_id: DssPortal.current_user.get("id")
      cached_application: "koko"
    
    @collection.add(@model.toJSON())
    console.log @collection
    @options.person.save()
    
  render: ->
    @

