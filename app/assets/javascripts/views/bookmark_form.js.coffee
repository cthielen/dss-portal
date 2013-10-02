DssPortal.Views.BookmarkForm = Backbone.View.extend

  initialize: ->
    @$el.html JST["templates/application_assignments/bookmark_form"]()
    # Modal documentation requires non-event arrays?
    @bind("cancel", @removeFromDOM)
    @bind("ok", @save)
    
  removeFromDOM: (modal) ->
    window.location.hash = "#/index"
    modal.close()

  save: (modal) ->
    DssPortal.current_user.applicationAssignments.add(
      person_id: DssPortal.current_user.get("id")
      bookmark: true
      cached_application:
        name: $("input[name='name'").val()
        description: $("input[name='description']").val()
        url: $("input[name='url']").val()
        icon_path: "/assets/#{$("input[name='name'").val().toLowerCase()[0]}.jpg"
    )
    DssPortal.current_user.save(null,
      success: (person) =>
        window.location.hash = "#/index"
      error: (person, error) =>
        console.log error
    )
    
  render: ->
    @
