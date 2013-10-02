DssPortal.Views.BookmarkForm = Backbone.View.extend

  initialize: ->
    if @options.id
      # Get the model if we passed an ID
      @model = DssPortal.current_user.applicationAssignments.get(@options.id)
    else
      # If no ID, create an empty model
      @model = new DssPortal.current_user.applicationAssignments.model()
    
    @$el.html JST["templates/application_assignments/bookmark_form"]()
    # Modal documentation requires non-event arrays?
    @bind("cancel", @removeFromDOM)
    @bind("ok", @save)
    
  removeFromDOM: (modal) ->
    window.location.hash = "#/index"
    modal.close()

  save: (modal) ->
    if @options.id
      @model.save(
        person_id: DssPortal.current_user.get("id")
        bookmark: true
        cached_application:
          name: $("input[name='name']").val()
          url: $("input[name='url']").val()
          icon_path: "/assets/#{$("input[name='name']").val().toLowerCase()[0]}.jpg"
      )
    else
      DssPortal.current_user.applicationAssignments.add(
        person_id: DssPortal.current_user.get("id")
        bookmark: true
        cached_application:
          name: $("input[name='name']").val()
          url: $("input[name='url']").val()
          icon_path: "/assets/#{$("input[name='name']").val().toLowerCase()[0]}.jpg"
      )

    DssPortal.current_user.save(null,
      success: (person) =>
        window.location.hash = "#/index"
      error: (person, error) =>
        console.log error
    )
    
  render: ->
    _.defer =>
      @$("input[name='name']").val(@model.get('cached_application').name)
      @$("input[name='url']").val(@model.get('cached_application').url)
    @
