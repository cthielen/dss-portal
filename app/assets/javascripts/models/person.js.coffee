DssPortal.Models.Person = Backbone.Model.extend
  urlRoot: '/people'
  
  initialize: ->
    # Ensure application_assignments is used as a collection, not a model attribute
    @applicationAssignments = new DssPortal.Collections.ApplicationAssignments
    @applicationAssignments.reset @get('application_assignments')
    delete @attributes.application_assignments
  
  syncAssignmentPositions: ->
    assignments = []
    
    # Obtain assignment order from the DOM
    
    $('ul#applications>li').each (i, el) =>
      pos = i + 1 # jQuery starts counting at 0, our backend starts at 1
      assignment_id = $(el).data('application-assignment-id')
      assignments[assignment_id] = {}
      assignments[assignment_id].position = pos
      assignments[assignment_id].favorite = false
      undefined
      
    $('ul#favorites>li').each (i, el) =>
      pos = i + 1 # jQuery starts counting at 0, our backend starts at 1
      assignment_id = $(el).data('application-assignment-id')
      assignments[assignment_id] = {}
      assignments[assignment_id].position = pos
      assignments[assignment_id].favorite = true
      undefined
    
    # Update the collection with information gathered from the DOM above
    @applicationAssignments.each (assignment) =>
      if assignment.get('url')
        assignment.set
          favorite: assignments[assignment.id].favorite
          position: assignments[assignment.id].position
        ,
          silent: true
    
    # Trigger a save
    @save()
  
  toJSON: ->
    json = {}

    # Note we use Rails' nested attributes here
    if @applicationAssignments.length
      json.application_assignments_attributes = @applicationAssignments.map (assignment) =>
        id: assignment.get('id')
        favorite: assignment.get('favorite')
        position: assignment.get('position')
        _destroy: assignment.get('_destroy')

    person: json
