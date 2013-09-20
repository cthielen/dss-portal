DssPortal.Views.ApplicationAssignmentsIndex = Backbone.View.extend(
  tagName: "div"
  id: "applicationAssignments"
  className: "row-fluid"
  
  initialize: ->
    @assignmentCardViews = []
    
    @$el.html JST["templates/application_assignments/index"]()
    
    # Create views for each favorite/bookmark but only if they have a URL
    window.DssPortal.applicationAssignments.each (assignment) =>
      if assignment.get('url')
        assignmentView = new DssPortal.Views.ApplicationAssignmentCard({model: assignment})
        @assignmentCardViews.push assignmentView
    
    @newBookmarkView = new DssPortal.Views.ApplicationAssignmentCard()
    
  render: ->
    # Empty both card container areas
    @$('#favorites').empty()
    @$('#applications').empty()
    
    # Insert the favorites hint text. It will be removed if any favorites exist
    @$('#favorites').html '<span id="favorites-hint">Drag favorite applications here for quick access</span>'
    
    # Render all cards, both favorites and regular
    _.each @assignmentCardViews, (card) =>
      if card.isFavorite()
        @$('#favorites span').remove()
        @$('#favorites').append card.render().$el
      else
        @$('#applications').append card.render().$el
    
    # Render the 'New Bookmark' card. It is always at the end
    @$('#applications').append @newBookmarkView.render().$el
    
    @
)
