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

jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

window.DssPortal = {}

# Reset interface to be ready for new applications       
SendState = ->
  pageLayout = []
  appStructure = undefined
  i = 1
  $("#sortableFav li").each ->
    id = $(this).attr("id")
    appStructure =
      position: i
      app_id: id
      favorite: "true"

    i++
    pageLayout.push appStructure

  i = 1
  $("#sortableApp li").each ->
    id = $(this).attr("id")
    appStructure =
      position: i
      app_id: id
      favorite: "false"

    i++
    pageLayout.push appStructure  if id.length >= 1

  pobj = pageLayout: pageLayout
  $.ajax
    type: "POST"
    url: "/application_assignments/drag_update"
    data: JSON.stringify(pobj)
    complete: ->
      $(".ui-tooltip").remove()

    dataType: "json"
    contentType: "application/json"

$(window).load ->
  _.templateSettings = interpolate: /\{\{(.+?)\}\}/g
  appTemplate = _.template(" <li class=\"card\" id=\"{{id}}\" title=\"{{ description }}\"><span><img src=\"{{image}}\"><a href=\"{{ url }}\"><h4>{{ name }}</h4></span><span class=\"link\"></span></a></li>")
  bookmarkTemplate = _.template(" <li class=\"card\" id=\"{{id}}\" title=\"{{ description }}\"><span class=\"content\"><img src=\"{{image}}\"><a href=\"{{ url }}\"><h4>{{ name }}</h4><span class=\"link\"></span></a></span><span class=\"edit-form\"><input class=\"editor-name\" value=\"{{ name }}\" type=\"text\"><input class=\"editor-description\" value=\"{{ description }}\" type=\"text\"><input class=\"editor-url\" value=\"{{ url }}\" type=\"text\"><button class=\"editor-save btn btn-success btn-mini\"><i class=\"icon-white icon-ok\"></i> Save</button><button class=\"btn btn-danger btn-mini editor-delete\"><i class=\"icon-white icon-trash\"></i> Delete</button></span></li>")
  i = 0

  while i < DssPortal.apps.length
    if (DssPortal.apps[i].bookmark) is true
      $("#sortableApp").append bookmarkTemplate(DssPortal.apps[i])
    else
      $("#sortableApp").append appTemplate(DssPortal.apps[i])
    i++
  i = 0

  while i < DssPortal.favorites.length
    if (DssPortal.favorites[i].bookmark) is true
      $("#sortableFav").append bookmarkTemplate(DssPortal.favorites[i])
    else
      $("#sortableFav").append appTemplate(DssPortal.favorites[i])
    i++
  $("#sortableApp").append " <li class=\"card\" id=\"\" title=\"\"><span class=\"create-content\"><button class=\"create-toggle btn btn-success btn-large\"><i class=\"icon-white icon-plus\"></i></button><h4>Create Application Bookmark</h4></span><span class=\"create-form\"><input class=\"create-name\" placeholder=\"Name\" type=\"text\"><input class=\"create-description\" placeholder=\"Description\" type=\"text\"><input class=\"create-url\" placeHolder=\"website URL\" type=\"text\"><button class=\"create btn btn-success btn-mini\"><i class=\"icon-white icon-ok\"></i> Create</button></span></li>"
  $("li").tooltip()
  $("#sortableFav, #sortableApp").sortable
    distance: 15
    delay: 300
    placeholder: "target"
    forcePlaceholderSize: true
    zIndex: 10000
    items: "li:not(:last-child)"
    stop: (event, ui) ->
      SendState()

    connectWith: ".connectedSortable"

  $("li").hover (->
    $(this).addClass "hover-card"
  ), ->
    $(this).removeClass "hover-card"

  $("#sortableApp li, #sortableFav li").mousedown ->
    $(this).removeClass "hover-card"
    $(this).addClass "dragging-card"

  $("li").mouseup ->
    $(this).removeClass "dragging-card"
    $(this).removeClass "hover-card"

  $(".editor-toggle").click ->
    $(".edit-form").toggle()
    $(this).toggleClass "active"
    $(".content").toggle()
    $(".content .link").toggle()
    if $(".content").parent().tooltip("option", "disabled")
      $(".content").parent().tooltip "option",
        disabled: false

    else
      $(".card").tooltip "option",
        disabled: true


  $(".editor-save").click ->
    id = $(this).parent().parent().attr("id")
    name = $(this).parent().children(".editor-name").val()
    description = $(this).parent().children(".editor-description").val()
    url = $(this).parent().children(".editor-url").val()
    application_assignment =
      name: name
      description: description
      url: url

    data =
      id: id
      application_assignment: application_assignment

    $.ajax
      type: "PUT"
      url: "/application_assignments/" + id
      data: JSON.stringify(data)
      dataType: "json"
      contentType: "application/json"

    $(this).parent().parent().children("a").attr "href", url
    $(this).parent().parent().attr "title", description
    $(this).parent().parent().find("h4").text name

  $(".create-toggle").click ->
    $(".create-content").toggle()
    $(".create-form").toggle()

  $(".create").click ->
    name = $(this).parent().children(".create-name").val()
    description = $(this).parent().children(".create-description").val()
    url = $(this).parent().children(".create-url").val()
    application_assignment =
      name: name
      description: description
      url: url

    $.ajax
      type: "POST"
      url: "/application_assignments/"
      data: JSON.stringify(application_assignment)
      dataType: "json"
      contentType: "application/json"

    $(this).parent().children(".create-name").val ""
    $(this).parent().children(".create-description").val ""
    $(this).parent().children(".create-url").val ""
    $(".create-content").toggle()
    $(".create-form").toggle()

  $(".editor-delete").click ->
    id = $(this).parent().parent().attr("id")
    $.ajax
      type: "DELETE"
      url: "/application_assignments/" + id
      data: JSON.stringify(id)
      dataType: "json"
      contentType: "application/json"

    $(this).closest("li").remove()
