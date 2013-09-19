DssPortal.Views.ApplicationAssignmentsIndex = Backbone.View.extend(
  tagName: "div"
  id: "applicationAssignments"
  className: "row-fluid"
  
  initialize: ->
    @assignmentCardViews = []
    
    @$el.html JST["templates/application_assignments/index"]()
    
    window.DssPortal.applicationAssignments.each (assignment) =>
      if assignment.get('url')
        assignmentView = new DssPortal.Views.ApplicationAssignmentCard({model: assignment})
        @assignmentCardViews.push assignmentView
    
  render: ->
    @$('#favorites').empty()
    @$('#applications').empty()
    
    @$('#favorites').html '<span id="favorites-hint">Drag favorite applications here for quick access</span>'
    
    _.each @assignmentCardViews, (card) =>
      if card.isFavorite()
        @$('#favorites span').remove()
        @$('#favorites').append card.render().$el
      else
        @$('#applications').append card.render().$el

    @
)
