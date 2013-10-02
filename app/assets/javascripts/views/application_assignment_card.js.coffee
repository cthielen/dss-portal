DssPortal.Views.ApplicationAssignmentCard = Backbone.View.extend
  tagName: "li"
  id: ""
  className: "card"
  
  events:
    "click .icon-pencil": "edit"
    "click .icon-trash": "delete"
    "click": "newBookmark"
    "mouseenter" : "showControls"
    "mouseleave" : "hideControls"

  initialize: ->
    if @isNewBookmarkCard()
      @$el.addClass 'new-bookmark ui-state-disabled'
      @$el.html JST["templates/application_assignments/new_card"]()
    else
      @$el.html JST["templates/application_assignments/card"]()
    
  render: ->
    unless @isNewBookmarkCard()
      @$el.data('application-assignment-id', @model.id)
      @$('li').attr('title', @model.get('cached_application').description)
      @$('a').attr('href', @model.get('cached_application').url)
      @$('img').attr('src', @model.get('cached_application').icon_path)
      @$('h4').html @model.get('cached_application').name
    
    @
  
  isFavorite: ->
    @model.get('favorite')

  # One card will not have a model. This is the 'New Bookmark' card found at the end of the grid.
  isNewBookmarkCard: ->
    not @model

  showControls: ->
    @$(".delayed-links").delay(1000).fadeIn() if @model && @model.get("bookmark")

  hideControls: ->
    @$(".delayed-links").delay(200).fadeOut()

  newBookmark: ->
    window.location.hash = "#/newBookmark" if @isNewBookmarkCard()

  edit: ->
    console.log "edit"

  delete: ->
    console.log "delete"