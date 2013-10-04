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
      # Prepend 'http://' for urls that do not specify to force absolute urls
      if @model.get('cached_application').url.slice(0,4) is 'http'
        href = @model.get('cached_application').url
      else
        href = 'http://' + @model.get('cached_application').url

      @$el.data('application-assignment-id', @model.id)
      @$('li').attr('title', @model.get('cached_application').description)
      @$('a').attr('href', href)
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

  edit: ->
    window.location.hash = "#/bookmarks/#{@model.get('id')}/edit"

  delete: ->
    bootbox.confirm "Are you sure you want to delete <strong>" + @model.get('cached_application').name + "</strong>?", (result) =>
      if result
        # delete the bookmark and remove card
        @model.destroy()
        @el.remove()
        # dismiss the dialog
        @$(".modal-header a.close").trigger "click"

