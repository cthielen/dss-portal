window.DssPortal =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  
  initialize: (data) ->
    @applicationAssignments = new DssPortal.Collections.ApplicationAssignments data.application_assignments
    @current_user = new DssPortal.Models.Person data.current_user
    
    # Create a view state to be shared amongst all views
    #@view_state = new DssPortal.Models.ViewState()
    
    @router = new DssPortal.Routers.ApplicationAssignments()
    
    unless Backbone.history.started
      Backbone.history.start()
      Backbone.history.started = true
    
    # Enable tooltips globally
    #$("body").tooltip
      #selector: '[rel=tooltip]'
    
    # Prevent body scrolling when modal is open
    # $("body").on "shown", (e) ->
    #   class_attr = $(e.target).attr('class')
    #   if class_attr and class_attr.indexOf("modal") != -1
    #     $("body").css('overflow', 'hidden')
    # $("body").on "hidden", (e) ->
    #   class_attr = $(e.target).attr('class')
    #   if class_attr and class_attr.indexOf("modal") != -1
    #     $("body").css('overflow', 'visible')
