DssPortal.Models.ApplicationAssignment = Backbone.Model.extend({})

DssPortal.Collections.ApplicationAssignments = Backbone.Collection.extend(
  model: DssPortal.Models.ApplicationAssignment
  url: Routes.application_assignments_path()
)
