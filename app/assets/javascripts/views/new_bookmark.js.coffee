DssPortal.Views.NewBookmark = Backbone.View.extend

  initialize: ->
    @$el.html JST["templates/application_assignments/bookmark_form"]()
    # Modal documentation requires non-event arrays?
    @bind("cancel", @removeFromDOM)
    @bind("ok", @save)
    
  removeFromDOM: (modal) ->
    console.log "removing"
    window.location.hash = "#/index"
    modal.remove()

  save: (modal) ->
    DssPortal.current_user.applicationAssignments.add(
      person_id: DssPortal.current_user.get("id")
      cached_application:
        name: $("input[name='name'").val()
        description: $("input[name='description']").val()
        url: $("input[name='url']").val()
    )
    DssPortal.current_user.save()
    
  render: ->
    @
