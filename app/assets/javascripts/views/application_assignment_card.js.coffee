DssPortal.Views.ApplicationAssignmentCard = Backbone.View.extend
  tagName: "li"
  id: ""
  className: "card"
  
  events:
    "click .icon-pencil": "edit"
    "click .icon-trash": "delete"
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
      @$('li').attr('title', @model.get('description'))
      @$('a').attr('href', @model.get('url'))
      @$('img').attr('src', @model.get('icon'))
      @$('h4').html @model.get('name')
    
    @
  
  isFavorite: ->
    @model.get('favorite')

  # One card will not have a model. This is the 'New Bookmark' card found at the end of the grid.
  isNewBookmarkCard: ->
    not @model

  showControls: ->
    @$(".delayed-links").delay(1000).fadeIn()

  hideControls: ->
    @$(".delayed-links").delay(1000).fadeOut()

  edit: ->
    console.log "edit"

  delete: ->
    console.log "delete"