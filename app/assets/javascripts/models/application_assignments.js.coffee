DssPortal.Models.ApplicationAssignment = Backbone.Model.extend(
  url: Routes.application_assignments_path()

  defaults:
    name: null
    description: null
    url: null
    cached_application:
      name: null
      url: null
  
  toJSON: ->
    json = {}

    if @get('bookmark') is true
      json.cached_application_attributes = {
        url: @get('cached_application').url
        name: @get('cached_application').name
        icon_path: @get('cached_application').icon_path
      }
    
    json.id = @get('id') if @id
    json.person_id = DssPortal.current_user.id
    json.favorite = @get('favorite')
    json.position = @get('position')
    json.bookmark = @get('bookmark')
    
    application_assignment: json
  
)

DssPortal.Collections.ApplicationAssignments = Backbone.Collection.extend(
  model: DssPortal.Models.ApplicationAssignment
  url: Routes.application_assignments_path()
  
  comparator: (assignment) ->
    assignment.get('position')
)
