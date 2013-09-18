DssPortal.Views.ApplicationAssignmentCard = Backbone.View.extend(
  tagName: "li"
  id: ""
  className: "card"
  
  initialize: ->
    @$el.html JST["templates/application_assignments/card"]()
    
  render: ->
    @$('li').attr('title', @model.get('description'))
    @$('a').attr('href', @model.get('url'))
    @$('img').attr('src', @model.get('icon'))
    @$('h4').html @model.get('name')
    @
)
