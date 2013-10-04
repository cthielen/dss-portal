DssPortal.Views.ApplicationAssignmentsIndex = Backbone.View.extend
  tagName: "div"
  id: "applicationAssignments"
  className: "row-fluid"
  
  events:
    "click .new-bookmark": "newBookmark"
    "keyup #search" : "searchCards"

  initialize: ->
    @$el.html JST["templates/application_assignments/index"]()
    
    # @listenTo DssPortal.current_user, "sync", @render
    @listenTo DssPortal.current_user.applicationAssignments, "add", @renderAndAppendNewBookmark
    
    @newBookmarkView = new DssPortal.Views.ApplicationAssignmentCard()
  
    $(document).ready =>
      @$('#favorites, #applications').sortable
        distance: 10
        delay: 200
        cursor: "move"
        items: "li:not(.ui-state-disabled)"
        placeholder: "target"
        update: (event, ui) ->
          DssPortal.current_user.syncAssignmentPositions() if this is ui.item.parent()[0]
        over: (event, ui) ->
          if ui.placeholder.parent()[0].id == "favorites"
            $('#favorites>span').remove()             
        out: (event, ui) ->
          if $('#favorites li').length < 1
            $('#favorites').html '<span id="favorites-hint">Drag favorite applications here for quick access</span>'
        connectWith: ".connectedSortable"
    
  # Note: This 'render' is designed to only be called once, else the new views will leak memory.
  render: ->
    # Empty both card container areas
    @$('#favorites').empty()
    @$('#applications').empty()
    
    # Insert the favorites hint text. It will be removed if any favorites exist
    @$('#favorites').html '<span id="favorites-hint">Drag favorite applications here for quick access</span>'
    
    # Render all cards, both favorites and regular
    DssPortal.current_user.applicationAssignments.each (assignment) =>
      if assignment.get('cached_application').url
        view = new DssPortal.Views.ApplicationAssignmentCard({model: assignment})
        if view.isFavorite()
          @$('#favorites>span').remove()
          @$('#favorites').append view.render().$el
        else
          @$('#applications').append view.render().$el
    
    # Render the 'New Bookmark' card. It is always at the end
    @$('#applications').append @newBookmarkView.render().$el
    @
  
  renderAndAppendNewBookmark: (assignment) ->
    view = new DssPortal.Views.ApplicationAssignmentCard({model: assignment})
    @$('#applications li.new-bookmark').before view.render().$el

  newBookmark: ->
    window.location.hash = "#/bookmarks/new"

  searchCards: ->
    $('li.card').show()
    $('li.card span a h4').each ->
      $(this).closest('li.card').hide() if $(this).text().toLowerCase().indexOf($('input#search').val().toLowerCase()) is -1
