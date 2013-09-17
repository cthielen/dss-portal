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
    _.each @assignmentCardViews, (card) =>
      @$('#applications').append card.render().$el
    @
)
