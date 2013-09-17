DssPortal.Views.ApplicationAssignmentsIndex = Backbone.View.extend(
  tagName: "div"
  id: "applicationAssignments"
  className: "row-fluid"
  
  initialize: (options) ->
    @$el.html JST["templates/application_assignments/index"]()
    
  render: ->
    @
)
