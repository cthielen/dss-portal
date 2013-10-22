DssPortal.Views.BookmarkForm = Backbone.View.extend

  events:
    "keyup input[name='name']": "validateName"
    "keyup input[name='url']": "validateURL"

  initialize: ->
    @validatedOnce = false
    if @options.id
      # Get the model if we passed an ID
      @model = DssPortal.current_user.applicationAssignments.get(@options.id)
    else
      # If no ID, create an empty model
      @model = new DssPortal.Models.ApplicationAssignment()
    
    @$el.html JST["templates/application_assignments/bookmark_form"]()
    # Modal documentation requires non-event arrays?
    @bind("cancel", @redirectToIndex)
    @bind("ok", @validate)

  redirectToIndex: (modal) ->
    window.location.hash = "#/index"

  validate: (modal) ->
    modal.preventClose()

    @validatedOnce = true
    @errors = false
    @validateName()
    @validateURL()

    if !@errors
      @save(modal)

  validateName: ->
    @$("input[name='name']").closest('.control-group .controls').children('p.error-message').remove()
    @$("input[name='name']").closest('.control-group').removeClass('error')
    # Validate name is not empty
    if @$("input[name='name']").val() is '' && @validatedOnce
      @errors = true
      @$("input[name='name']").closest('.control-group').addClass('error')
      @$("input[name='name']").closest('.control-group .controls').append('<p class="help-block error-message">Name may not be blank</p>')

  validateURL: ->
    @$("input[name='url']").closest('.control-group .controls').children('p.error-message').remove()
    @$("input[name='url']").closest('.control-group').removeClass('error')
    # Validate URL
    if !/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/.test(@$("input[name='url']").val()) && @validatedOnce
      @errors = true
      @$("input[name='url']").closest('.control-group').addClass('error')
      @$("input[name='url']").closest('.control-group .controls').append('<p class="help-block error-message">Use a valid URL. Example: ucdavis.edu</p>')

  save: (modal) ->
    # Disable save button and change its text.
    $("a.ok").text("Saving...").attr('disabled', 'disabled').addClass('btn-inverse');

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
      wait:true
      success: =>
        DssPortal.current_user.applicationAssignments.add @model if isNew
        modal.close()
        window.location.hash = "#/index"
          
      error: (bookmark, error) =>
        $("a.ok").text("Try saving again").removeAttr('disabled').removeClass('btn-inverse');
        console.log error
    )

  render: ->
    _.defer =>
      @$("input[name='name']").val(@model.get('cached_application').name)
      @$("input[name='url']").val(@model.get('cached_application').url)
    @
