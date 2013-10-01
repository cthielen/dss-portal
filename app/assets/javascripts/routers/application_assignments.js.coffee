DssPortal.Routers.ApplicationAssignments = Backbone.Router.extend
  initialize: (options) ->
    @indexView = new DssPortal.Views.ApplicationAssignmentsIndex().render()
    $("#applicationAssignments").replaceWith @indexView.el

  routes:
    ""                   : "index"
    "bookmarks/:id/edit" : "editBookmark"
    "newBookmark"        : "newBookmark"

  index: ->

  newBookmark: ->
    @person = DssPortal.current_user
    @view = new DssPortal.Views.NewBookmark(person: @person)
    modal = new Backbone.BootstrapModal(content: @view, title: "New Bookmark", cancelText: false, okText: "Create").open()

  editBookmark: (bookmark_id) ->
    bookmark_id = parseInt(bookmark_id)
    
    # TODO: Write me.
