DssPortal.Routers.ApplicationAssignments = Backbone.Router.extend
  initialize: (options) ->
    @indexView = new DssPortal.Views.ApplicationAssignmentsIndex().render()
    $("#applicationAssignments").replaceWith @indexView.el

  routes:
    ""                   : "index"
    "bookmarks/:id/edit" : "editBookmark"
    "bookmarks/new"        : "newBookmark"

  index: ->

  newBookmark: ->
    @view = new DssPortal.Views.BookmarkForm()
    new Backbone.BootstrapModal(content: @view, title: "New Bookmark", okText: "Create").open()

  editBookmark: (bookmark_id) ->
    bookmark_id = parseInt(bookmark_id)
    
    @view = new DssPortal.Views.BookmarkForm(id: bookmark_id)
    new Backbone.BootstrapModal(content: @view, title: "Edit Bookmark", okText: "Submit").open()
