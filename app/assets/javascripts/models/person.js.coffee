DssPortal.Models.Person = Backbone.Model.extend
  urlRoot: '/people'
  
  initialize: ->
    # Ensure application_assignments is used as a collection, not a model attribute
    @applicationAssignments = new DssPortal.Collections.ApplicationAssignments
    @applicationAssignments.reset @get('application_assignments')
    delete @attributes.application_assignments
    
    @on 'change', @savePerson, this
  
  savePerson: ->
    console.log 'saving a person'

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
