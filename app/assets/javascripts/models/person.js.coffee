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
    
    $('ul#applications>li:not(.new-bookmark)').each (i, el) =>
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
      if assignment.get('cached_application').url
        assignment.set
          favorite: assignments[assignment.id].favorite
          position: assignments[assignment.id].position

    # Sort, then trigger a save
    @applicationAssignments.sort()
    @save()
  
  parse: (response) ->
    @applicationAssignments.reset response.application_assignments
  
  toJSON: ->
    json = {}

    # Note we use Rails' nested attributes here
    if @applicationAssignments.length
      json.application_assignments_attributes = @applicationAssignments.map (assignment) =>
        node = {}
        if assignment.get('bookmark') is true
          node.cached_application_attributes = {
            id: assignment.get('cached_application').id
            url: assignment.get('cached_application').url
            name: assignment.get('cached_application').name
            icon_path: assignment.get('cached_application').icon_path
          }
        node.id= assignment.get('id')
        node.favorite = assignment.get('favorite')
        node.position = assignment.get('position')
        node.bookmark = assignment.get('bookmark')
        node._destroy = assignment.get('_destroy')
        node

    person: json
