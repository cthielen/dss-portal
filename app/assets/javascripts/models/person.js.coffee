DssPortal.Models.Person = Backbone.Model.extend
  urlRoot: '/people'

  toJSON: ->
    json = {}

    # # Note we use Rails' nested attributes here
    # if @get('application_assignments').length
    #   json.application_assignments_attributes = @get('application_assignments').map (assignment) =>
    #     id: assignment.get('id')
    #     favorite: assignment.get('entity_id')
    #     role_id: @get('id')
    #     _destroy: assignment.get('_destroy')

    person: json
