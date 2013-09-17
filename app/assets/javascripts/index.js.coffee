# Drawing Content to page

# Fill out applications

# Fill out favorites

# Applies styled tooltips on application cards

#processing user input
#or greater than any other relative/absolute/fixed elements and droppables

#ON HOVER - apply dropshadow, make relevant UI elemnts appear

#      $(this).find("button").css({visibility: 'visible'});

#      $(this).find("button").css({visibility: 'hidden'});

#ON DRAG 

#insert newly created card into list

# jQuery ->
#   $("a[rel=popover]").popover()
#   $(".tooltip").tooltip()
#   $("a[rel=tooltip]").tooltip()
# 
# window.DssPortal = {}
# 
# # Reset interface to be ready for new applications       
# SendState = ->
#   i = 1
#   $("#favorites li").each ->
#     app_id = $(this).attr("id")
#     position = i
#     favorite = "true"
#     i++
#     updateAssignment(app_id, position, favorite)
# 
#   i = 1
#   $("#applications li").each ->
#     app_id = $(this).attr("id")
#     position = i
#     favorite = "false"
#     i++
#     updateAssignment(app_id, position, favorite)
# 
# updateAssignment = (app_id, position, favorite) ->
#   application_assignment = 
#     id: app_id
#     position: position
#     favorite: favorite
#   pobj = application_assignment: application_assignment
#   $.ajax
#     type: "PUT"
#     url: "/application_assignments/" + app_id
#     data: JSON.stringify(pobj)
#     complete: ->
#       $(".ui-tooltip").remove()
# 
#     dataType: "json"
#     contentType: "application/json"
# 
# 
# 
# $(window).load ->
#   _.templateSettings = interpolate: /\{\{(.+?)\}\}/g
#   appTemplate = _.template(" <li class=\"card\" id=\"{{id}}\" title=\"{{ description }}\"><span><img src=\"{{icon}}\"><a href=\"{{ url }}\"><h4>{{ name }}</h4></span><span class=\"link\"></span></a></li>")
#   bookmarkTemplate = _.template(" <li class=\"card\" id=\"{{id}}\" title=\"{{ description }}\"><span class=\"content\"><img src=\"{{icon}}\"><a href=\"{{ url }}\"><h4>{{ name }}</h4><span class=\"link\"></span></a></span><span class=\"edit-form\"><input class=\"editor-name\" value=\"{{ name }}\" type=\"text\"><input class=\"editor-description\" value=\"{{ description }}\" type=\"text\"><input class=\"editor-url\" value=\"{{ url }}\" type=\"text\"><button class=\"editor-save btn btn-success btn-mini\"><i class=\"icon-white icon-ok\"></i> Save</button><button class=\"btn btn-danger btn-mini editor-delete\"><i class=\"icon-white icon-trash\"></i> Delete</button></span></li>")
#   i = 0
# 
#   while i < DssPortal.apps.length
#     if (DssPortal.apps[i].bookmark) is true
#       $("#applications").append bookmarkTemplate(DssPortal.apps[i])
#     else
#       $("#applications").append appTemplate(DssPortal.apps[i])
#     i++
#   i = 0
# 
#   while i < DssPortal.favorites.length
#     if (DssPortal.favorites[i].bookmark) is true
#       $("#favorites").append bookmarkTemplate(DssPortal.favorites[i])
#     else
#       $("#favorites").append appTemplate(DssPortal.favorites[i])
#     i++
#   $("#applications").append " <li class=\"card ui-state-disabled\" id=\"\" title=\"\"><span class=\"create-content\"><button class=\"create-toggle btn btn-success btn-large\"><i class=\"icon-white icon-plus\"></i></button><h4>Create Application Bookmark</h4></span><span class=\"create-form\"><input class=\"create-name\" placeholder=\"Name\" type=\"text\"><input class=\"create-description\" placeholder=\"Description\" type=\"text\"><input class=\"create-url\" placeHolder=\"website URL\" type=\"text\"><button class=\"create btn btn-success btn-mini\"><i class=\"icon-white icon-ok\"></i> Create</button></span></li>"
#   $("li").tooltip()
#   $("#favorites, #applications").sortable
#     distance: 15
#     delay: 300
#     placeholder: "target"
#     forcePlaceholderSize: true
#     zIndex: 10000
#     items: "li:not(.ui-state-disabled)"
#     stop: (event, ui) ->
#       SendState()
# 
# 
#     connectWith: ".connectedSortable"
# 
#   $("li").hover (->
#     $(this).addClass "hover-card"
#   ), ->
#     $(this).removeClass "hover-card"
# 
#   $("#applications li, #favorites li").mousedown ->
#     $(this).removeClass "hover-card"
#     $(this).addClass "dragging-card"
# 
#   $("li").mouseup ->
#     $(this).removeClass "dragging-card"
#     $(this).removeClass "hover-card"
# 
#   $(".editor-toggle").click ->
#     $(".edit-form").toggle()
#     $(this).toggleClass "active"
#     $(".content").toggle()
#     $(".content .link").toggle()
#     if $(".content").parent().tooltip("option", "disabled")
#       $(".content").parent().tooltip "option",
#         disabled: false
# 
#     else
#       $(".card").tooltip "option",
#         disabled: true
# 
# 
#   $(".editor-save").click ->
#     id = $(this).parent().parent().attr("id")
#     name = $(this).parent().children(".editor-name").val()
#     description = $(this).parent().children(".editor-description").val()
#     url = $(this).parent().children(".editor-url").val()
#     application_assignment =
#       name: name
#       description: description
#       url: url
# 
#     data =
#       id: id
#       application_assignment: application_assignment
# 
#     $.ajax
#       type: "PUT"
#       url: "/application_assignments/" + id
#       data: JSON.stringify(data)
#       dataType: "json"
#       contentType: "application/json"
# 
#     $(this).parent().parent().children("a").attr "href", url
#     $(this).parent().parent().attr "title", description
#     $(this).parent().parent().find("h4").text name
# 
#   $(".create-toggle").click ->
#     $(".create-content").toggle()
#     $(".create-form").toggle()
# 
#   $(".create").click ->
#     name = $(this).parent().children(".create-name").val()
#     description = $(this).parent().children(".create-description").val()
#     url = $(this).parent().children(".create-url").val()
#     application_assignment =
#       name: name
#       description: description
#       url: url
# 
#     $.ajax
#       type: "POST"
#       url: "/application_assignments/"
#       data: JSON.stringify(application_assignment)
#       dataType: "json"
#       contentType: "application/json"
# 
#     $(this).parent().children(".create-name").val ""
#     $(this).parent().children(".create-description").val ""
#     $(this).parent().children(".create-url").val ""
#     $(".create-content").toggle()
#     $(".create-form").toggle()
# 
#   $(".editor-delete").click ->
#     id = $(this).parent().parent().attr("id")
#     $.ajax
#       type: "DELETE"
#       url: "/application_assignments/" + id
#       data: JSON.stringify(id)
#       dataType: "json"
#       contentType: "application/json"
# 
#     $(this).closest("li").remove()
