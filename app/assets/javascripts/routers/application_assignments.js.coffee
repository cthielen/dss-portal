DssPortal.Routers.ApplicationAssignments = Backbone.Router.extend(
  initialize: (options) ->
    @indexView = new DssPortal.Views.ApplicationAssignmentsIndex().render()
    $("#applicationAssignments").replaceWith @indexView.el

  routes:
    ""                   : "index"
    "bookmarks/:id/edit" : "editBookmark"

  index: ->

  editBookmark: (bookmark_id) ->
    bookmark_id = parseInt(bookmark_id)
    
    # TODO: Write me.
)
