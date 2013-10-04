DssPortal.Views.BookmarkForm = Backbone.View.extend

  initialize: ->
    if @options.id
      # Get the model if we passed an ID
      @model = DssPortal.current_user.applicationAssignments.get(@options.id)
    else
      # If no ID, create an empty model
      @model = new DssPortal.Models.ApplicationAssignment()
    
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
    # Validate name is not empty
    if @$("input[name='name']").val() is ''
      errors = true
      @$("input[name='name']").closest('.control-group').addClass('error')
      @$("input[name='name']").closest('.control-group .controls').append('<p class="help-block error-message">Name may not be blank</p>')
    # Validate URL
    if !/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/.test(@$("input[name='url']").val())
      errors = true
      @$("input[name='url']").closest('.control-group').addClass('error')
      @$("input[name='url']").closest('.control-group .controls').append('<p class="help-block error-message">Use a valid URL</p>')

    if errors
      modal.preventClose()
    else
      @save()

  save: (modal) ->
    isNew = @model.isNew()
    
    @model.save(
      person_id: DssPortal.current_user.get("id")
      bookmark: true
      cached_application:
        id: @model.get('cached_application').id unless isNew
        name: $("input[name='name']").val()
        url: $("input[name='url']").val()
        icon_path: "/assets/#{$("input[name='name']").val().toLowerCase()[0]}.jpg"
    ,
      success: =>
        DssPortal.current_user.applicationAssignments.add @model if isNew
        window.location.hash = "#/index"
          
      error: (bookmark, error) =>
        console.log error
    )

  render: ->
    _.defer =>
      @$("input[name='name']").val(@model.get('cached_application').name)
      @$("input[name='url']").val(@model.get('cached_application').url)
    @
