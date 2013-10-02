DssPortal.Models.ApplicationAssignment = Backbone.Model.extend(
  defaults:
    name: null
    description: null
    url: null
    cached_application:
      name: null
      url: null
)
DssPortal.Collections.ApplicationAssignments = Backbone.Collection.extend(
  model: DssPortal.Models.ApplicationAssignment
  url: Routes.application_assignments_path()
  
  comparator: (assignment) ->
    assignment.get('position')
)
