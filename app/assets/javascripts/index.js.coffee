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
#   $("li").tooltip()
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
