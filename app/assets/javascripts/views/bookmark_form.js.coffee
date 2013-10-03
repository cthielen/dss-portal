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
    @bind("ok", @validate)
    
  removeFromDOM: (modal) ->
    window.location.hash = "#/index"
    modal.close()

  validate: (modal) ->
    errors = false
    $('p.error-message').remove()
    $('.error').removeClass('error')
    @$("input[type='text']").each (i,e) =>
      if $(e).val() is ''
        errors = true
        modal.preventClose()
        $(e).closest('.control-group').addClass('error')
        $(e).closest('.control-group .controls').append('<p class="help-block error-message">May not be blank</p>')
    @save() if !errors

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
